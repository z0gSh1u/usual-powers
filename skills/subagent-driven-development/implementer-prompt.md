# Implementer Subagent Prompt Template

Use this template when dispatching an implementation task.

```text
Subagent (general-purpose):
  description: "Implement Task N: [task name]"
  model: [MODEL]
  prompt: |
    Implement Task N: [task name].

    Read the task brief first: [BRIEF_FILE]
    It is the complete source of task requirements.

    Context: [where this task fits, dependencies, and relevant decisions]
    Work from: [directory]
    Report to: [REPORT_FILE]

    Before coding, ask about unclear requirements, dependencies, assumptions,
    or architectural choices. Do not guess when the answer affects scope or
    correctness.

    Work exactly within the brief:
    1. Implement the requested behavior.
    2. Follow TDD when required: failing test, minimal implementation, green
       test, then refactor.
    3. Run focused tests while iterating and the relevant suite before commit.
    4. Self-review for completeness, scope, correctness, and test quality.
    5. Commit the change and write the detailed report.

    If the task is blocked, too large, or requires an unplanned architectural
    decision, return BLOCKED or NEEDS_CONTEXT instead of guessing. If it is
    complete but uncertain, return DONE_WITH_CONCERNS.

    Report file contents:
    - implementation summary;
    - tests and results, including TDD RED/GREEN evidence when required;
    - files changed;
    - self-review findings and concerns.

    Return only:
    - Status: DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
    - commits (short SHA and subject)
    - one-line test summary
    - concerns, if any
    - report path
```
