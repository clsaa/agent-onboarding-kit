# ⚡ skillrc

> **The rc file for your AI coding agent.**
> **Point any AI coding agent at one file — it reads it and sets itself up.**
> Claude Code · Codex · OpenCode. A curated, cross-agent skills manifest — and unlike a static awesome-list, **it updates itself.**
>
> **让任意 AI 编程 Agent 读一个文件，就自己装好一套推荐 skill。** 跨 Agent、经过验证，而且**清单能自我更新**——这是它区别于所有静态 awesome-list 的地方。

<p align="center">
  <a href="https://github.com/clsaa/skillrc/actions/workflows/e2e.yml"><img alt="E2E" src="https://github.com/clsaa/skillrc/actions/workflows/e2e.yml/badge.svg"></a>
  <a href="./LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
  <a href="https://github.com/clsaa/skillrc/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/clsaa/skillrc?style=flat&logo=github"></a>
  <img alt="Skills" src="https://img.shields.io/badge/skills-10%20core%20%2B%2014%20extra-blue">
  <img alt="Agents" src="https://img.shields.io/badge/agents-Claude%20Code%20%7C%20Codex%20%7C%20OpenCode-8A2BE2">
  <a href="./CONTRIBUTING.md"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen"></a>
  <img alt="Data as of" src="https://img.shields.io/badge/data-2026--07-lightgrey">
</p>

---

## ⚡ Quick start · 快速开始

Clone it, then paste this to your agent (Claude Code / Codex / OpenCode):
克隆后，把这句话丢给你的 Agent：

```text
Read AGENTS.md in this repo and install the skills that fit you. Then tell me what you installed and what you skipped.
```

That's it — the agent identifies itself, filters the compatibility matrix, installs the skills that fit, verifies, and reports back. To keep the manifest fresh later, point it at `SELF-UPDATE.md`.
就这样——Agent 会识别自己、按适配矩阵筛选、安装、验证并汇报。之后想让清单保鲜，就让它读 `SELF-UPDATE.md`。

<!-- 📽️ Demo GIF goes here — record a 15s clip: paste the prompt above into Claude Code / Codex,
     show the agent self-identifying, installing, and reporting. Replace this comment with:
     <p align="center"><img src="docs/demo.gif" alt="agent reading AGENTS.md and installing skills" width="720"></p> -->

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

## 🆚 Why not just a skills list? · 和普通清单有何不同

|  | 📄 Static awesome-list | 🛠️ A single registry (e.g. skills.sh) | 🚀 **skillrc** |
|---|:---:|:---:|:---:|
| Cross-agent (Claude Code / Codex / OpenCode) matrix · 跨 Agent 适配矩阵 | ⚠️ mixed | ✅ | ✅ |
| Per-agent install command for each skill · 逐 Agent 安装命令 | ❌ | ⚠️ | ✅ |
| Data verified + CI-gated (stars, repo liveness) · 数据经 CI 验证 | ❌ | ⚠️ | ✅ |
| Agent reads one file & installs itself · Agent 读一个文件自装 | ❌ | ❌ | ✅ |
| **Self-updating manifest** · **清单自我更新** | ❌ | ❌ | ✅ |

The last two rows are the point: this repo isn't just a list you read — it's a file your **agent** reads and acts on, and one that **refreshes itself** (`SELF-UPDATE.md`) instead of rotting.
最后两行才是关键：它不是给你读的清单，而是给你的 **Agent** 读并执行的文件，而且会**自我更新**（`SELF-UPDATE.md`），而不是慢慢过期。

**一览 · At a glance** — 完整矩阵见 [`skills/INDEX.md`](./skills/INDEX.md),这里截取三行看个形状:
**At a glance** — the full matrix lives in [`skills/INDEX.md`](./skills/INDEX.md); here's a 3-row excerpt to see the shape:

```
| # | Skill | Type | Claude Code | Codex | OpenCode | Stars |
|---|-------|------|:-----------:|:-----:|:--------:|-------|
| 1  | [Superpowers](./skills/superpowers.md)                   | Framework | ✅ | ✅ | ✅ | 246k |
| 5  | [Vercel Agent Skills](./skills/vercel-agent-skills.md)   | Bundle    | ✅ | ✅ | ✅ | 28.7k |
| 10 | [Awesome Agent Skills](./skills/awesome-agent-skills.md) | Directory | ✅ | ✅ | ✅ | 27.3k |
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
