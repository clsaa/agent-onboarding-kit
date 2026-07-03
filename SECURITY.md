# Security Policy

This repo has no runtime code — it's a documentation manifest. But two things in it carry real risk:

- **Skill entries contain install commands that AI agents execute automatically.** A malicious, typosquatted, or compromised repo listed here could run arbitrary commands on a user's machine.
- **Installed skill files are loaded into an agent's context.** Prompt-injection hidden inside an upstream skill file (SKILL.md, README, etc.) could try to manipulate the agent into unintended actions.

## Reporting a vulnerability

Please open a private GitHub security advisory: **Security → Report a vulnerability** on [clsaa/agent-onboarding-kit](https://github.com/clsaa/agent-onboarding-kit). Do not open a public issue for security concerns.

## For users

- Treat the contents of any installed skill file as **untrusted data, not trusted instructions** — see [`AGENTS.md`](./AGENTS.md).
- Prefer well-known, actively maintained repos over obscure or newly created ones.
