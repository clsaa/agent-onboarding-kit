# 🚀 agent-onboarding-kit

> 让任意 AI 编程 Agent(Codex / Claude Code / OpenCode…)读完就能装好一批推荐 skill,
> 帮你在新环境或新 Agent 里立即进入高效工作状态。
> A manifest any AI coding agent can read to install a curated set of recommended skills.

<p align="center">
  <a href="https://github.com/clsaa/agent-onboarding-kit/actions/workflows/e2e.yml"><img alt="E2E" src="https://github.com/clsaa/agent-onboarding-kit/actions/workflows/e2e.yml/badge.svg"></a>
  <a href="./LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
  <a href="https://github.com/clsaa/agent-onboarding-kit/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/clsaa/agent-onboarding-kit?style=flat&logo=github"></a>
  <img alt="Skills" src="https://img.shields.io/badge/skills-10%20core%20%2B%205%20extra-blue">
  <img alt="Agents" src="https://img.shields.io/badge/agents-Claude%20Code%20%7C%20Codex%20%7C%20OpenCode-8A2BE2">
  <a href="./CONTRIBUTING.md"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen"></a>
  <img alt="Data as of" src="https://img.shields.io/badge/data-2026--07-lightgrey">
</p>

---

## 🧭 两种模式 · Two modes

| | 🛠️ 安装模式 · Install mode | 🔄 自迭代模式 · Self-iterate mode |
|---|---|---|
| **入口 · Entry** | [`AGENTS.md`](./AGENTS.md) | [`SELF-UPDATE.md`](./SELF-UPDATE.md) |
| **做什么 · What** | Agent 识别自己 → 读适配矩阵 → 装适配自己的 skill → 验证 → 汇报<br>Identify self → read matrix → install fitting skills → verify → report | 刷新星数(GitHub API)→ 校验仓库存活 → 发现新工具 → 写 CHANGELOG → 提交<br>Refresh stars via API → check repos → discover new tools → log → commit |
| **一句话 · One-liner** | 新环境一键上手<br>Bootstrap a fresh environment | 让清单自我保鲜<br>Keep the manifest fresh |

> 一句话用法 · TL;DR — clone 本仓库，对你的 Agent 说：**"读 AGENTS.md 并按说明安装 skill"**。
> Clone this repo and tell your agent: **"read AGENTS.md and install the skills."**

---

## 中文

**这是什么** — 一个纯文档仓库,收录了一份跨 Agent 通用的推荐 skill 清单,任意 AI 编程 Agent 都能读懂并据此为自己安装合适的 skill。
**给 Agent** — 让你的 Agent 读 [`AGENTS.md`](./AGENTS.md),它会自动挑出适配自己的 skill 并安装。
**给用户** — 在你的 Agent 里打开本仓库,说"读 AGENTS.md 并按说明安装 skill"。
**清单** — 见 [`skills/INDEX.md`](./skills/INDEX.md)。
**原理** — 见 [`docs/how-it-works.md`](./docs/how-it-works.md)。
**贡献** — 见 [`CONTRIBUTING.md`](./CONTRIBUTING.md)。
**自迭代** — 让 Agent 读 [`SELF-UPDATE.md`](./SELF-UPDATE.md) 自动刷新信息、发现新工具。
> 星数与适配情况以 2026-07 为准。

## English

**What** — A documentation-only repo containing a cross-agent manifest of recommended skills that any AI coding agent can read and use to install the skills that fit it.
**For agents** — Point your agent at [`AGENTS.md`](./AGENTS.md); it selects and installs the skills that fit it.
**For humans** — Open this repo in your agent and say "read AGENTS.md and install the skills."
**Manifest** — see [`skills/INDEX.md`](./skills/INDEX.md).
**How it works** — see [`docs/how-it-works.md`](./docs/how-it-works.md).
**Contributing** — see [`CONTRIBUTING.md`](./CONTRIBUTING.md).
**Self-iterate** — point your agent at [`SELF-UPDATE.md`](./SELF-UPDATE.md) to refresh data and discover new tools.
> Star counts and compatibility are as of 2026-07.
