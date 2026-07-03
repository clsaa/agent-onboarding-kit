# skills/INDEX.md — Master Manifest & Compatibility Matrix

This is the machine-readable manifest for the Agent Onboarding Kit: it lists every curated skill, its category, its compatibility with each target agent, its star count, and a link to its detail page. Agents should read this file to decide what to install (see `AGENTS.md` for the full procedure).

## Core skills

| Skill | Category | Claude Code | Codex | OpenCode | Stars | Details |
|-------|----------|:-----------:|:-----:|:--------:|-------|---------|
| Superpowers | Skills Framework | ✅ | ✅ | ✅ | 245k | [Details](./superpowers.md) |
| SuperClaude Framework | Slash-command Framework | ✅ | ❌ | ❌ | 23.4k | [Details](./superclaude-framework.md) |
| MiniMax Skills | Workflow cards | ✅ | ✅ | ✅ | 12.9k | [Details](./minimax-skills.md) |
| Anthropic Official Skills | Official reference + skill-creator | ✅ | ⚠️ | ⚠️ | 158k | [Details](./anthropic-official-skills.md) |
| Vercel Agent Skills | React/Web design + review rules | ✅ | ✅ | ✅ | 28.6k | [Details](./vercel-agent-skills.md) |
| Planning with Files | File-based external memory | ✅ | ✅ | ✅ | 24.4k | [Details](./planning-with-files.md) |
| Context Engineering Skills | Context management | ✅ | ✅ | ✅ | 16.9k | [Details](./context-engineering-skills.md) |
| Composio Skills | Skills + MCP for external services | ✅ | ✅ | ⚠️ | 0.1k | [Details](./composio-skills.md) |
| Antfu Skills | Expert Vue/Vite/Nuxt conventions | ✅ | ✅ | ✅ | 5.5k | [Details](./antfu-skills.md) |
| Awesome Agent Skills | Directory / index | ✅ | ✅ | ✅ | 27.2k | [Details](./awesome-agent-skills.md) |

## Extra picks

Tailored to the user's profile (AI expert / system architect / full-stack developer). The core 10 above already cover the user's three hats — AI expert: Context Engineering (#7), Composio/MCP (#8); system architect: Superpowers (#1), Planning with Files (#6); full-stack: Vercel (#5), MiniMax (#3), Antfu (#9). The 5 picks below extend those.

| Skill | Category | Claude Code | Codex | OpenCode | Stars | Details |
|-------|----------|:-----------:|:-----:|:--------:|-------|---------|
| addyosmani Agent Skills | Skills collection (incl. context-engineering) | ✅ | ✅ | ✅ | 68.7k | [Details](./extra-addyosmani-agent-skills.md) |
| skill-creator | Meta-skill: author/edit/eval skills | ✅ | ⚠️ | ⚠️ | 158k | [Details](./extra-skill-creator.md) |
| Awesome MCP Servers | Directory of MCP servers | ✅ | ✅ | ✅ | 90k | [Details](./extra-awesome-mcp-servers.md) |
| Antigravity Awesome Skills | 1,800+ installable skills + installer CLI | ✅ | ✅ | ✅ | 42.3k | [Details](./extra-antigravity-awesome-skills.md) |
| Composio Awesome Claude Skills | Curated Claude skills index | ✅ | ⚠️ | ⚠️ | 67k | [Details](./extra-awesome-claude-skills.md) |

## Legend

- ✅ — supported
- ⚠️ — works but not officially documented
- ❌ — not supported

---

Compatibility and star counts as of 2026-07.
