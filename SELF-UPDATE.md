# SELF-UPDATE.md — Self-Iteration Playbook

## Purpose

You were told to self-iterate this repo. Follow this playbook to refresh existing entries and discover new useful tools, then commit.

This file is the **update** mode; it is the counterpart to [`AGENTS.md`](./AGENTS.md), which is the **install** mode. `AGENTS.md` tells an agent how to read the manifest and install skills into its own environment. `SELF-UPDATE.md` tells an agent how to maintain the manifest itself — re-verify what's already here and add what's missing — so the next agent that reads `AGENTS.md` gets accurate, current data.

## A. Refresh existing entries

For every skill listed in [`skills/INDEX.md`](./skills/INDEX.md) and its corresponding `skills/*.md` file:

1. Extract the `owner/repo` from the file's `Repo:` line and call the GitHub API:
   ```bash
   curl -s https://api.github.com/repos/{owner}/{repo}
   ```
2. Update the `Stars:` field from the response's `stargazers_count`, rounded to ~Nk (e.g. `stargazers_count: 245231` → `~245k`).
3. If the response is `Not Found` (404), the repo has `"archived": true`, or the repo has moved/renamed (the API returns a different `full_name` than expected, or a redirect), **flag it — do not silently delete it**:
   - Add a `> ⚠️ status: <what you found, and the date>` note directly under the title in the `skills/<slug>.md` file.
   - Add the same `⚠️` marker to that skill's row in the `skills/INDEX.md` compatibility matrix.
4. Re-read the repo's README or homepage (whichever the entry links to) to confirm the `Compatibility:` claims (Claude Code / Codex / OpenCode) still hold. If a symbol changed, update it in both the `skills/<slug>.md` file and the matching `skills/INDEX.md` row — they must stay identical, per `CONTRIBUTING.md`.
5. Update every `as of YYYY-MM` stamp you touched — in the entry file, the `skills/INDEX.md` footer, and `README.md` — to the current month.

## B. Discover new tools

Search for new high-value skills, subagents, or rules that fit two constraints at once:

- **Repo scope:** cross-agent tools that work across Claude Code, Codex, and OpenCode (not single-agent-only, unless exceptionally notable).
- **Maintainer profile:** AI / system-architecture / full-stack — favor tools that extend those three hats, the same way the existing "Extra picks" do.

Check these sources:

- `VoltAgent/awesome-agent-skills`
- `addyosmani/agent-skills`
- skills.sh
- GitHub trending / search for "agent skills"

For each genuinely new, verified candidate:

1. Confirm it isn't already covered by an existing `skills/*.md` entry.
2. Verify its star count via the GitHub API (never estimate) and its compatibility by actually checking docs/README (never assume).
3. Create `skills/<slug>.md` (or `skills/extra-<slug>.md` for a supplementary pick) from the entry template in `CONTRIBUTING.md`, filled in completely.
4. Add exactly one row to the correct table in `skills/INDEX.md`, following `CONTRIBUTING.md` step 3.

## C. Guardrails

- Star counts must come from the live GitHub API — never invent or estimate a number.
- Keep the exact entry template from `CONTRIBUTING.md` — same fields, same order, same labels.
- Add **at most 5 new skills per run**, and list each one in the changelog entry.
- Prefer cross-agent tools (works across Claude Code, Codex, OpenCode) over single-agent-only tools.
- When unsure whether a tool belongs in the main tables, do not add it there — add it to a `## Candidates (needs human review)` section at the bottom of `skills/INDEX.md` instead, with the repo link and a one-line reason for the uncertainty.

## D. Consistency check

Before committing, run the same structural checks used elsewhere in this repo:

```bash
# every INDEX link resolves to a file
grep -oE '\(\./([a-z0-9-]+)\.md\)' skills/INDEX.md | sed 's/[()]//g; s/^\.\///' | while read f; do test -f "skills/$f" || echo "BROKEN LINK: $f"; done

# every skill file has all template fields
for f in skills/*.md; do
  [ "$f" = "skills/INDEX.md" ] && continue
  grep -q "Compatibility:" "$f" && grep -q "Install:" "$f" && grep -q "Verify:" "$f" && grep -q "Stars:" "$f" || echo "MISSING FIELDS: $f"
done

# no placeholder leftovers anywhere
grep -rn "TBD\|TODO\|FIXME\|<command>\|<symbol>\|<category>" skills/ && echo "PLACEHOLDER FOUND" || echo "clean"
```

Expected: no "BROKEN LINK" lines, no "MISSING FIELDS" lines, and "clean" printed.

Then run the full end-to-end suite as the authoritative gate (it re-runs the checks above plus repo-liveness and install-command validation):

```bash
bash tests/e2e.sh          # set GITHUB_TOKEN to avoid API rate limits
```

Expected: `E2E OK` (exit 0). If it reports `FAIL`, fix before committing. Star-drift `WARN`s are the signal that this self-iterate run should update those numbers.

## E. Record + commit

1. Prepend a new dated entry to the top of [`CHANGELOG.md`](./CHANGELOG.md) (newest first) summarizing:
   - stars updated (count),
   - repos flagged (list, with reason),
   - skills added (list, with links).
2. Commit with message:
   ```
   chore: self-iterate manifest (YYYY-MM-DD)
   ```
   using the actual date the run happened.
