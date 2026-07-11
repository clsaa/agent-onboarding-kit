# Changelog

All self-iteration runs are logged here (newest first), following the spirit of
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/). This project uses
date-based entries rather than SemVer versions. See [`SELF-UPDATE.md`](./SELF-UPDATE.md).

## [2026-07-11] — Self-iterate run

### Added
- 3 extra picks, each deep-verified cross-agent from upstream docs before inclusion: [wshobson Agents](./skills/extra-wshobson-agents.md) (~37.8k, multi-harness plugin marketplace — 92 plugins across Claude Code/Codex/Cursor/OpenCode/Gemini/Copilot, ✅✅✅), [humanizer](./skills/extra-humanizer.md) (~28.7k, de-AI-ify prose, plain `SKILL.md`, ✅✅✅), and [Anthropic Cybersecurity Skills](./skills/extra-anthropic-cybersecurity-skills.md) (~25.3k, 817 framework-mapped security skills via the agentskills.io standard, ✅✅✅).

### Changed
- Star refresh across all existing entries (live GitHub API): 21 values ticked up — notably superpowers 246k→252k, karpathy 187.7k→190.7k, anthropic/skill-creator 158k→160.2k, gstack 119.5k→121.1k, ui-ux-pro-max 101k→104.2k, awesome-mcp 90k→90.6k, caveman 84.1k→87.9k, graphify 77.7k→82.1k, addyosmani 69k→77k, understand-anything 70.9k→72.7k, awesome-claude-skills 67k→67.4k, taste 56.6k→61.9k, last30days 49k→51.5k, antigravity 42.4k→42.8k, vercel 28.7k→28.9k, awesome-agent 27.3k→27.8k, planning 24.5k→25.2k, superclaude 23.4k→23.5k, context-eng 16.9k→17.1k, minimax 12.9k→13k.
- Repo renames handled (old slugs redirect; links + install commands updated): `ComposioHQ/skills` → `composio-community/skills`; `sickn33/antigravity-awesome-skills` → `sickn33/agentic-awesome-skills`.
- README skills badge now reports 10 core + 16 extra.

### Removed
- Removed [ponytail](https://github.com/DietrichGebert/ponytail) from Extra picks and deleted its manifest entry. **Installing ponytail is not recommended** — its behavior nudging over-slices complex tasks into too many iterations, lengthening overall project completion time and increasing token consumption; see the Triage log in [`skills/INDEX.md`](./skills/INDEX.md) for the full rationale (benchmark caveats, always-on YAGNI bias, hook/runtime trust surface).

### Notes
- 4 new candidates deep-checked and logged as reviewed-not-added in the `skills/INDEX.md` Triage log: `claude-plugins-official` (CC-only), `obsidian-skills` (out-of-profile domain), `claude-code-templates` (CC-only), `agentskills/agentskills` (spec hub, not a pack). No repos flagged as archived/404.

## [2026-07-05] — Self-iterate run (full triage under the new rules)

### Added
- 4 extra picks, each deep-verified from upstream docs before inclusion: [gstack](./skills/extra-gstack.md) (~119.5k, virtual-team skills, ✅✅✅), [Understand Anything](./skills/extra-understand-anything.md) (~70.9k, codebase knowledge-graph, ✅✅✅), [last30days](./skills/extra-last30days-skill.md) (~49k, research/synthesis, ✅✅✅), and [Andrej Karpathy Skills](./skills/extra-andrej-karpathy-skills.md) (~187.7k, rules pack — single-agent but exceptionally notable; repo transferred from `forrestchang`, canonical slug verified).
- Triage log extended with 22 deep-checked rejections, each with a dated reason (harnesses/runtimes, GUI apps, MCP infrastructure, directories, a prompt-leak archive, one off-profile skill).

### Changed
- **Renamed: `agent-onboarding-kit` → `skillrc`** ("the rc file for your AI coding agent"). Old GitHub URLs redirect automatically; all in-repo references updated.
- Star refresh across all existing entries: 8 values ticked up (awesome-agent-skills 27.3k, addyosmani 69k, antigravity 42.4k, graphify 77.7k, taste-skill 56.6k, ui-ux-pro-max 101k, planning-with-files 24.5k, vercel 28.7k). README badge → 10 core + 13 extra.

### Notes
- First run under the post-mortem triage rules: all 26 unlogged candidates above the star floor were deep-checked (README/INSTALL read) before any rejection — none rejected on description-derived hints. E2E gate green.

## [2026-07-05]

### Added
- Extra pick: [caveman](./skills/extra-caveman.md) (`JuliusBrussee/caveman`, ~84.1k — output-token reduction). It was seen in an earlier discovery pass and initially skipped; re-reviewed and confirmed ✅✅✅.
- README skills badge updated to 10 core + 9 extra.

### Changed
- Curation mechanism hardened after a triage post-mortem (the pick above was skipped in the 07-04 run on description-derived signals): `scripts/discover.sh` hints are renamed to `desc:*` and explicitly marked non-rejecting; `SELF-UPDATE.md` §B.2 gained triage rules (rejection requires the same verification rigor as acceptance; never judge by tone) and a persistent **Triage log** in `skills/INDEX.md`, seeded with the 07-04 deep-checked rejections.

## [2026-07-04] — Self-iterate run

### Added
- 3 new extra picks discovered via `scripts/discover.sh` and verified: [Taste Skill](./skills/extra-taste-skill.md) (`Leonxlnx/taste-skill`, ~55.7k), [UI/UX Pro Max Skill](./skills/extra-ui-ux-pro-max-skill.md) (`nextlevelbuilder/ui-ux-pro-max-skill`, ~100k), and [Graphify](./skills/extra-graphify.md) (`Graphify-Labs/graphify`, ~77.2k).
- Graphify was first parked in a "Candidates (needs human review)" section, then promoted once its explicit per-agent install commands (Claude Code / Codex / OpenCode) were verified from its README.

### Changed
- Star refresh: Superpowers 245k→246k; addyosmani Agent Skills 68.7k→68.8k. All other entries unchanged at manifest precision.

### Notes
- Repos flagged/dead: none. E2E gate: 41 checks, 0 failed. `scripts/discover.sh` surfaced ~117 candidates; skipped agent-harnesses/desktop apps/MCP-proxies (out of scope) and Claude-only tools (prefer cross-agent).

## [2026-07-03]

### Added
- Seeded 10 core skills + 5 extra picks. Star counts and compatibility verified as of 2026-07.
