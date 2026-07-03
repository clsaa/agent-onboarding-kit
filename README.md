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
| **做什么 · What** | 识别 → 匹配 → 安装 → 验证 | 刷新数据 → 发现 → 提交 |
| **一句话 · One-liner** | 一键上手 · Bootstrap | 保持新鲜 · Keep fresh |

**安装模式** — Agent 识别自己 → 读适配矩阵 → 装适配自己的 skill → 验证 → 汇报。
**Install mode** — the agent identifies itself, reads the compatibility matrix, installs the skills that fit it, verifies, and reports back.

**自迭代模式** — 刷新星数(GitHub API)→ 校验仓库存活 → 发现新工具 → 写 CHANGELOG → 提交。
**Self-iterate mode** — refresh star counts via the GitHub API, check repos are still alive, discover new tools, log to CHANGELOG, and commit.

> 一句话用法 · TL;DR — clone 本仓库,对你的 Agent 说:**"读 AGENTS.md 并按说明安装 skill"**。
> Clone this repo and tell your agent: **"read AGENTS.md and install the skills."**

**一览 · At a glance** — 完整矩阵见 [`skills/INDEX.md`](./skills/INDEX.md),这里截取三行看个形状:
**At a glance** — the full matrix lives in [`skills/INDEX.md`](./skills/INDEX.md); here's a 3-row excerpt to see the shape:

```
| # | Skill | Type | Claude Code | Codex | OpenCode | Stars |
|---|-------|------|:-----------:|:-----:|:--------:|-------|
| 1  | [Superpowers](./skills/superpowers.md)                   | Framework | ✅ | ✅ | ✅ | 245k |
| 5  | [Vercel Agent Skills](./skills/vercel-agent-skills.md)   | Bundle    | ✅ | ✅ | ✅ | 28.6k |
| 10 | [Awesome Agent Skills](./skills/awesome-agent-skills.md) | Directory | ✅ | ✅ | ✅ | 27.2k |
```

**前置条件 · Prerequisites** — 大多数安装通过 `npx skills add <owner/repo>` 完成(即 skills.sh 提供的 `skills` CLI),因此需要 **Node.js / npx**;其中一项使用 `pnpx`(pnpm)。
Most installs run via `npx skills add <owner/repo>` (the `skills` CLI from skills.sh), so **Node.js / npx** is required; one entry uses `pnpx` (pnpm).

---

## 中文

**这是什么** — 一个纯文档仓库,收录了一份跨 Agent 通用的推荐 skill 清单(工作原理见上方"两种模式")。

- 清单: [`skills/INDEX.md`](./skills/INDEX.md)
- 安装入口: [`AGENTS.md`](./AGENTS.md)
- 自迭代入口: [`SELF-UPDATE.md`](./SELF-UPDATE.md)
- 原理: [`docs/how-it-works.md`](./docs/how-it-works.md)
- 贡献: [`CONTRIBUTING.md`](./CONTRIBUTING.md)

**许可 · License** — MIT — see [LICENSE](./LICENSE)。

## English

**What** — A documentation-only repo containing a cross-agent manifest of recommended skills (see "Two modes" above for how it works).

- Manifest: [`skills/INDEX.md`](./skills/INDEX.md)
- Install entry: [`AGENTS.md`](./AGENTS.md)
- Self-iterate entry: [`SELF-UPDATE.md`](./SELF-UPDATE.md)
- How it works: [`docs/how-it-works.md`](./docs/how-it-works.md)
- Contributing: [`CONTRIBUTING.md`](./CONTRIBUTING.md)

**License** — MIT — see [LICENSE](./LICENSE).

---

## 免责声明 · Disclaimer

本清单收录的所有 skill / 工具均为第三方项目;相关名称与商标归其各自所有者所有;收录不代表认可或存在关联关系。星数与适配情况均为尽力而为的快照(以标注日期为准),可能已过期 — 使用前请自行核实。

All skills/tools listed here are third-party projects; names and trademarks belong to their respective owners. Listing here does not imply endorsement or affiliation. Star counts and compatibility are best-effort snapshots (as of the stamped date) and may be stale — verify before relying on them.
