---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

Turn an approved spec into a detailed, independently executable plan. Assume
the implementer knows the language but not this repository or the feature.

**Save to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`

## Before Writing

- If the spec covers independent subsystems, split it into separate specs and
  plans first.
- Map the files to create or modify and the responsibility of each.
- Follow existing project patterns. Do not add unrelated refactoring.

## Task Design

Each task must produce a self-contained, testable change and identify:

- exact files to create, modify, and test;
- interfaces consumed and produced;
- the implementation steps, including concrete code where needed;
- the exact test commands and expected result;
- a commit point.

Split tasks where a reviewer could approve one deliverable while rejecting the
next. Keep tightly coupled setup, implementation, tests, and documentation in
the same task.

## Plan Header

Start every plan with:

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use `subagent-driven-development` to implement this plan task-by-task. Use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about the approach]

**Tech Stack:** [Key technologies and libraries]

## Global Constraints

[Project-wide requirements copied from the spec, with exact values.]

---
```

## Task Format

```markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file`
- Modify: `exact/path/to/existing-file`
- Test: `exact/path/to/test-file`

**Interfaces:**
- Consumes: [exact inputs from earlier tasks]
- Produces: [exact names and types later tasks rely on]

- [ ] **Step 1: Write the failing test**
- [ ] **Step 2: Run the focused test and verify the expected failure**
- [ ] **Step 3: Implement the minimum behavior**
- [ ] **Step 4: Run the focused and relevant regression tests**
- [ ] **Step 5: Commit the task**
```

Do not leave `TBD`, `TODO`, vague steps, undefined names, or references to
another task instead of the needed details. Use exact paths, signatures,
commands, and expected results.

## Self-Review

Before handing off, verify:

- every spec requirement maps to a task;
- tasks have clear boundaries and independently testable deliverables;
- names, types, paths, and dependencies are consistent;
- no placeholders, scope creep, or contradictory instructions remain.

Fix issues inline. An optional plan review can use
[plan-document-reviewer-prompt.md](plan-document-reviewer-prompt.md).

## Execution Handoff

After saving the plan:

> Plan complete and saved to `docs/plans/<filename>.md`. Next I will use `subagent-driven-development`.

Use `subagent-driven-development` for execution. There is no inline execution
path in this workflow.
