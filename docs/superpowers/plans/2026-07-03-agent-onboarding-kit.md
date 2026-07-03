# agent-onboarding-kit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a documentation-only repo that AI coding agents (Codex, Claude Code, OpenCode) read to install a curated set of recommended skills.

**Architecture:** Pure Markdown. An `AGENTS.md` entry point instructs an agent to identify itself, read the `skills/INDEX.md` compatibility matrix, install the compatible subset via per-agent commands, verify, and report. Each skill is one structured file under `skills/`. Bilingual (中/EN) README for humans; English machine-readable manifest.

**Tech Stack:** Markdown only. No build system, no scripts, no CI. Verification = structural/consistency checks with `grep`/`ls`.

## Global Constraints

- Repo name: `agent-onboarding-kit`.
- Manifest content (`AGENTS.md`, `skills/*.md`) is **English**. README and `docs/how-it-works.md` are **bilingual (中文 + English)**.
- Every skill entry follows the exact template in Task 3 — same field order, same labels.
- Star counts and compatibility are stamped "as of 2026-07" and use the verified figures below. Never invent numbers or repos.
- Compatibility symbols: `✅` supported, `⚠️` works but not officially documented, `❌` not supported.
- Target agents named consistently everywhere as: **Claude Code**, **Codex**, **OpenCode**.
- No auto-executing scripts, no CI, no touching agent internal config.
- Cross-agent install command convention: `npx skills add <owner/repo>` unless a skill documents otherwise.

### Verified data table (source of truth for all entries)

| # | Name | Repo (owner/repo) | Category | Claude Code | Codex | OpenCode | Stars (~, 2026-07) | Claude Code install | Cross-agent install |
|---|------|-------------------|----------|:-----------:|:-----:|:--------:|--------------------|---------------------|---------------------|
| 1 | Superpowers | `obra/superpowers` | Skills Framework | ✅ | ✅ | ✅ | 245k | `/plugin install superpowers@claude-plugins-official` | `npx skills add obra/superpowers` |
| 2 | SuperClaude Framework | `SuperClaude-Org/SuperClaude_Framework` | Slash-command Framework | ✅ | ❌ | ❌ | 23.4k | `pipx install superclaude && superclaude install` | n/a (Claude Code only) |
| 3 | MiniMax Skills | `MiniMax-AI/skills` | Workflow cards | ✅ | ✅ | ✅ | 12.9k | `claude plugin marketplace add https://github.com/MiniMax-AI/skills && claude plugin install minimax-skills` | `git clone https://github.com/MiniMax-AI/skills.git ~/.codex/minimax-skills` (Codex) / `~/.minimax-skills` (OpenCode) |
| 4 | Anthropic Official Skills | `anthropics/skills` | Official reference + skill-creator | ✅ | ⚠️ | ⚠️ | 158k | `/plugin marketplace add anthropics/skills` then `/plugin install document-skills@anthropic-agent-skills` | SKILL.md files consumable manually |
| 5 | Vercel Agent Skills | `vercel-labs/agent-skills` | React/Web design + review rules | ✅ | ✅ | ✅ | 28.6k | `npx skills add vercel-labs/agent-skills` | `npx skills add vercel-labs/agent-skills` |
| 6 | Planning with Files | `OthmanAdi/planning-with-files` | File-based external memory | ✅ | ✅ | ✅ | 24.4k | `npx skills add OthmanAdi/planning-with-files` | `npx skills add OthmanAdi/planning-with-files` |
| 7 | Context Engineering Skills | `muratcankoylan/Agent-Skills-for-Context-Engineering` | Context management | ✅ | ✅ | ✅ | 16.9k | `npx skills add muratcankoylan/Agent-Skills-for-Context-Engineering` | `npx skills add muratcankoylan/Agent-Skills-for-Context-Engineering` |
| 8 | Composio Skills | `ComposioHQ/skills` | Skills + MCP for external services | ✅ | ✅ | ⚠️ | 0.1k | `npx skills add composiohq/skills` | `npx skills add composiohq/skills` |
| 9 | Antfu Skills | `antfu/skills` | Expert Vue/Vite/Nuxt conventions | ✅ | ✅ | ✅ | 5.5k | `pnpx skills add antfu/skills --skill='*'` | `pnpx skills add antfu/skills --skill='*'` |
| 10 | Awesome Agent Skills | `VoltAgent/awesome-agent-skills` | Directory / index | ✅ | ✅ | ✅ | 27.2k | browse index, install individual skills | browse index, install individual skills |

### Extra picks (5) — source of truth

| Name | Repo | Category | Claude Code | Codex | OpenCode | Stars (~, 2026-07) | Install |
|------|------|----------|:-----------:|:-----:|:--------:|--------------------|---------|
Tailored to the user's profile (AI expert / system architect / full-stack developer):

| Name | Repo | Category | Fits | Claude Code | Codex | OpenCode | Stars (~, 2026-07) | Install |
|------|------|----------|------|:-----------:|:-----:|:--------:|--------------------|---------|
| addyosmani Agent Skills | `addyosmani/agent-skills` | Skills collection (incl. context-engineering) | Full-stack breadth | ✅ | ✅ | ✅ | 68.7k | `npx skills add addyosmani/agent-skills` |
| skill-creator | `anthropics/skills` (skill-creator) | Meta-skill: author/edit/eval skills | AI expert — build your own skills | ✅ | ⚠️ | ⚠️ | 158k | `/plugin install example-skills@anthropic-agent-skills` (then use skill-creator) |
| Awesome MCP Servers | `punkpeye/awesome-mcp-servers` | Directory of MCP servers | AI/architect — wire external tools via MCP | ✅ | ✅ | ✅ | 60k+ | browse index, add servers to your agent's MCP config |
| Antigravity Awesome Skills | `sickn33/antigravity-awesome-skills` | 1,800+ installable skills + installer CLI | Breadth / full-stack | ✅ | ✅ | ✅ | 42.3k | browse index / installer CLI |
| Composio Awesome Claude Skills | `ComposioHQ/awesome-claude-skills` | Curated Claude skills index | Architect — integrations catalog | ✅ | ⚠️ | ⚠️ | (index) | browse index |

> **Role mapping (note in INDEX "Extra picks" intro):** the core 10 already cover the user's three hats — AI expert: Context Engineering (#7), Composio/MCP (#8); system architect: Superpowers (#1), Planning with Files (#6); full-stack: Vercel (#5), MiniMax (#3), Antfu (#9). The extra 5 above extend those.
> During Task 5, re-verify the uncertain figures (`punkpeye/awesome-mcp-servers` stars, `ComposioHQ/awesome-claude-skills` existence/stars) with a quick check; if a repo can't be confirmed, note it in that file rather than guessing.

---

### Task 1: Repo scaffolding — README, LICENSE, .gitignore

**Files:**
- Create: `README.md`
- Create: `LICENSE`
- Create: `.gitignore`

**Interfaces:**
- Consumes: nothing (first task).
- Produces: bilingual README that links to `AGENTS.md`, `skills/INDEX.md`, `docs/how-it-works.md`, `CONTRIBUTING.md` (those files are created in later tasks; links are relative paths).

- [ ] **Step 1: Write `.gitignore`**

```
.DS_Store
node_modules/
```

- [ ] **Step 2: Write `LICENSE`** (MIT, copyright holder "agent-onboarding-kit contributors", year 2026). Use the standard MIT text.

- [ ] **Step 3: Write `README.md`** — bilingual, two top-level sections (中文 then English). Each section must contain:
  - One-line description of the repo.
  - "For AI agents" line: point the agent to `AGENTS.md` as the entry point.
  - "For humans" line: what the repo does and how to use it (open in your agent, ask it to read `AGENTS.md`).
  - A relative link to `skills/INDEX.md` (the manifest), `docs/how-it-works.md`, and `CONTRIBUTING.md`.
  - A one-sentence note that star counts are "as of 2026-07".

```markdown
# agent-onboarding-kit

> 让任意 AI 编程 Agent（Codex / Claude Code / OpenCode…）读完就能装好一批推荐 skill，
> 帮你在新环境或新 Agent 里立即进入高效工作状态。
> A manifest any AI coding agent can read to install a curated set of recommended skills.

## 中文

**这是什么** — 一个纯文档仓库……（写清楚定位）
**给 Agent** — 让你的 Agent 读 [`AGENTS.md`](./AGENTS.md)，它会自动挑出适配自己的 skill 并安装。
**给用户** — 在你的 Agent 里打开本仓库，说"读 AGENTS.md 并按说明安装 skill"。
**清单** — 见 [`skills/INDEX.md`](./skills/INDEX.md)。
**原理** — 见 [`docs/how-it-works.md`](./docs/how-it-works.md)。
**贡献** — 见 [`CONTRIBUTING.md`](./CONTRIBUTING.md)。
> 星数与适配情况以 2026-07 为准。

## English

**What** — A documentation-only repo …
**For agents** — Point your agent at [`AGENTS.md`](./AGENTS.md); it selects and installs the skills that fit it.
**For humans** — Open this repo in your agent and say "read AGENTS.md and install the skills."
**Manifest** — see [`skills/INDEX.md`](./skills/INDEX.md).
**How it works** — see [`docs/how-it-works.md`](./docs/how-it-works.md).
**Contributing** — see [`CONTRIBUTING.md`](./CONTRIBUTING.md).
> Star counts and compatibility are as of 2026-07.
```

- [ ] **Step 4: Verify structure**

Run: `ls README.md LICENSE .gitignore && grep -c "AGENTS.md" README.md`
Expected: all three files listed; `AGENTS.md` referenced at least twice (once per language section).

- [ ] **Step 5: Commit**

```bash
git add README.md LICENSE .gitignore
git commit -m "docs: add bilingual README, LICENSE, gitignore"
```

---

### Task 2: AGENTS.md — the agent entry point

**Files:**
- Create: `AGENTS.md`

**Interfaces:**
- Consumes: references `skills/INDEX.md` (created Task 3) by relative path.
- Produces: the 5-step usage procedure that `docs/how-it-works.md` will echo.

- [ ] **Step 1: Write `AGENTS.md`** (English). Must contain, in order:
  1. A one-paragraph purpose statement addressed to the agent.
  2. A **"Step 0: Identify yourself"** instruction — determine whether you are Claude Code, Codex, OpenCode, or other.
  3. The **5-step procedure** verbatim:
     - Step 1 — Read [`skills/INDEX.md`](./skills/INDEX.md) and its compatibility matrix.
     - Step 2 — Filter to rows where your agent column is `✅` (or `⚠️`, with a caution note).
     - Step 3 — For each selected skill, open its `skills/<slug>.md` and run the Install command for your agent.
     - Step 4 — Run the skill's Verify step; if it fails, report the failure and continue.
     - Step 5 — Report to the user: installed, skipped (with reason), and any failures.
  4. A **"Rules"** block: never run scripts not listed here; never modify the user's unrelated config; ask the user before installing if they only wanted a subset; treat `⚠️` items as opt-in.

- [ ] **Step 2: Verify content**

Run: `grep -E "Step [0-5]" AGENTS.md | wc -l && grep -c "skills/INDEX.md" AGENTS.md`
Expected: at least 6 "Step N" lines (0–5); `skills/INDEX.md` referenced at least once.

- [ ] **Step 3: Commit**

```bash
git add AGENTS.md
git commit -m "docs: add AGENTS.md agent entry point with 5-step flow"
```

---

### Task 3: skills/INDEX.md — master manifest + compatibility matrix

**Files:**
- Create: `skills/INDEX.md`

**Interfaces:**
- Consumes: the verified data tables from Global Constraints.
- Produces: the canonical compatibility matrix; each row links to `skills/<slug>.md`. Defines the slug names Task 4/5 must match exactly.

**Slugs (Task 4 must create exactly these files):** `superpowers.md`, `superclaude-framework.md`, `minimax-skills.md`, `anthropic-official-skills.md`, `vercel-agent-skills.md`, `planning-with-files.md`, `context-engineering-skills.md`, `composio-skills.md`, `antfu-skills.md`, `awesome-agent-skills.md`.

**Extra-pick slugs (Task 5):** `extra-addyosmani-agent-skills.md`, `extra-skill-creator.md`, `extra-awesome-mcp-servers.md`, `extra-antigravity-awesome-skills.md`, `extra-awesome-claude-skills.md`.

- [ ] **Step 1: Write `skills/INDEX.md`** with:
  1. Title + one-line explanation (English) that this is the machine-readable manifest.
  2. **"Core skills"** section: a Markdown table with columns `Skill | Category | Claude Code | Codex | OpenCode | Stars | Details`. One row per core skill (10 rows), values copied from the verified data table, `Details` linking to `./<slug>.md`.
  3. **"Extra picks"** section: same table shape, 5 rows, linking to the `extra-*.md` slugs.
  4. A legend for `✅ / ⚠️ / ❌`.
  5. Footer: "as of 2026-07".

- [ ] **Step 2: Verify matrix**

Run: `grep -c "\.md)" skills/INDEX.md`
Expected: at least 15 relative `.md` links (10 core + 5 extra).

- [ ] **Step 3: Commit**

```bash
git add skills/INDEX.md
git commit -m "docs: add skills/INDEX.md manifest with compatibility matrix"
```

---

### Task 4: The 10 core skill entry files

**Files:**
- Create: `skills/superpowers.md`, `skills/superclaude-framework.md`, `skills/minimax-skills.md`, `skills/anthropic-official-skills.md`, `skills/vercel-agent-skills.md`, `skills/planning-with-files.md`, `skills/context-engineering-skills.md`, `skills/composio-skills.md`, `skills/antfu-skills.md`, `skills/awesome-agent-skills.md`

**Interfaces:**
- Consumes: slug names from Task 3; verified data table from Global Constraints.
- Produces: 10 files, each following the exact template below.

**Template (every file, exact field order):**

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

- [ ] **Step 1: Write all 10 files** using the verified data table. Notes for specific entries:
  - `superpowers.md` — Verify: "Ask the agent to list skills; `brainstorming`/`test-driven-development` appear." When to use: any serious multi-step dev work; skip for one-off scripts.
  - `superclaude-framework.md` — Compatibility Claude Code ✅, Codex ❌, OpenCode ❌. Cross-agent install line: "n/a — Claude Code only." Verify: "`/sc:` slash commands are available."
  - `minimax-skills.md` — split Codex/OpenCode install (different clone paths per data table).
  - `anthropic-official-skills.md` — Codex/OpenCode ⚠️; note SKILL.md files are consumable manually but tooling is Claude-first.
  - `composio-skills.md` — add a one-line note: "Small repo (~0.1k). If you wanted the larger curated index, see the `awesome-claude-skills` extra pick."
  - `awesome-agent-skills.md` — this is an index; Install = "browse and install individual skills via `npx skills add <repo>`." Note the space is fragmented; `VoltAgent/awesome-agent-skills` chosen as canonical.

- [ ] **Step 2: Verify all files exist and follow the template**

Run:
```bash
ls skills/*.md | grep -v INDEX | wc -l
for f in skills/superpowers.md skills/superclaude-framework.md skills/minimax-skills.md skills/anthropic-official-skills.md skills/vercel-agent-skills.md skills/planning-with-files.md skills/context-engineering-skills.md skills/composio-skills.md skills/antfu-skills.md skills/awesome-agent-skills.md; do
  grep -q "Compatibility:" "$f" && grep -q "Install:" "$f" && grep -q "Verify:" "$f" && grep -q "Stars:" "$f" || echo "MISSING FIELDS: $f"
done
```
Expected: count is 10; no "MISSING FIELDS" lines printed.

- [ ] **Step 3: Verify links resolve (every INDEX core link points to a real file)**

Run:
```bash
for slug in superpowers superclaude-framework minimax-skills anthropic-official-skills vercel-agent-skills planning-with-files context-engineering-skills composio-skills antfu-skills awesome-agent-skills; do
  test -f "skills/$slug.md" || echo "MISSING: $slug"
  grep -q "$slug.md" skills/INDEX.md || echo "NOT LINKED IN INDEX: $slug"
done
```
Expected: no output.

- [ ] **Step 4: Commit**

```bash
git add skills/*.md
git commit -m "docs: add 10 core skill entry files"
```

---

### Task 5: The 5 extra picks

**Files:**
- Create: `skills/extra-addyosmani-agent-skills.md`, `skills/extra-skill-creator.md`, `skills/extra-awesome-mcp-servers.md`, `skills/extra-antigravity-awesome-skills.md`, `skills/extra-awesome-claude-skills.md`

**Interfaces:**
- Consumes: extra-picks data table + slug names from Task 3.
- Produces: 5 files following the same template as Task 4.

- [ ] **Step 1: Quick re-verify the two uncertain repos**

Run: `for r in punkpeye/awesome-mcp-servers ComposioHQ/awesome-claude-skills; do echo "== $r =="; curl -s "https://api.github.com/repos/$r" | grep -E '"full_name"|"stargazers_count"|"message"'; done`
Expected: both return a `full_name` (exist). If either returns `"message": "Not Found"`, note it in that file's "What it does" line rather than guessing a star count.

- [ ] **Step 2: Write all 5 files** using the extra-picks data table and the Task 4 template. Each file's "When to use / skip" must state why it's a bonus pick (e.g., "addyosmani — the largest general skills collection; overlaps some core picks").

- [ ] **Step 3: Verify files + template fields**

Run:
```bash
for slug in extra-addyosmani-agent-skills extra-skill-creator extra-awesome-mcp-servers extra-antigravity-awesome-skills extra-awesome-claude-skills; do
  test -f "skills/$slug.md" || echo "MISSING: $slug"
  grep -q "Compatibility:" "skills/$slug.md" && grep -q "Install:" "skills/$slug.md" || echo "MISSING FIELDS: $slug"
  grep -q "$slug.md" skills/INDEX.md || echo "NOT LINKED IN INDEX: $slug"
done
```
Expected: no output.

- [ ] **Step 4: Commit**

```bash
git add skills/extra-*.md
git commit -m "docs: add 5 extra recommended picks"
```

---

### Task 6: docs/how-it-works.md + CONTRIBUTING.md

**Files:**
- Create: `docs/how-it-works.md`
- Create: `CONTRIBUTING.md`

**Interfaces:**
- Consumes: the 5-step flow from `AGENTS.md`; the template from Task 4.
- Produces: final docs. After this task the repo is complete.

- [ ] **Step 1: Write `docs/how-it-works.md`** (bilingual). Explain, in 中文 then English: the repo's design (docs-as-product), the role of `AGENTS.md`, how the compatibility matrix works, and the 5-step agent flow (echo it, don't invent a new one).

- [ ] **Step 2: Write `CONTRIBUTING.md`** (bilingual header, English body ok). Explain how to add a skill: (1) copy the entry template (reproduce it verbatim here), (2) create `skills/<slug>.md`, (3) add one row to the correct table in `skills/INDEX.md`, (4) keep compatibility symbols honest, (5) stamp stars with a date. Include the exact template block.

- [ ] **Step 3: Verify**

Run: `ls docs/how-it-works.md CONTRIBUTING.md && grep -q "Compatibility:" CONTRIBUTING.md && echo "template present"`
Expected: both files listed; "template present" printed.

- [ ] **Step 4: Final consistency check across the whole repo**

Run:
```bash
# every INDEX link resolves to a file
grep -oE '\(\./([a-z0-9-]+)\.md\)' skills/INDEX.md | sed 's/[()]//g; s/^\.\///' | while read f; do test -f "skills/$f" || echo "BROKEN LINK: $f"; done
# no placeholder leftovers
grep -rn "TBD\|TODO\|FIXME\|<slug>\|<command>\|<symbol>" skills/ AGENTS.md README.md && echo "PLACEHOLDER FOUND" || echo "clean"
```
Expected: no "BROKEN LINK" lines; prints "clean".

- [ ] **Step 5: Commit**

```bash
git add docs/how-it-works.md CONTRIBUTING.md
git commit -m "docs: add how-it-works and CONTRIBUTING"
```

---

## Definition of done

- `AGENTS.md`, `README.md` (bilingual), `skills/INDEX.md`, 10 core `skills/*.md`, 5 `skills/extra-*.md`, `docs/how-it-works.md`, `CONTRIBUTING.md` all present.
- Every INDEX matrix row links to an existing file; every skill file has all template fields.
- No placeholders; all repo URLs and commands match the verified data table.
- Repo is committed locally; **not pushed** (per scope decision).
