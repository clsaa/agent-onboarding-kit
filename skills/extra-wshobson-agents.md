# wshobson Agents

- **Category:** Multi-harness plugin marketplace (agents + skills + commands)
- **What it does:** A single source-of-truth marketplace (92 plugins / 199 agents / 162 skills / 106 commands) that generates harness-specific artifacts, so one install pulls only the plugin you need across several coding agents.
- **Repo:** https://github.com/wshobson/agents
- **Compatibility:** Claude Code ✅ | Codex ✅ | OpenCode ✅
- **Install:**
  - Claude Code: `/plugin marketplace add wshobson/agents` then `/plugin install <plugin>` (e.g. `python-development`)
  - Codex / OpenCode / others: consumed natively by Codex CLI, Cursor, Gemini CLI, and GitHub Copilot; for OpenCode/Gemini `git clone` then `make generate` and run the harness-specific install
- **Verify:** After installing a plugin, its agents/skills/commands appear in the host (e.g. the plugin's slash commands are listed).
- **When to use / skip:** Use when you want a broad, composable catalog that installs per-plugin (not all-at-once) and works across six hosts; skip if you want a single small skill rather than a marketplace, or can't run `make generate` for the OpenCode path.
- **Stars:** ~37.8k (as of 2026-07)
