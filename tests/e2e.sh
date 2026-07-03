#!/usr/bin/env bash
#
# End-to-end validation for agent-onboarding-kit.
#
# Verifies the manifest is internally consistent and that BOTH modes are
# executable by a real agent:
#   A. Structural consistency  — links resolve, every entry has all template
#                                fields, no leaked template placeholders.
#   B. Self-iterate mode       — every Repo: line parses to owner/repo and the
#                                GitHub repo is live (not 404 / not archived);
#                                file star counts are sanity-checked vs the API.
#   C. Install mode            — every entry has an Install section; normal
#                                entries expose a runnable command; directory /
#                                index entries are explicitly labeled so an
#                                agent following AGENTS.md does not stall.
#
# Usage:   bash tests/e2e.sh
# Network: set GITHUB_TOKEN to avoid API rate limits. Section B degrades
#          gracefully (skips, does not fail) when GitHub is unreachable, so the
#          structural suite still runs fully offline.
#
# Exit code: 0 if no FAIL, 1 otherwise. WARNs never fail the build.

set -uo pipefail
cd "$(dirname "$0")/.."

pass=0; fail=0; warn=0
red=$'\033[31m'; grn=$'\033[32m'; ylw=$'\033[33m'; rst=$'\033[0m'
ok()  { printf "  ${grn}PASS${rst} %s\n" "$*"; pass=$((pass+1)); }
bad() { printf "  ${red}FAIL${rst} %s\n" "$*"; fail=$((fail+1)); }
wrn() { printf "  ${ylw}WARN${rst} %s\n" "$*"; warn=$((warn+1)); }
hdr() { printf "\n== %s ==\n" "$*"; }

CORE="superpowers superclaude-framework minimax-skills anthropic-official-skills vercel-agent-skills planning-with-files context-engineering-skills composio-skills antfu-skills awesome-agent-skills"
EXTRA="extra-addyosmani-agent-skills extra-skill-creator extra-awesome-mcp-servers extra-antigravity-awesome-skills extra-awesome-claude-skills"
ALL="$CORE $EXTRA"
# Entries that are catalogs, not installable bundles (no single install command).
DIRECTORY="awesome-agent-skills extra-awesome-mcp-servers extra-antigravity-awesome-skills extra-awesome-claude-skills"

is_directory() { case " $DIRECTORY " in *" $1 "*) return 0;; *) return 1;; esac; }

# ---------------------------------------------------------------------------
hdr "A. Structural consistency"

# Every INDEX Details link resolves to a real file.
missing_link=0
for f in $(grep -oE '\(\./((extra-)?[a-z0-9-]+)\.md\)' skills/INDEX.md | sed 's/[()]//g; s#^\./##'); do
  [ -f "skills/$f" ] || { bad "INDEX links a missing file: skills/$f"; missing_link=1; }
done
[ "$missing_link" -eq 0 ] && ok "all INDEX Details links resolve"

# Every expected skill file exists and carries all template fields.
missing_field=0
for s in $ALL; do
  fp="skills/$s.md"
  if [ ! -f "$fp" ]; then bad "missing skill file: $fp"; missing_field=1; continue; fi
  for field in "Category:" "What it does:" "Repo:" "Compatibility:" "Install:" "Verify:" "Stars:"; do
    grep -q "$field" "$fp" || { bad "$s.md missing template field: $field"; missing_field=1; }
  done
done
[ "$missing_field" -eq 0 ] && ok "all 15 entries present with full template ($(echo $ALL | wc -w | tr -d ' ') files)"

# Every INDEX slug is backed by a file and vice-versa (count check).
idx_links=$(grep -oE '\(\./((extra-)?[a-z0-9-]+)\.md\)' skills/INDEX.md | sort -u | wc -l | tr -d ' ')
[ "$idx_links" -ge 15 ] && ok "INDEX links >= 15 entries ($idx_links)" || bad "INDEX links only $idx_links entries (<15)"

# No leaked template placeholders in the entry files.
# NOTE: <owner/repo> is intentional instructional prose in directory entries
# ("npx skills add <owner/repo>"), so it is NOT a leak sentinel — only tokens
# that never legitimately appear in a finished entry are checked here.
if grep -rqn '<command>\|<symbol>\|<category>\|<Skill Name>\|TBD\|TODO\|FIXME' skills/; then
  bad "leaked template placeholder / TODO in skills/"; grep -rn '<command>\|<symbol>\|<category>\|<Skill Name>\|TBD\|TODO\|FIXME' skills/
else
  ok "no leaked template placeholders in skills/"
fi

# ---------------------------------------------------------------------------
hdr "B. Self-iterate mode (repo liveness + star sanity)"

# curl wrapper that adds auth only when a token is set (avoids empty-array
# expansion, which errors under `set -u` on macOS bash 3.2).
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
    # Parse owner/repo from the Repo: line (expects a clean github.com/<owner>/<repo> URL).
    repo=$(grep -m1 '\*\*Repo:\*\*' "$fp" | grep -oE 'github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | head -1 | sed 's#github.com/##')
    if [ -z "$repo" ]; then bad "$s.md: could not parse owner/repo from Repo: line"; parse_fail=1; continue; fi

    json=$(gh_curl "https://api.github.com/repos/$repo")
    if echo "$json" | grep -q '"message": *"Not Found"'; then
      bad "$s.md: repo $repo returns 404 (renamed/deleted?)"; continue
    fi
    if echo "$json" | grep -q '"archived": *true'; then
      wrn "$s.md: repo $repo is archived"
    fi
    # Isolate the integer right after "stargazers_count" — robust to minified
    # (single-line) JSON, where a bare `grep -oE '[0-9]+'` would scrape every
    # number in the whole body.
    live=$(printf '%s' "$json" | grep -oE '"stargazers_count"[[:space:]]*:[[:space:]]*[0-9]+' | head -1 | grep -oE '[0-9]+$')
    # File star value like "~245k" / "~0.1k" -> approximate integer.
    fstar=$(grep -m1 '\*\*Stars:\*\*' "$fp" | grep -oE '~?[0-9]+(\.[0-9]+)?k' | head -1 | tr -d '~k')
    if printf '%s' "$live" | grep -qE '^[0-9]+$' && [ -n "$fstar" ]; then
      # Convert file's k-value to an integer for a loose comparison.
      fint=$(awk "BEGIN{printf \"%d\", $fstar*1000}")
      # Warn if the documented figure is off by more than 40% from live.
      hi=$(awk "BEGIN{printf \"%d\", $fint*1.4}"); lo=$(awk "BEGIN{printf \"%d\", $fint*0.6}")
      if [ "$live" -gt "$hi" ] || [ "$live" -lt "$lo" ]; then
        wrn "$s.md: stars drifted — doc ~${fstar}k vs live $live ($repo). Run SELF-UPDATE.md."
      else
        ok "$s.md: $repo live ($live stars, doc ~${fstar}k)"
      fi
    else
      ok "$s.md: $repo live"
    fi
  done
  [ "$parse_fail" -eq 0 ] && ok "owner/repo parsed for all 15 Repo: lines"
fi

# ---------------------------------------------------------------------------
hdr "C. Install mode (agent-executability)"

# AGENTS.md must acknowledge directory-type entries so the flow does not stall.
if grep -qi 'director' AGENTS.md; then ok "AGENTS.md handles directory/index entries"; else bad "AGENTS.md does not mention directory/index entries — agents will stall on catalogs"; fi

for s in $ALL; do
  fp="skills/$s.md"
  # Grab the Install block (from the Install line to the next top-level "- **" field).
  install=$(awk '/\*\*Install:\*\*/{f=1} f{print} /\*\*Verify:\*\*/{f=0}' "$fp")
  if is_directory "$s"; then
    if echo "$install" | grep -qi 'director\|index\|no single command'; then
      ok "$s.md: directory entry is labeled (no single command expected)"
    else
      bad "$s.md: directory entry NOT labeled — agent may try to run a nonexistent command"
    fi
  else
    # Normal entry must expose at least one runnable-looking command in backticks.
    if echo "$install" | grep -qE '`[^`]*(skills add|plugin install|plugin marketplace|pipx install|git clone|pnpx|superclaude)[^`]*`'; then
      ok "$s.md: has a runnable install command"
    else
      bad "$s.md: no runnable install command found in Install block"
    fi
  fi
done

# ---------------------------------------------------------------------------
hdr "Summary"
printf "  %s%d passed%s, %s%d failed%s, %s%d warnings%s\n" \
  "$grn" "$pass" "$rst" "$red" "$fail" "$rst" "$ylw" "$warn" "$rst"
[ "$fail" -eq 0 ] && { printf "  ${grn}E2E OK${rst}\n"; exit 0; } || { printf "  ${red}E2E FAILED${rst}\n"; exit 1; }
