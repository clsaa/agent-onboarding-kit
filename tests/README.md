# Tests · 测试

End-to-end validation that the manifest is internally consistent and that **both modes** of this repo are actually executable by an AI agent.

给这个仓库的端到端校验：确保清单内部一致，且**两种模式**都能被 AI Agent 真正执行。

## Run · 运行

```bash
bash tests/e2e.sh
```

- Exit code `0` = all checks passed; `1` = at least one `FAIL`. `WARN`s never fail the run.
- 退出码 `0` 表示全部通过；`1` 表示存在 `FAIL`。`WARN` 不会导致失败。
- Network is only needed for section B. Set `GITHUB_TOKEN` to avoid GitHub API rate limits. Offline, section B skips gracefully and the structural suite still runs.
- 仅 B 部分需要联网。设置 `GITHUB_TOKEN` 可避免 GitHub API 限流。离线时 B 部分自动跳过，其余照常运行。

```bash
GITHUB_TOKEN=ghp_xxx bash tests/e2e.sh   # recommended · 推荐
```

## What it checks · 检查内容

The skill list is derived from the filesystem (`skills/*.md`), so a newly added entry is covered automatically — no hand-maintained list.

**A. Structural consistency · 结构一致性**
- Every entry carries every template field. · 每个条目模板字段齐全。
- INDEX ↔ files link set matches **both ways** (no dangling links, no orphan files). · 链接集双向一致（无断链、无孤立文件）。
- **INDEX rows agree with the per-skill files** on compatibility symbols and stars (enforces CONTRIBUTING's "must match exactly"). · 矩阵行与条目文件在兼容符号与星数上完全一致。
- No leaked template placeholders. · 无残留模板占位符。

**B. Self-iterate mode · 自迭代模式** (mirrors `SELF-UPDATE.md` §A)
- Every `Repo:` line parses to an `owner/repo`. · 每个 `Repo:` 行都能解析出 `owner/repo`。
- Each repo is confirmed live via a **positive** GitHub API signal (`full_name`); a rate-limited/error response is a `WARN`, never a silent pass. · 用正向信号确认仓库存活；异常响应只 `WARN`。
- Documented stars sanity-checked vs live (drift > 40% → `WARN`); an unparseable `Stars:` value → `WARN`. · 星数漂移或无法解析则 `WARN`。

**C. Install mode · 安装模式** (mirrors `AGENTS.md`)
- `AGENTS.md` directory guidance names a concrete directory entry. · 目录指引点名具体目录条目。
- **Each agent's** install line (not just one per entry) is runnable, a fenced block, or an explicit exemption. · 每个 Agent 的安装行都可执行或明确豁免。
- Every directory/index entry is labeled as a catalog. · 目录型条目被标注为索引。

**D. Tooling · 工具**
- `scripts/discover.sh` is syntactically valid (`bash -n`). · 发现脚本语法有效。

## When to run · 何时运行

- After editing any `skills/*.md`, `skills/INDEX.md`, or `AGENTS.md`. · 改动清单或入口文件后。
- As the final step of a `SELF-UPDATE.md` self-iterate run. · 自迭代跑完后作为收尾。
- Before opening a PR (see [`../CONTRIBUTING.md`](../CONTRIBUTING.md)). · 提 PR 前。
