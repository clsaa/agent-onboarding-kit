# docs/how-it-works.md — 原理说明 / How It Works

## 中文

### 这是什么样的仓库

`agent-onboarding-kit` 是一个**纯文档仓库**——没有构建系统、没有脚本、没有 CI。它把"文档当作产品"(docs-as-product):仓库本身不安装任何东西,它只是一份结构化、机器可读的清单,由打开这个仓库的 AI 编程 Agent(Claude Code / Codex / OpenCode 等)自己读懂、自己决定装什么、自己执行安装命令。换句话说,产品不是代码,而是这些 Markdown 文件本身——它们的结构、措辞和可核验性就是全部的交付物。

### `AGENTS.md` 的角色

[`AGENTS.md`](../AGENTS.md) 是这个仓库的**入口点**,专门写给 Agent(而不是人类)看。任何 Agent 打开这个仓库,第一件事就应该是读这个文件。它做三件事:

1. 让 Agent 先完成 **Step 0:自我识别**——判断自己是 Claude Code、Codex、OpenCode 还是其他 Agent,因为这决定了后面用哪一列兼容矩阵、跑哪一条安装命令。
2. 给出一套固定的 5 步安装流程(具体步骤见 `AGENTS.md` 正文,下文不重复)。
3. 声明几条护栏规则:不要运行清单之外的脚本;不要动用户无关的配置;如果用户只想要一部分,先问用户;把 `⚠️` 视为可选项(opt-in)。

### 兼容矩阵怎么工作

[`skills/INDEX.md`](../skills/INDEX.md) 里的表格是整个仓库的"数据库"。每一行是一个 skill,每一列是一个目标 Agent(Claude Code / Codex / OpenCode),交叉格子里的符号表示兼容程度:

- `✅` — 官方支持,可以直接装。
- `⚠️` — 能用,但没有官方文档背书,风险自负,视为可选(opt-in)。
- `❌` — 不支持,跳过。

Agent 只需要找到自己对应的那一列,筛出 `✅`(以及愿意尝试的 `⚠️`)的行,再点开每一行 `Details` 链接指向的 `skills/<slug>.md`,就能拿到针对自己的具体安装命令。这样一份表格就能同时服务三种不同的 Agent,而不需要为每个 Agent 单独写一份清单。

### 完整的安装步骤在哪

安装流程定义在 [`AGENTS.md`](../AGENTS.md) 里,那是权威版本——完整的 5 个步骤请看那份文件,这里不重复一份可能跑偏的副本。

### 第二种模式:自迭代

除了上面这套"安装模式",本仓库还有第二种模式:**自迭代(self-iteration)**。当有人让 Agent "更新/维护这个仓库本身"时(而不是用它去装 skill),Agent 应改读 [`SELF-UPDATE.md`](../SELF-UPDATE.md)。那份文件是维护者手册:指导 Agent 用 GitHub API 刷新星数、复核兼容性、发现新的高质量 skill 并按 `CONTRIBUTING.md` 的规则加进清单,最后记录到 `CHANGELOG.md`。简单说:`AGENTS.md` 是"读我来装东西",`SELF-UPDATE.md` 是"读我来更新自己"。

---

## English

### What kind of repo this is

`agent-onboarding-kit` is a **documentation-only repo** — no build system, no scripts, no CI. It treats docs as the product: the repo itself installs nothing. It is a structured, machine-readable manifest that any AI coding agent (Claude Code, Codex, OpenCode, etc.) opens, reads, and acts on directly — deciding for itself what to install and running the install commands itself. The deliverable isn't code; it's the Markdown files themselves — their structure, wording, and verifiability are the whole product.

### The role of `AGENTS.md`

[`AGENTS.md`](../AGENTS.md) is this repo's **entry point**, written for an agent, not a human. Any agent opening this repo should read it first. It does three things:

1. Has the agent complete **Step 0: Identify yourself** — determine whether it's Claude Code, Codex, OpenCode, or another agent, since that decides which compatibility-matrix column and which install command apply.
2. Lays out a fixed 5-step install procedure (the steps themselves live in `AGENTS.md`'s own body; not repeated below).
3. States a few guardrails: never run scripts not listed here; never touch the user's unrelated config; ask the user before installing if they only wanted a subset; treat `⚠️` items as opt-in.

### How the compatibility matrix works

The table in [`skills/INDEX.md`](../skills/INDEX.md) is the repo's "database." Each row is a skill; each column is a target agent (Claude Code / Codex / OpenCode). The symbol in each cell marks how compatible that skill is with that agent:

- `✅` — officially supported, safe to install directly.
- `⚠️` — works, but not officially documented; use at your own discretion, treat as opt-in.
- `❌` — not supported, skip.

An agent only needs to find its own column, filter to the `✅` rows (plus any `⚠️` rows it's willing to try), then follow each row's `Details` link to `skills/<slug>.md` to get the exact install command for itself. One table serves three different agents without needing a separate manifest per agent.

### Where the full install steps live

The install flow is defined in [`AGENTS.md`](../AGENTS.md); see there for the authoritative 5 steps — it isn't duplicated here so there's only one copy to keep correct.

### The second mode: self-iteration

Besides the "install mode" above, this repo has a second mode: **self-iteration**. When someone asks an agent to update or maintain the repo itself (rather than use it to install skills), the agent should read [`SELF-UPDATE.md`](../SELF-UPDATE.md) instead. That file is a maintainer playbook: it directs the agent to refresh star counts via the GitHub API, re-verify compatibility, discover new high-value skills and add them following `CONTRIBUTING.md`'s rules, and log the run in `CHANGELOG.md`. In short: `AGENTS.md` means "read me to install things"; `SELF-UPDATE.md` means "read me to update yourself."
