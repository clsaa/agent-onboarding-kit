# agent-onboarding-kit — Design Spec

**Date:** 2026-07-03
**Status:** Approved (brainstorming complete)

## One-liner

A documentation-only repository that any AI coding agent (Codex, Claude Code, OpenCode, and others) can read to install a curated set of recommended skills, so a user landing in a fresh environment or a new agent can immediately reach a productive working state.

## Goals

- Be **read by AI agents**, not primarily by humans — the docs are the product.
- Let an agent identify itself, filter the skills that fit it, run the right install commands, and verify.
- Cover an initial batch of **10 core skills** plus **5 extra recommended picks**, with a structure that stays easy to extend.
- Serve three target agents equally: **Codex, Claude Code, OpenCode** (others benefit too).

## Non-goals (YAGNI)

- No auto-executing install scripts (`install.sh`, etc.). Agents run commands themselves.
- No touching each agent's internal config files.
- No CI/automation.
- No live star-count syncing — figures are stamped "as of 2026-07".
- Not a full environment bootstrapper (runtimes, MCP servers, auth) — skills only, for now.

## Form

Pure documentation / manifest. Bilingual (中文 + English) README for humans; the machine-readable manifest is English.

## Repository structure

```
agent-onboarding-kit/
├── README.md              # Bilingual (中/EN). For humans: what this is, how to use.
├── AGENTS.md              # Entry point FOR AGENTS. The de-facto convention file agents read.
│                          #   Tells the agent how to parse the manifest, pick items that
│                          #   fit it, install, verify, and report.
├── skills/
│   ├── INDEX.md           # English master manifest: compatibility matrix overview table
│   │                      #   + an "Extra picks" section for the 5 extra recommendations.
│   └── <skill-slug>.md    # One structured file per skill (template below).
├── docs/
│   └── how-it-works.md    # Bilingual supplementary explanation.
└── CONTRIBUTING.md        # How to add a new entry to the manifest (keeps it extensible).
```

The agent entry point is `AGENTS.md` because it is the emerging cross-agent convention (Codex and others read it by default).

## Per-skill entry template (English)

Each `skills/<slug>.md` follows one uniform template so agents can parse it reliably:

```markdown
# <Skill Name>
- **Category:** <e.g. Skills Framework>
- **What it does:** <one or two sentences>
- **Repo:** <canonical GitHub URL>
- **Compatibility:** Claude Code <✅/⚠️/❌> | Codex <✅/⚠️/❌> | OpenCode <✅/⚠️/❌>
- **Install:**
  - Claude Code: <command>
  - Codex / OpenCode / others: <command, usually `npx skills add <owner/repo>`>
- **Verify:** <one line: how to confirm it installed>
- **When to use / skip:** <when it's worth installing, when it's unnecessary>
- **Stars:** <~N as of 2026-07>
```

Key fields: the three-way **Compatibility** matrix, **per-agent Install** commands, and a **Verify** step.

## Initial content

### 10 core skills (verified 2026-07-03)

Accurate repo URLs, install commands, and compatibility are taken from live-verified research. Corrections applied where the source image was inaccurate:

1. **Superpowers** — `obra/superpowers` — Skills Framework (TDD + review + planning). Cross-agent. ~245k.
2. **SuperClaude Framework** — `SuperClaude-Org/SuperClaude_Framework` — 30 slash commands. Claude Code-specific. ~23.4k.
3. **MiniMax Skills** — `MiniMax-AI/skills` — industrial workflow cards (frontend/fullstack/mobile). Cross-agent. ~12.9k.
4. **Anthropic Official Skills** — `anthropics/skills` — official reference + skill-creator. Claude ecosystem-first. ~158k.
5. **Vercel Agent Skills** — `vercel-labs/agent-skills` — React/Web design + review rules. Cross-agent. ~28.6k.
6. **Planning with Files** — `OthmanAdi/planning-with-files` — file-based external memory. Cross-agent. ~24.4k.
7. **Context Engineering Skills** — `muratcankoylan/Agent-Skills-for-Context-Engineering` — context-window management. Cross-agent. ~16.9k.
8. **Composio Skills** — `ComposioHQ/skills` — Skills + MCP for external services. Cross-agent (small repo, ~96; note in entry that `ComposioHQ/awesome-claude-skills` may be the intended larger index).
9. **Antfu Skills** — `antfu/skills` — an expert's opinionated skills (Vue/Vite/Nuxt). Cross-agent. ~5.5k.
10. **Awesome Agent Skills** — `VoltAgent/awesome-agent-skills` — directory/index of 1000+ skills. Cross-agent. ~27.2k. (Entry notes the space is fragmented; this is the chosen canonical index.)

### 5 extra picks (Extra picks section)

Selected during implementation from high-value candidates, each following the same template and honestly sourced (no inflated claims). Seed candidates: `addyosmani/agent-skills` (~68k), skill-creator (from `anthropics/skills`), plus 1–2 general-purpose rules/subagents. Final 5 chosen when writing content.

## Self-iteration mode (SELF-UPDATE.md)

The repo has two modes. `AGENTS.md` is **install mode**. `SELF-UPDATE.md` is **update mode**: a maintainer playbook an agent runs when told "self-iterate this repo." It (A) refreshes every entry's star count and compatibility from the live GitHub API and updates the date stamp, flagging dead/renamed repos rather than deleting; (B) discovers new high-value tools fitting the repo's scope and the maintainer's profile, adding them via the entry template + CONTRIBUTING; (C) enforces guardrails (API-verified numbers only, keep the template, ≤5 new per run, uncertain finds go to a "Candidates (needs human review)" section); (D) runs the structural consistency checks; (E) logs the run to `CHANGELOG.md` and commits. This keeps the manifest self-maintaining after clone.

## Agent usage flow (documented in AGENTS.md)

The agent is instructed to:

1. Identify which agent it is (Claude Code / Codex / OpenCode).
2. Read `skills/INDEX.md` compatibility matrix; filter to items that support it.
3. Run each item's matching Install command.
4. Run each item's Verify step.
5. Report to the user which skills were installed, which were skipped, and why.

## Success criteria

- An agent reading `AGENTS.md` cold can, without further human instruction, install the compatible subset and report results.
- All repo URLs and install commands are accurate as of 2026-07-03.
- Adding a new skill is a matter of copying the template into a new `skills/<slug>.md` and adding one row to the matrix — no other changes required.

## Decisions locked

- Repo name: **agent-onboarding-kit**
- Extra picks: **5**
- Scope: **local only, no push** this round.
- Language: **bilingual README + English manifest**.
