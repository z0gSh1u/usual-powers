---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent-Driven Development

Execute an implementation plan by giving each task a fresh implementer, a
task-scoped review, and a final whole-branch review.

**Parallel execution:** Maximize parallelism whenever it is safe and useful.
Dispatch independent tasks or review/fix actions concurrently. Choose batching
and ordering from dependencies, file conflicts, shared state, and host
capabilities; the model determines the strategy.

**Convergence:** Minor findings are non-blocking and may be ignored or recorded
without a fix. Only Critical and Important findings require fixes. Allow at
most two review/fix rounds per task or change; then surface unresolved material
issues instead of chasing details. Use focused validation and do not repeatedly
rerun the same checks.

## Use When

- An implementation plan already exists.
- Tasks can be executed in the current session.
- Tasks are independent enough to benefit from separate context.

For a plan that is tightly coupled or must run in another session, use a
different execution workflow.

## Process

1. Read the plan, global constraints, and the progress ledger. Create a todo
   for each task.
2. Before Task 1, scan for task conflicts and requirements that contradict the
   review rubric. Present any conflict as one batched question.
3. For each task:
   - Record the current commit as `BASE_SHA`.
   - Run `scripts/task-brief PLAN_FILE N` and use the generated file as the
     implementer's requirements.
   - Dispatch a fresh implementer with the brief, scene-setting context, and
     report-file path.
   - Handle the implementer's status according to the section below.
   - For `DONE`, run `scripts/review-package BASE_SHA HEAD_SHA` and dispatch
     the task reviewer with the brief, report, diff package, and constraints.
   - Fix only Critical or Important findings, then re-review within the
     two-round limit. Minor findings do not block completion.
   - Mark the task complete in the ledger only after both review verdicts pass.
4. After all tasks, run `scripts/review-package MERGE_BASE HEAD` and dispatch
   the final reviewer using
   [code-reviewer.md](../requesting-code-review/code-reviewer.md).
5. If the final review finds material issues, dispatch one fix wave containing
   the complete findings list, run covering tests, and stay within the same
   two-round limit.

## Implementer Status

- **DONE:** Generate the review package and dispatch the task reviewer.
- **DONE_WITH_CONCERNS:** Read the concerns. Resolve correctness or scope
  concerns before review; record observations and continue.
- **NEEDS_CONTEXT:** Provide the missing context and re-dispatch.
- **BLOCKED:** Change the conditions before retrying: add context, use a more
  capable model, split the task, or escalate a faulty plan to the user.

Do not ignore questions, force a blocked retry, or silently accept incomplete
work.

## Review Rules

Task review checks spec compliance and task quality. The reviewer may report
requirements that cannot be verified from the diff; check those yourself before
marking the task complete. If a plan-mandated requirement conflicts with the
review rubric, show both texts to the user and ask which governs.

Reviewer instructions should:

- describe one task and its actual constraints, not the session history;
- pass the diff as a file instead of pasting it into the dispatch;
- rely on the implementer's test report and run only focused checks for a
  concrete unresolved doubt;
- send all Critical and Important findings to one fix dispatch when possible;
- include covering test files and require the fix report to contain the command
  and result before re-review.

Do not instruct a reviewer to suppress a legitimate finding or preassign its
severity. The controller decides whether a reported finding blocks progress
using the severity and convergence rules above.

## File Handoffs

Keep large artifacts out of dispatch messages:

- `scripts/task-brief PLAN_FILE N` creates the implementer's task brief.
- The implementer writes its detailed report to the matching report path and
  returns only status, commits, test summary, and concerns.
- `scripts/review-package BASE HEAD` creates the diff package for reviewers.
- Fixes append test evidence to the same report; re-reviews read the updated
  report and package.

## Durable Progress

At startup, check:

```bash
cat "$(git rev-parse --show-toplevel)/.superpowers/sdd/progress.md"
```

Do not re-dispatch tasks already marked complete. After a clean task review,
append:

```text
Task N: complete (commits <base7>..<head7>, review clean)
```

Use the ledger and `git log` to recover after compaction.

## Prompt Templates

- [implementer-prompt.md](implementer-prompt.md)
- [task-reviewer-prompt.md](task-reviewer-prompt.md)
- Final review: [code-reviewer.md](../requesting-code-review/code-reviewer.md)

## Integration

- `writing-plans` creates the plan.
- `requesting-code-review` supplies the final reviewer.
- `test-driven-development` supplies the implementation test workflow.
