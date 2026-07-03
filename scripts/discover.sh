#!/usr/bin/env bash
#
# discover.sh — surface NEW candidate skills for a SELF-UPDATE.md run.
#
# What it does (deterministic, repeatable):
#   1. Builds the "already have" set from every skills/*.md Repo: line.
#   2. Queries the GitHub Search API across several angles (topics + keywords
#      that agent-skill repos use).
#   3. Diffs candidates against the have-set (case-insensitive) so nothing
#      already in the manifest is re-surfaced.
#   4. Prints the new candidates ranked by stars, with a cross-agent hint.
#
# It does NOT edit the manifest — discovery is separate from curation. A human
# or an agent running SELF-UPDATE.md §B reviews the list, verifies each pick,
# and adds at most 5 (per the guardrails).
#
# Usage:   bash scripts/discover.sh [MIN_STARS] [TOP_N]
#          MIN_STARS default 500, TOP_N default 25.
# Network: requires GitHub API access. Set GITHUB_TOKEN to avoid rate limits
#          (Search API is only ~10 req/min unauthenticated).
# Deps:    curl, python3 (both present on macOS and ubuntu CI runners).

set -uo pipefail
cd "$(dirname "$0")/.."

MIN_STARS="${1:-500}"
TOP_N="${2:-25}"

gh_curl() {
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" -H "Accept: application/vnd.github+json" "$@"
  else
    curl -s -H "Accept: application/vnd.github+json" "$@"
  fi
}

if ! gh_curl -f https://api.github.com/rate_limit >/dev/null 2>&1; then
  echo "ERROR: GitHub API unreachable. Set GITHUB_TOKEN or check your network." >&2
  exit 1
fi

# 1. Build the have-set: owner/repo (lowercased) from every entry's Repo: line.
have=$(grep -h '\*\*Repo:\*\*' skills/*.md \
  | grep -oE 'github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' \
  | sed 's#github.com/##' \
  | tr '[:upper:]' '[:lower:]' | sort -u)
have_count=$(printf '%s\n' "$have" | grep -c . || true)
echo "Have-set: $have_count repos already in the manifest." >&2

# 2. Query the Search API across several angles. Each returns repos+stars.
QUERIES=(
  "topic:agent-skills"
  "topic:claude-code"
  "topic:claude-skills"
  "topic:agent-skill"
  "agent skills in:name,description,readme"
  "SKILL.md agent in:readme"
)

raw="$(mktemp)"
total_items=0
for q in "${QUERIES[@]}"; do
  # URL-encode the query minimally (space -> +, : stays valid in query string).
  enc=$(printf '%s' "$q" | sed 's/ /+/g')
  before=$(wc -l < "$raw" | tr -d ' ')
  gh_curl "https://api.github.com/search/repositories?q=${enc}&sort=stars&order=desc&per_page=50" \
    | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for it in d.get("items", []):
    if it.get("fork"): continue
    full = it.get("full_name","")
    stars = it.get("stargazers_count",0)
    topics = ",".join(it.get("topics",[]) or [])
    desc = (it.get("description") or "").replace("\t"," ").replace("\n"," ")[:100]
    print(f"{stars}\t{full}\t{topics}\t{desc}")
' >> "$raw"
  after=$(wc -l < "$raw" | tr -d ' ')
  got=$((after - before)); total_items=$((total_items + got))
  echo "  query [$q] -> $got items" >&2   # surface per-query results (0 = failed/rate-limited)
  sleep 1   # be gentle with the Search API rate limit
done

if [ "$total_items" -eq 0 ]; then
  echo "WARNING: all search queries returned 0 items — likely rate-limited or an API change." >&2
  echo "         Results are NOT authoritative; set GITHUB_TOKEN and retry before trusting an empty candidate list." >&2
fi

# 3+4. Dedup, drop have-set, filter by MIN_STARS, rank, print top N.
echo ""
printf "%-8s  %-45s  %s\n" "STARS" "REPO" "CROSS-AGENT? / DESCRIPTION"
printf '%s\n' "----------------------------------------------------------------------------------------------"

# Pass have-set + thresholds into awk; emit ranked, deduped, filtered rows.
have_file="$(mktemp)"
printf '%s\n' "$have" > "$have_file"
sort -t$'\t' -k1 -rn "$raw" | awk -F'\t' -v minstars="$MIN_STARS" -v topn="$TOP_N" -v havefile="$have_file" '
BEGIN {
  while ((getline line < havefile) > 0) { have[tolower(line)] = 1 }
}
{
  stars=$1; repo=$2; topics=$3; desc=$4
  key=tolower(repo)
  if (repo=="" || stars < minstars) next
  if (key in have) next
  if (key in seen) next
  seen[key]=1
  # Relevance gate: the repo (name + topics + description) must actually be
  # about agent skills / coding agents — pure stars sorting otherwise surfaces
  # giant unrelated "awesome" lists. Include the repo name in the haystack:
  # "-skills" / "skill-" in a name is a strong signal.
  hay=tolower(repo " " topics " " desc)
  if (hay !~ /skill|subagent|\.claude|claude-code|claude code|coding agent|agent-skill|slash command|codex|opencode/) next
  # cross-agent hint
  hint="?"
  n=0
  if (hay ~ /claude/) n++
  if (hay ~ /codex/) n++
  if (hay ~ /opencode/) n++
  if (hay ~ /cursor/) n++
  if (n>=2) hint="cross-agent"
  else if (n==1) hint="1-agent?"
  count++
  if (count<=topn) printf "%-8s  %-45s  [%s] %s\n", stars, repo, hint, desc
}
END { printf "\n%d relevant new candidate(s) above %s stars (showing up to %d).\n", (count?count:0), minstars, topn }
'
rm -f "$raw" "$have_file"

cat >&2 <<'EOF'

Next (SELF-UPDATE.md §B): for each candidate you want to keep —
  1. Confirm it's genuinely new and in-scope (cross-agent, fits the profile).
  2. Verify stars + compatibility via the GitHub API / its README (never assume).
  3. Add it via the CONTRIBUTING template; uncertain picks -> "Candidates" section.
  4. Cap at 5 new skills per run.
EOF
