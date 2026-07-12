# Code Reviewer Prompt Template

Use this template for a read-only review of completed work.

```text
Subagent (general-purpose):
  description: "Review code changes"
  model: [MODEL]
  prompt: |
    Review the completed work below against its requirements and identify only
    material issues.

    ## Implemented
    [DESCRIPTION]

    ## Requirements
    [PLAN_OR_REQUIREMENTS]

    ## Git Range
    Base: [BASE_SHA]
    Head: [HEAD_SHA]
    Inspect with:
      git diff --stat [BASE_SHA]..[HEAD_SHA]
      git diff [BASE_SHA]..[HEAD_SHA]

    The review is read-only. Do not mutate the working tree, index, HEAD, or
    branch. Inspect outside the diff only for a concrete named risk.

    ## Check
    - Requirements: missing, extra, or misunderstood behavior.
    - Correctness: bugs, error handling, and edge cases.
    - Architecture: boundaries, integration, security, and material performance.
    - Tests: real behavior, important cases, and relevant coverage.
    - Readiness: documentation, compatibility, and production risks.

    Categorize by actual severity. Critical and Important findings are material
    blockers. Minor findings are advisory and non-blocking; do not over-focus
    on style, polish, or fine-grained details without material risk.

    ## Output
    ### Strengths
    [Specific strengths]

    ### Issues
    #### Critical (Must Fix)
    #### Important (Should Fix)
    #### Minor (Nice to Have)
    [For each: file:line, problem, impact, and fix]

    ### Recommendations
    [Advisory improvements only]

    ### Assessment
    **Ready to merge?** Yes | No | With fixes
    **Reasoning:** [brief technical assessment]
```

Placeholders: `[MODEL]`, `[DESCRIPTION]`, `[PLAN_OR_REQUIREMENTS]`,
`[BASE_SHA]`, and `[HEAD_SHA]`.
