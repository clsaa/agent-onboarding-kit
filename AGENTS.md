# AGENTS.md — Agent Onboarding Kit

## Purpose

You are an AI coding agent that has just opened this repository. This file is a manifest: it tells you how to pick a curated set of skills that fit you, install them, and report back to the user. Read it fully before doing anything else, and follow the steps below in order — do not skip ahead to installing a skill before you have identified yourself and filtered the list.

## Step 0: Identify yourself

Before anything else, determine which agent you are: **Claude Code**, **Codex**, **OpenCode**, or another agent. This determines which column of the compatibility matrix applies to you and which install command you should run. If you are unsure, check your own runtime/CLI name or ask the user to confirm.

## The 5-step procedure

- **Step 1** — Read [`skills/INDEX.md`](./skills/INDEX.md) and its compatibility matrix.
- **Step 2** — Filter to rows where your agent column is `✅` (or `⚠️`, with a caution note).
- **Step 3** — For each selected skill, open its `skills/<slug>.md` and run the Install command for your agent.
- **Step 4** — Run the skill's Verify step; if it fails, report the failure and continue.
- **Step 5** — Report to the user: installed, skipped (with reason), and any failures.

## Rules

- Never run scripts not listed here.
- Never modify the user's unrelated config.
- Ask the user before installing if they only wanted a subset.
- Treat `⚠️` items as opt-in.

## Two modes

This file is the **install** mode: use it to pick and install skills into your current environment. To **update or self-iterate** this repo itself (refresh star counts, verify repos, discover new tools), see [`SELF-UPDATE.md`](./SELF-UPDATE.md) instead.
