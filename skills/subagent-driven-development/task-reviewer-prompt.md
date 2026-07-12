# Task Reviewer Prompt Template

Use this template for the task-scoped spec and quality review.

```text
Subagent (general-purpose):
  description: "Review Task N: [task name]"
  model: [MODEL]
  prompt: |
    Review one task's implementation against its requirements and quality
    standards. This is a task gate, not the final whole-branch review.

    Task brief: [BRIEF_FILE]
    Implementer report: [REPORT_FILE]
    Diff package: [DIFF_FILE]
    Base: [BASE_SHA]
    Head: [HEAD_SHA]
    Global constraints: [GLOBAL_CONSTRAINTS]

    Read the brief, report, and diff package. The diff package is the primary
    view of the change. Inspect outside the diff only for one named risk. This
    review is read-only.

    Verify the implementer's claims against the diff. Do not rerun the suite
    solely to confirm the report; run a focused test only for a concrete doubt
    the report and diff do not answer.

    Spec review:
    - missing requirements;
    - unrequested or over-engineered additions;
    - misunderstood requirements;
    - requirements that cannot be verified from the diff.

    Quality review:
    - correctness and error handling;
    - maintainability and separation of responsibilities;
    - meaningful behavior and edge-case tests;
    - material security, performance, or integration risks.

    Categorize by actual severity. Critical and Important findings block the
    task. Minor findings are advisory and non-blocking; do not request a fix
    solely for Minor or over-focus on style and fine-grained polish.

    Return only this report:

    ### Spec Compliance
    - ✅ compliant | ❌ issues: [file:line evidence]
    - ⚠️ cannot verify: [requirement and controller check]

    ### Strengths
    [Specific strengths]

    ### Issues
    #### Critical (Must Fix)
    #### Important (Should Fix)
    #### Minor (Nice to Have)
    [For each: file:line, problem, impact, and fix]

    ### Assessment
    **Task quality:** Approved | Needs fixes
    **Reasoning:** [brief technical assessment]
```

Required placeholders: `[MODEL]`, `[BRIEF_FILE]`, `[REPORT_FILE]`,
`[DIFF_FILE]`, `[BASE_SHA]`, `[HEAD_SHA]`, and `[GLOBAL_CONSTRAINTS]`.
