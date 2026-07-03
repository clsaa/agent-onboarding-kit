# CONTRIBUTING.md — 贡献指南 / Contributing

> 中文 / English — 如何为本仓库新增一个 skill。
> How to add a new skill to this repo.

This repo is a documentation-only, machine-readable manifest of skills for AI coding agents (Claude Code, Codex, OpenCode). Adding a skill means adding a well-formed entry, not writing code. Follow the five steps below exactly so the manifest stays consistent and every agent that reads it can trust it.

## How to add a skill

### 1. Copy the entry template

Every skill file — core or extra — follows this exact template, field order, and labels. Copy it verbatim into your new file and fill in the placeholders:

```markdown
# <Skill Name>
- **Category:** <category>
- **What it does:** <1–2 sentences>
- **Repo:** https://github.com/<owner/repo>
- **Compatibility:** Claude Code <symbol> | Codex <symbol> | OpenCode <symbol>
- **Install:**
  - Claude Code: `<command>`
  - Codex / OpenCode / others: `<command>`
- **Verify:** <one line>
- **When to use / skip:** <one or two lines>
- **Stars:** ~<N> (as of 2026-07)
```

Do not reorder fields, rename labels, or drop any of them — the manifest's consumers (agents running the 5-step flow in [`AGENTS.md`](./AGENTS.md)) rely on this shape being identical across every `skills/*.md` file.

### 2. Create `skills/<slug>.md`

Pick a short, kebab-case slug for the skill (e.g. `my-new-skill`), and create `skills/<slug>.md` (or `skills/extra-<slug>.md` if it's a bonus/non-core pick) with the filled-in template from step 1. Verify every claim before writing it down:

- Confirm the repo exists and get its real star count (e.g. via the GitHub API) — never invent or guess a number.
- Actually check compatibility with each target agent before assigning a symbol — don't assume.

### 3. Add one row to `skills/INDEX.md`

Open [`skills/INDEX.md`](./skills/INDEX.md) and add exactly one new row to the correct table — the "Core skills" table for foundational picks, or the "Extra picks" table for supplementary/tailored ones. The row must use the same columns as existing rows (`Skill | Category | Claude Code | Codex | OpenCode | Stars | Details`) and its `Details` cell must link to the file you created in step 2, e.g. `[Details](./my-new-skill.md)`. Do not create a new table or change the existing column order.

### 4. Keep compatibility symbols honest

Use the same legend everywhere:

- `✅` — supported
- `⚠️` — works but not officially documented (treat as opt-in)
- `❌` — not supported

The symbols in your `skills/<slug>.md` "Compatibility" line and in the `skills/INDEX.md` row **must match exactly**. Never mark something `✅` to make the table look better — an agent will run that install command and it must actually work. If you're not sure a symbol still holds, mark it `⚠️` rather than guess `✅`.

### 5. Stamp stars with a date

Every entry's `Stars:` line and the `skills/INDEX.md` footer both carry an "as of YYYY-MM" stamp (currently `2026-07`). When you add or refresh an entry, stamp the star count with the month you actually looked it up — don't reuse an old stamp with a new number, and don't leave a number unstamped.

## Before you commit

Run the same checks used elsewhere in this repo to catch mistakes:

```bash
# every INDEX link resolves to a file
grep -oE '\(\./([a-z0-9-]+)\.md\)' skills/INDEX.md | sed 's/[()]//g; s/^\.\///' | while read f; do test -f "skills/$f" || echo "BROKEN LINK: $f"; done

# your new file has every template field
grep -q "Compatibility:" "skills/<slug>.md" && grep -q "Install:" "skills/<slug>.md" && grep -q "Verify:" "skills/<slug>.md" && grep -q "Stars:" "skills/<slug>.md" || echo "MISSING FIELDS"

# no placeholder leftovers anywhere
grep -rn "TBD\|TODO\|FIXME\|<slug>\|<command>\|<symbol>" skills/ AGENTS.md README.md && echo "PLACEHOLDER FOUND" || echo "clean"
```

Expected: no "BROKEN LINK" lines, no "MISSING FIELDS", and "clean" printed.
