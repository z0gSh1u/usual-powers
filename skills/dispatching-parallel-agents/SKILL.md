---
name: dispatching-parallel-agents
description: Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies
---

# Dispatching Parallel Agents

Use concurrent agents when multiple problem domains can be investigated or
changed independently. One agent per independent domain keeps context focused.

## Decide

Parallelize when:

- failures belong to different test files or subsystems;
- each task can be understood without another task's result;
- agents will not write the same files or share mutable state.

Work sequentially when failures are related, one fix may resolve the others, or
later work depends on an earlier result.

## Dispatch

Give each agent a focused, self-contained prompt with:

- the exact problem or file scope;
- the desired outcome;
- constraints on files and behavior;
- the expected report.

Issue all independent dispatches in the same response when the host supports
concurrency. Separate dispatches across responses are sequential.

## Integrate

When agents return:

1. Read each report and identify overlapping changes.
2. Resolve conflicts and verify that each fix addresses its own problem.
3. Run the relevant combined validation.

Do not use parallel agents for a shared-state change merely to reduce elapsed
time; coordination cost can exceed the benefit.
