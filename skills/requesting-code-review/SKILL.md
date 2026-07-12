---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

# Requesting Code Review

Dispatch a focused reviewer with the requirements and exact change range.

## When

Review:

- after each task in `subagent-driven-development`;
- after a major feature;
- before merging;
- when a fresh perspective would resolve a concrete doubt.

Do not create an open-ended review loop.

## How

1. Record the base and head commits.
2. Fill [code-reviewer.md](code-reviewer.md) with the change description and
   requirements.
3. Dispatch a read-only reviewer.
4. Fix Critical issues immediately and Important issues before proceeding.
5. Ignore or record Minor issues without dispatching a fix solely for them.
6. Allow at most two review/fix rounds for the same change. After the second,
   surface unresolved material issues instead of chasing details.

Review correctness, requirements, security, and material maintainability. Do
not over-focus on style, polish, or fine-grained nitpicks.

## Red Flags

- Never skip review only because a change looks simple.
- Never proceed with unresolved Critical or Important issues.
- Do not let Minor issues block progress.
- Do not continue review/fix beyond two rounds for one change.
- If the reviewer is wrong, respond with concrete code or test evidence.
