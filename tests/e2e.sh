#!/usr/bin/env bash
#
# End-to-end validation for skillrc.
#
# Verifies the manifest is internally consistent and that BOTH modes are
# executable by a real agent:
#   A. Structural consistency  — links resolve both ways, every entry has all
#                                template fields, INDEX rows agree with the
#                                per-skill files (compatibility + stars), no
#                                leaked placeholders.
#   B. Self-iterate mode       — every Repo: line parses to owner/repo and the
#                                GitHub repo is confirmed live (positive signal);
#                                documented stars are sanity-checked vs the API.
#   C. Install mode            — every entry has a runnable command for EACH
#                                agent it claims, and directory/index entries
#                                are explicitly labeled.
#   D. Tooling                 — scripts/discover.sh is syntactically valid.
#
# Usage:   bash tests/e2e.sh
# Network: set GITHUB_TOKEN to avoid API rate limits. Section B degrades
#          gracefully (skips, does not fail) when GitHub is unreachable, so the
#          structural suite still runs fully offline.
#
# Exit code: 0 if no FAIL, 1 otherwise. WARNs never fail the build.
# Compatible with bash 3.2 (macOS default) — no associative arrays.

set -uo pipefail
cd "$(dirname "$0")/.."

pass=0; fail=0; warn=0
red=$'\033[31m'; grn=$'\033[32m'; ylw=$'\033[33m'; rst=$'\033[0m'
ok()  { printf "  ${grn}PASS${rst} %s\n" "$*"; pass=$((pass+1)); }
bad() { printf "  ${red}FAIL${rst} %s\n" "$*"; fail=$((fail+1)); }
wrn() { printf "  ${ylw}WARN${rst} %s\n" "$*"; warn=$((warn+1)); }
hdr() { printf "\n== %s ==\n" "$*"; }

# Derive the skill list from the filesystem so a newly added skills/*.md file
# is automatically covered (no hand-maintained list to drift out of sync).
ALL=""
for f in skills/*.md; do
  b=$(basename "$f" .md)
  [ "$b" = "INDEX" ] && continue
  ALL="$ALL $b"
done
ALL=$(printf '%s' "$ALL" | sed 's/^ //')

# Directory/index entries are catalogs, not installable bundles (no single command).
DIRECTORY="awesome-agent-skills extra-awesome-mcp-servers extra-antigravity-awesome-skills extra-awesome-claude-skills"
is_directory() { case " $DIRECTORY " in *" $1 "*) return 0;; *) return 1;; esac; }

# Normalize a star token to a bare number+unit, e.g. "~245k (as of 2026-07)" -> "245k".
norm_star() { printf '%s' "$1" | grep -oE '[0-9]+(\.[0-9]+)?k?' | head -1; }

# ---------------------------------------------------------------------------
hdr "A. Structural consistency"

# A1. Every skill file exists and carries all template fields.
missing_field=0
for s in $ALL; do
  fp="skills/$s.md"
  for field in "Category:" "What it does:" "Repo:" "Compatibility:" "Install:" "Verify:" "Stars:"; do
    grep -q "$field" "$fp" || { bad "$s.md missing template field: $field"; missing_field=1; }
  done
done
[ "$missing_field" -eq 0 ] && ok "all entries carry the full template ($(printf '%s' "$ALL" | wc -w | tr -d ' ') files)"

# A2. Bidirectional link integrity: every INDEX table link resolves to a file,
# and every skill file is linked from INDEX (no orphans).
idx_slugs=$(grep '^|' skills/INDEX.md | grep -oE '\]\(\./((extra-)?[a-z0-9-]+)\.md\)' \
  | sed -E 's#\]\(\./##; s#\.md\)##' | sort -u)
fs_slugs=$(printf '%s\n' $ALL | sort -u)
link_bad=0
for slug in $idx_slugs; do
  [ -f "skills/$slug.md" ] || { bad "INDEX links a missing file: skills/$slug.md"; link_bad=1; }
done
for slug in $fs_slugs; do
  printf '%s\n' "$idx_slugs" | grep -qx "$slug" || { bad "orphan file not linked from INDEX: skills/$slug.md"; link_bad=1; }
done
[ "$link_bad" -eq 0 ] && ok "INDEX <-> files link set matches both ways ($(printf '%s' "$idx_slugs" | wc -w | tr -d ' ') slugs)"

# A3. INDEX rows agree with the per-skill files on compatibility + stars
# (CONTRIBUTING says they "must match exactly" — enforce it, don't just assert it).
consistency_bad=0
while IFS= read -r row; do
  case "$row" in \|*) : ;; *) continue ;; esac
  printf '%s' "$row" | grep -q '\](\./.*\.md)' || continue
  slug=$(printf '%s' "$row" | grep -oE '\./((extra-)?[a-z0-9-]+)\.md' | head -1 | sed -E 's#\./##; s#\.md##')
  fp="skills/$slug.md"
  [ -f "$fp" ] || continue
  # INDEX cells: | # | Skill | Type | CC | Codex | OpenCode | Stars |
  i_cc=$(printf '%s' "$row" | awk -F'|' '{gsub(/[[:space:]]/,"",$5); print $5}')
  i_cx=$(printf '%s' "$row" | awk -F'|' '{gsub(/[[:space:]]/,"",$6); print $6}')
  i_oc=$(printf '%s' "$row" | awk -F'|' '{gsub(/[[:space:]]/,"",$7); print $7}')
  i_st=$(norm_star "$(printf '%s' "$row" | awk -F'|' '{print $8}')")
  # File Compatibility line: "Claude Code X | Codex Y | OpenCode Z"
  cline=$(grep -m1 '\*\*Compatibility:\*\*' "$fp" | sed 's/.*Compatibility:\*\*//')
  f_cc=$(printf '%s' "$cline" | awk -F'|' '{print $1}' | awk '{print $NF}')
  f_cx=$(printf '%s' "$cline" | awk -F'|' '{print $2}' | awk '{print $NF}')
  f_oc=$(printf '%s' "$cline" | awk -F'|' '{print $3}' | awk '{print $NF}')
  f_st=$(norm_star "$(grep -m1 '\*\*Stars:\*\*' "$fp")")
  if [ "$i_cc|$i_cx|$i_oc" != "$f_cc|$f_cx|$f_oc" ]; then
    bad "$slug: compatibility mismatch — INDEX [$i_cc|$i_cx|$i_oc] vs file [$f_cc|$f_cx|$f_oc]"; consistency_bad=1
  fi
  if [ -n "$i_st" ] && [ -n "$f_st" ] && [ "$i_st" != "$f_st" ]; then
    bad "$slug: star mismatch — INDEX '$i_st' vs file '$f_st'"; consistency_bad=1
  fi
done < skills/INDEX.md
[ "$consistency_bad" -eq 0 ] && ok "INDEX rows agree with per-skill files (compatibility + stars)"

# A4. No leaked template placeholders in the entry files.
# (<owner/repo> is intentional instructional prose in directory entries.)
if grep -rqn '<command>\|<symbol>\|<category>\|<Skill Name>\|TBD\|TODO\|FIXME' skills/; then
  bad "leaked template placeholder / TODO in skills/"; grep -rn '<command>\|<symbol>\|<category>\|<Skill Name>\|TBD\|TODO\|FIXME' skills/
else
  ok "no leaked template placeholders in skills/"
fi

# ---------------------------------------------------------------------------
hdr "B. Self-iterate mode (repo liveness + star sanity)"

gh_curl() {
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" "$@"
  else
    curl -s "$@"
  fi
}

online=0
if gh_curl -f https://api.github.com/rate_limit >/dev/null 2>&1; then online=1; fi

if [ "$online" -eq 0 ]; then
  wrn "GitHub API unreachable — skipping liveness/star checks (set GITHUB_TOKEN or check network)"
else
  parse_fail=0
  for s in $ALL; do
    fp="skills/$s.md"
    repo=$(grep -m1 '\*\*Repo:\*\*' "$fp" | grep -oE 'github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | head -1 | sed 's#github.com/##')
    if [ -z "$repo" ]; then bad "$s.md: could not parse owner/repo from Repo: line"; parse_fail=1; continue; fi

    json=$(gh_curl "https://api.github.com/repos/$repo")
    # Require a POSITIVE signal of success. Anything else (404, secondary rate
    # limit, 5xx, empty/truncated body) must not be reported as "live".
    if ! printf '%s' "$json" | grep -q '"full_name"'; then
      if printf '%s' "$json" | grep -q '"message": *"Not Found"'; then
        bad "$s.md: repo $repo returns 404 (renamed/deleted?)"
      else
        wrn "$s.md: could not confirm liveness for $repo (unexpected API response — rate limit?)"
      fi
      sleep 0.4; continue
    fi
    printf '%s' "$json" | grep -q '"archived": *true' && wrn "$s.md: repo $repo is archived"

    live=$(printf '%s' "$json" | grep -oE '"stargazers_count"[[:space:]]*:[[:space:]]*[0-9]+' | head -1 | grep -oE '[0-9]+$')
    stars_line=$(grep -m1 '\*\*Stars:\*\*' "$fp")
    fstar=$(printf '%s' "$stars_line" | grep -oE '~?[0-9]+(\.[0-9]+)?k' | head -1 | tr -d '~k')
    if [ -n "$stars_line" ] && [ -z "$fstar" ]; then
      wrn "$s.md: Stars present but unparseable ('$stars_line') — expected ~Nk"
    elif printf '%s' "$live" | grep -qE '^[0-9]+$' && [ -n "$fstar" ]; then
      fint=$(awk "BEGIN{printf \"%d\", $fstar*1000}")
      hi=$(awk "BEGIN{printf \"%d\", $fint*1.4}"); lo=$(awk "BEGIN{printf \"%d\", $fint*0.6}")
      if [ "$live" -gt "$hi" ] || [ "$live" -lt "$lo" ]; then
        wrn "$s.md: stars drifted — doc ~${fstar}k vs live $live ($repo). Run SELF-UPDATE.md."
      else
        ok "$s.md: $repo live ($live stars, doc ~${fstar}k)"
      fi
    else
      ok "$s.md: $repo live"
    fi
    sleep 0.4
  done
  [ "$parse_fail" -eq 0 ] && ok "owner/repo parsed for every Repo: line"
fi

# ---------------------------------------------------------------------------
hdr "C. Install mode (agent-executability)"

# C1. AGENTS.md directory guidance must name a concrete directory entry (not
# just contain the word "directory" somewhere).
if grep -qiE 'Awesome Agent Skills|Awesome MCP Servers|directory/index entr' AGENTS.md; then
  ok "AGENTS.md directory guidance references a concrete directory entry"
else
  bad "AGENTS.md directory guidance is vague — name a concrete directory entry (e.g. Awesome Agent Skills)"
fi

# C2. Per-entry install commands.
# Counts agent-label lines inside the Install block that have NEITHER an inline
# `command`, NOR a following ``` fenced block, NOR an explicit exemption
# (n/a / only / clone / copy / browse / manual / index / see).
count_bad_install_lines() {
  awk '
    /\*\*Install:\*\*/ {inb=1}
    /\*\*Verify:\*\*/  {if (pending && !sat) bad++; inb=0}
    inb {
      if ($0 ~ /^[[:space:]]*-[[:space:]]+[A-Za-z].*:/ && $0 !~ /\*\*Install/) {
        if (pending && !sat) bad++
        pending=1; sat=0
        if ($0 ~ /`[^`]+`/) sat=1
        low=tolower($0)
        if (low ~ /n\/a|only|clone|copy|browse|manual|index|see /) sat=1
      } else if (pending && !sat && $0 ~ /```/) sat=1
    }
    END { if (pending && !sat) bad++; print bad+0 }
  ' "$1"
}

for s in $ALL; do
  fp="skills/$s.md"
  install=$(awk '/\*\*Install:\*\*/{f=1} f{print} /\*\*Verify:\*\*/{f=0}' "$fp")
  if is_directory "$s"; then
    if printf '%s' "$install" | grep -qi 'director\|index\|no single command'; then
      ok "$s.md: directory entry is labeled (no single command expected)"
    else
      bad "$s.md: directory entry NOT labeled — agent may run a nonexistent command"
    fi
  else
    n_bad=$(count_bad_install_lines "$fp")
    if [ "$n_bad" -eq 0 ]; then
      ok "$s.md: every agent's install line is runnable or explicitly exempt"
    else
      bad "$s.md: $n_bad agent install line(s) have no runnable command/fence/exemption"
    fi
  fi
done

# ---------------------------------------------------------------------------
hdr "D. Tooling"

if bash -n scripts/discover.sh 2>/dev/null; then
  ok "scripts/discover.sh is syntactically valid"
else
  bad "scripts/discover.sh has a syntax error (bash -n failed)"
fi

# ---------------------------------------------------------------------------
hdr "Summary"
printf "  %s%d passed%s, %s%d failed%s, %s%d warnings%s\n" \
  "$grn" "$pass" "$rst" "$red" "$fail" "$rst" "$ylw" "$warn" "$rst"
[ "$fail" -eq 0 ] && { printf "  ${grn}E2E OK${rst}\n"; exit 0; } || { printf "  ${red}E2E FAILED${rst}\n"; exit 1; }
