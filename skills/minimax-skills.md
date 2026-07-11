# MiniMax Skills
- **Category:** Workflow cards
- **What it does:** A set of workflow cards from MiniMax AI that guide an agent through common development and content tasks step by step.
- **Repo:** https://github.com/MiniMax-AI/skills
- **Compatibility:** Claude Code ✅ | Codex ✅ | OpenCode ✅
- **Install:**
  - Claude Code: `claude plugin marketplace add https://github.com/MiniMax-AI/skills && claude plugin install minimax-skills`
  - Codex:
    ```
    git clone https://github.com/MiniMax-AI/skills.git ~/.codex/minimax-skills
    mkdir -p ~/.agents/skills
    ln -s ~/.codex/minimax-skills/skills ~/.agents/skills/minimax-skills
    ```
    Restart Codex to discover the skills. See [`.codex/INSTALL.md`](https://github.com/MiniMax-AI/skills/blob/main/.codex/INSTALL.md) for Windows instructions and details.
  - OpenCode:
    ```
    git clone https://github.com/MiniMax-AI/skills.git ~/.minimax-skills
    mkdir -p ~/.config/opencode/skills
    ln -s ~/.minimax-skills/skills/* ~/.config/opencode/skills/
    ```
    Restart OpenCode to discover the skills. See [`.opencode/INSTALL.md`](https://github.com/MiniMax-AI/skills/blob/main/.opencode/INSTALL.md) for details.
- **Verify:** Ask the agent to list skills; MiniMax workflow cards appear.
- **When to use / skip:** Use when you want ready-made workflow cards for common tasks; skip if you already have an equivalent skill set installed.
- **Stars:** ~13k (as of 2026-07)
