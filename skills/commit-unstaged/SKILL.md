---
name: commit-unstaged
description: Commit all current unstaged Git changes, including untracked files, grouping them into logical commits when needed. Use when the user asks to commit unstaged work or says “提交所有 unstaged 的改动”.
---

# Commit Unstaged

提交所有当前 unstaged 的改动，必要时按逻辑拆分为多个 commit。默认不修改已有 commit，不推送，也不创建 PR。

## Workflow

1. Inspect the repository before changing the index:
   - `git status --short`
   - `git diff`
   - `git diff --cached`
   - untracked files and relevant ignore rules.
2. Define the scope precisely. Include tracked modifications, deletions, and untracked files that are part of the user's unstaged work. Preserve unrelated existing staged changes; do not reset, stash, amend, or discard them.
3. Check for obvious secrets, credentials, private keys, generated junk, build output, and temporary files. Do not commit sensitive or accidental files; report them and ask for direction if they are part of the requested scope.
4. Infer the repository's commit conventions from recent history. Group changes into coherent commits when they represent independent purposes, such as implementation, tests, configuration, or documentation. Keep files that must change together in the same commit.
5. For each logical group:
   - stage only that group's unstaged changes, using path-specific commands or `git add -p` when necessary;
   - inspect `git diff --cached` and run `git diff --cached --check`;
   - confirm the staged diff contains the intended changes and no unrelated content;
   - create a concise commit message that describes the group in the repository's usual style.
6. Repeat until every requested unstaged change has been committed. If existing staged changes prevent a clean separation, preserve them and explain the boundary instead of silently mixing scopes.
7. Verify with `git status --short` and recent commit history. Confirm what was committed, what remains staged or unstaged, and any files intentionally left out.

## Guardrails

- Never use `git reset --hard`, `git checkout --`, `git clean`, or equivalent destructive commands.
- Never commit secrets, credentials, unrelated user changes, or unreviewed generated artifacts.
- Never alter tests or source code merely to justify a commit.
- Do not run validation commands unless they are useful for understanding the changes or the user asks for them; this Skill's primary job is committing, not pre-PR verification.
- If a hook fails, inspect and fix the underlying issue when it is clearly safe; otherwise report the failed hook and leave the changes available for the user.

## Report

Summarize:

- commit hashes and messages created;
- logical groups used for splitting;
- files or changes intentionally excluded;
- the final `git status` and any hook or validation result.
