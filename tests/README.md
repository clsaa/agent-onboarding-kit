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

**A. Structural consistency · 结构一致性**
- Every `skills/INDEX.md` Details link resolves to a real file. · 矩阵里每个链接都指向真实文件。
- All 15 entries (10 core + 5 extra) exist and carry every template field. · 15 个条目模板字段齐全。
- No leaked template placeholders (`<command>`, `<symbol>`, `<category>`, `TODO`…). · 无残留模板占位符。

**B. Self-iterate mode · 自迭代模式** (mirrors `SELF-UPDATE.md` §A/§D)
- Every `Repo:` line parses to an `owner/repo`. · 每个 `Repo:` 行都能解析出 `owner/repo`。
- Each repo is live via the GitHub API (not 404, not archived/renamed). · 每个仓库经 GitHub API 确认存活。
- Documented star counts are sanity-checked against live values (drift > 40% → `WARN`, run `SELF-UPDATE.md`). · 文档星数与实时值对比，偏差过大则 `WARN`。

**C. Install mode · 安装模式** (mirrors `AGENTS.md`)
- `AGENTS.md` explicitly handles directory/index entries. · `AGENTS.md` 明确处理目录型条目。
- Every normal entry exposes a runnable install command. · 每个普通条目都有可执行安装命令。
- Every directory/index entry is labeled as a catalog (no single command expected). · 每个目录型条目都被标注为索引。

## When to run · 何时运行

- After editing any `skills/*.md`, `skills/INDEX.md`, or `AGENTS.md`. · 改动清单或入口文件后。
- As the final step of a `SELF-UPDATE.md` self-iterate run. · 自迭代跑完后作为收尾。
- Before opening a PR (see [`../CONTRIBUTING.md`](../CONTRIBUTING.md)). · 提 PR 前。
