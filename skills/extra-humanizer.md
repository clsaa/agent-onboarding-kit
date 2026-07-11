# humanizer

- **Category:** Writing-quality skill (de-AI-ify prose)
- **What it does:** Detects and rewrites 33 tells of AI-generated writing — promotional language, vague attributions, AI vocabulary, over-hedging — so agent output reads as natural human prose. The runtime artifact is a plain-Markdown `SKILL.md`, so it runs in any skill-capable harness.
- **Repo:** https://github.com/blader/humanizer
- **Compatibility:** Claude Code ✅ | Codex ✅ | OpenCode ✅
- **Install:**
  - Claude Code: `/plugin marketplace add blader/humanizer` then `/plugin install humanizer@humanizer`
  - Codex / OpenCode / others: `npx skills add blader/humanizer` (add `--agent <name>` to target a specific harness)
- **Verify:** Ask the agent to rewrite a paragraph; the AI tells (e.g. "delve", "it's important to note") are removed.
- **When to use / skip:** Use when an agent drafts docs, PR descriptions, or user-facing copy and you want it to sound human; skip for pure code tasks where prose style is irrelevant.
- **Stars:** ~28.7k (as of 2026-07)
