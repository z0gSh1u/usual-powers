---
name: resolve-conflicts
description: Resolve existing Git merge conflicts by understanding the intent behind both sides, using optional user-provided context, preserving compatible changes, and validating the result. Use when the working tree has conflict markers or an in-progress merge, rebase, or cherry-pick needs conflict resolution.
---

# Resolve Conflicts

请你结合我们的修改和对方的修改的目的，合理地解决现有合并冲突。可补充的背景：[ARGUMENTS]

## Workflow

1. Read the optional background in `[ARGUMENTS]`. Treat it as context, then verify it against the repository, current diff, and tests.
2. Inspect the repository state:
   - `git status --short`
   - `git diff --name-only --diff-filter=U`
   - the relevant merge, rebase, or cherry-pick metadata and commit history.
3. For every conflicted file, read the surrounding code and compare both sides. Do not blindly choose `ours` or `theirs`; their meaning can differ during a rebase. Check callers, related files, recent commits, and tests when they clarify intent.
4. Resolve conflicts by preserving both changes when they are compatible. When they are not, choose the behavior that fits the current architecture, the intended change on each side, the supplied background, and existing tests. Keep imports, types, APIs, configuration, and generated artifacts coherent.
5. Remove all conflict markers and stage each resolved file only when its contents are correct. Do not commit or continue the merge/rebase/cherry-pick unless the user explicitly asks for that.
6. Validate the result:
   - search the relevant working tree for `<<<<<<<`, `=======`, and `>>>>>>>`;
   - run `git diff --check` and inspect the complete resolved diff;
   - run focused tests, lint, type checks, or builds appropriate to the changed files;
   - confirm `git diff --name-only --diff-filter=U` is empty.

If the repository does not contain an active conflict, report that clearly instead of manufacturing a resolution. If a material decision cannot be inferred safely, explain the competing intents and ask for the missing context before choosing.

## Report

Summarize:

- resolved files and the key decisions made;
- validations run and their results;
- any remaining ambiguity, skipped validation, or required follow-up.
