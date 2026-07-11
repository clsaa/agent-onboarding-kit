# skills/INDEX.md — Master Manifest & Compatibility Matrix

This is the machine-readable manifest for the Agent Onboarding Kit: it lists every curated skill, its category, its compatibility with each target agent, its star count, and a link to its detail page. Agents should read this file to decide what to install (see `AGENTS.md` for the full procedure).

## Legend

- ✅ — supported
- ⚠️ — works but not officially documented
- ❌ — not supported

## Core skills

| # | Skill | Type | Claude Code | Codex | OpenCode | Stars |
|---|-------|------|:-----------:|:-----:|:--------:|-------|
| 1 | [Superpowers](./superpowers.md) | Framework | ✅ | ✅ | ✅ | 246k |
| 2 | [SuperClaude Framework](./superclaude-framework.md) | Framework | ✅ | ❌ | ❌ | 23.4k |
| 3 | [MiniMax Skills](./minimax-skills.md) | Bundle | ✅ | ✅ | ✅ | 12.9k |
| 4 | [Anthropic Official Skills](./anthropic-official-skills.md) | Bundle | ✅ | ⚠️ | ⚠️ | 158k |
| 5 | [Vercel Agent Skills](./vercel-agent-skills.md) | Bundle | ✅ | ✅ | ✅ | 28.7k |
| 6 | [Planning with Files](./planning-with-files.md) | Collection | ✅ | ✅ | ✅ | 24.5k |
| 7 | [Context Engineering Skills](./context-engineering-skills.md) | Collection | ✅ | ✅ | ✅ | 16.9k |
| 8 | [Composio Skills](./composio-skills.md) | Collection | ✅ | ✅ | ⚠️ | 0.1k |
| 9 | [Antfu Skills](./antfu-skills.md) | Collection | ✅ | ✅ | ✅ | 5.5k |
| 10 | [Awesome Agent Skills](./awesome-agent-skills.md) | Directory | ✅ | ✅ | ✅ | 27.3k |

## Extra picks

Opinionated extras oriented toward AI, architecture, and full-stack work. The core 10 above already cover those three areas — AI: Context Engineering (#7), Composio/MCP (#8); architecture: Superpowers (#1), Planning with Files (#6); full-stack: Vercel (#5), MiniMax (#3), Antfu (#9). The picks below extend those.

| # | Skill | Type | Claude Code | Codex | OpenCode | Stars |
|---|-------|------|:-----------:|:-----:|:--------:|-------|
| 1 | [addyosmani Agent Skills](./extra-addyosmani-agent-skills.md) | Collection | ✅ | ✅ | ✅ | 69k |
| 2 | [skill-creator](./extra-skill-creator.md) | Bundle | ✅ | ⚠️ | ⚠️ | 158k |
| 3 | [Awesome MCP Servers](./extra-awesome-mcp-servers.md) | Directory | ✅ | ✅ | ✅ | 90k |
| 4 | [Antigravity Awesome Skills](./extra-antigravity-awesome-skills.md) | Directory | ✅ | ✅ | ✅ | 42.4k |
| 5 | [Composio Awesome Claude Skills](./extra-awesome-claude-skills.md) | Directory | ✅ | ⚠️ | ⚠️ | 67k |
| 6 | [Taste Skill](./extra-taste-skill.md) | Collection | ✅ | ✅ | ✅ | 56.6k |
| 7 | [UI/UX Pro Max Skill](./extra-ui-ux-pro-max-skill.md) | Collection | ✅ | ⚠️ | ⚠️ | 101k |
| 8 | [Graphify](./extra-graphify.md) | Collection | ✅ | ✅ | ✅ | 77.7k |
| 9 | [caveman](./extra-caveman.md) | Collection | ✅ | ✅ | ✅ | 84.1k |
| 10 | [gstack](./extra-gstack.md) | Collection | ✅ | ✅ | ✅ | 119.5k |
| 11 | [Understand Anything](./extra-understand-anything.md) | Collection | ✅ | ✅ | ✅ | 70.9k |
| 12 | [last30days](./extra-last30days-skill.md) | Collection | ✅ | ✅ | ✅ | 49k |
| 13 | [Andrej Karpathy Skills](./extra-andrej-karpathy-skills.md) | Collection | ✅ | ❌ | ❌ | 187.7k |

## Triage log (reviewed, not added)

Deep-checked candidates rejected with a dated reason, so future self-iterate runs neither re-review them needlessly nor re-skip others on weak signals (see `SELF-UPDATE.md` §B.2). A logged rejection may be revisited if the repo materially changes.

- [ponytail](https://github.com/DietrichGebert/ponytail) — 2026-07-09 — removed from Extra picks. **Installing it is not recommended.** Problems observed in use:
  - **Over-slices complex tasks.** The 7-rung "decision ladder" runs before every change and biases toward the *minimum viable implementation*, so complex/architectural work gets chopped into many small iterations — more agent round-trips, longer overall completion time, and (despite each diff being smaller) more total tokens spent on the extra steps.
  - **Benchmarks don't generalize.** Upstream's headline numbers (−54% LOC, −27% time) are `n=4` on a single FastAPI+React repo with Haiku 4.5; the repo itself notes gains are "near-zero where code is already minimal" and large only in "over-building traps." There's no evidence of benefit on complex tasks, where the ladder overhead can be net-negative.
  - **Always-on YAGNI bias.** The ruleset is injected into every task (and into subagents via a regex matcher). Applied indiscriminately it can under-build genuinely needed structure and defer necessary work — it even ships `/ponytail-debt` to later harvest the shortcuts it accumulates.
  - **Operational cost & trust surface.** Requires Node.js on PATH and runs lifecycle hooks on Claude Code / Codex / Devin (code execution on every turn); mode is process-local, so on shared gateways `/ponytail` must be restricted to trusted users.
- [headroom](https://github.com/headroomlabs-ai/headroom) — 2026-07-04 — compression library/proxy/MCP server, not an agent skill (out of scope).
- [Agent-Reach](https://github.com/Panniantong/Agent-Reach) — 2026-07-04 — web-access CLI/MCP tooling, not a SKILL.md-style skill (out of scope).
- [mattpocock/skills](https://github.com/mattpocock/skills) — 2026-07-04 — Claude Code-only (`.claude` conventions); manifest prefers cross-agent.
- [get-shit-done](https://github.com/gsd-build/get-shit-done) — 2026-07-04 — Claude Code-only system; manifest prefers cross-agent.
- [ECC](https://github.com/affaan-m/ECC) — 2026-07-05 — agent-harness/OS product (GUI + paid GitHub App + control-plane daemon), not a skill pack.
- [hermes-agent](https://github.com/NousResearch/hermes-agent) — 2026-07-05 — standalone agent runtime/harness, not installable skill content.
- [claw-code](https://github.com/ultraworkers/claw-code) — 2026-07-05 — standalone Rust CLI agent harness (Claude Code alternative).
- [cc-switch](https://github.com/farion1231/cc-switch) — 2026-07-05 — desktop GUI config manager; manages skills but ships none.
- [claude-mem](https://github.com/thedotmack/claude-mem) — 2026-07-05 — MCP server + hooks/worker memory infrastructure, not a skill pack.
- [lobehub](https://github.com/lobehub/lobehub) — 2026-07-05 — standalone web app/platform.
- [RuView](https://github.com/ruvnet/RuView) — 2026-07-05 — WiFi-sensing hardware project; unrelated to coding agents.
- [open-design](https://github.com/nexu-io/open-design) — 2026-07-05 — desktop design app + MCP server product; skills are a bundled component, not the product.
- [learn-claude-code](https://github.com/shareAI-lab/learn-claude-code) — 2026-07-05 — educational curriculum, not installable skill content.
- [rtk](https://github.com/rtk-ai/rtk) — 2026-07-05 — generic CLI proxy binary (token compression), out-of-scope category despite broad agent hooks.
- [oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent) — 2026-07-05 — agent harness/orchestration runtime for OpenCode/Codex, not skill content.
- [ruflo](https://github.com/ruvnet/ruflo) — 2026-07-05 — agent meta-harness (MCP server, daemon, swarms); skills are one component of the harness.
- [claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) — 2026-07-05 — best-practices reference/docs repo, not installable; overlaps existing directories.
- [awesome-openclaw-skills](https://github.com/VoltAgent/awesome-openclaw-skills) — 2026-07-05 — directory for OpenClaw (non-coding assistant ecosystem); no Claude Code/Codex/OpenCode relevance.
- [system_prompts_leaks](https://github.com/asgeirtj/system_prompts_leaks) — 2026-07-05 — prompt-leak archive, explicitly out of scope.
- [cherry-studio](https://github.com/CherryHQ/cherry-studio) — 2026-07-05 — standalone desktop GUI client.
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) — 2026-07-05 — pure link directory, Claude Code-only; manifest already carries broader directories.
- [JeecgBoot](https://github.com/jeecgboot/JeecgBoot) — 2026-07-05 — low-code platform; its AI skills live in a separate repo (candidate for a future check: `jeecgboot/skills`).
- [CowAgent](https://github.com/zhayujie/CowAgent) — 2026-07-05 — self-described agent harness with multi-channel runtime.
- [nanobot](https://github.com/HKUDS/nanobot) — 2026-07-05 — personal AI agent runtime (PyPI service), not skill content.
- [chatbox](https://github.com/chatboxai/chatbox) — 2026-07-05 — standalone desktop GUI client.
- [career-ops](https://github.com/santifer/career-ops) — 2026-07-05 — genuine cross-agent SKILL.md package, but domain-specific (job-search ops) and outside this manifest's dev-workflow profile.

---

Compatibility and star counts as of 2026-07.
