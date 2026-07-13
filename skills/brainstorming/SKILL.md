---
name: brainstorming
description: 'Use only when the user explicitly asks for brainstorming or asks to run this design-refinement workflow; do not activate for ordinary feature requests unless explicitly requested.'
---

# Brainstorming Ideas Into Designs

Turn an idea into an agreed design and a written spec through focused dialogue.

<HARD-GATE>
Keep implementation work paused until you have presented a design and the user
has approved it.
</HARD-GATE>

## Workflow

1. Explore the project context: files, docs, and recent commits.
2. If the scope contains independent subsystems, split it into separate
   projects before refining details.
3. Ask clarifying questions one at a time about purpose, constraints, and
   success criteria.
4. Offer 2–3 approaches with trade-offs and a recommendation.
5. Present the design in sections sized to the problem and get approval.
6. Write the approved design to
   `docs/specs/YYYY-MM-DD-<topic>-design.md` and commit it.
7. Self-review the spec for placeholders, contradictions, ambiguity, and scope.
8. Ask the user to review the written spec. Apply requested changes and repeat
   the self-review.
9. After approval, hand off to `writing-plans`.

## Conversation Rules

- Start with context, then ask one question per message.
- Before asking, prioritize decisions that affect architecture, scope, interfaces,
  behavior, or acceptance criteria; inspect the repository or follow existing
  conventions for facts that can be determined without asking.
- Give a recommended answer first, explain its main trade-off, then ask the user
  to confirm it or choose an alternative. Allow open-ended input when choices
  would constrain the decision prematurely.
- Follow existing project patterns and avoid unrelated refactoring.
- Remove unrequested features and over-engineering.
- Cover architecture, components, data flow, error handling, and testing only
  to the depth the project needs.

## Spec Review

Before asking the user to review the file, check:

- every requirement has a clear home in the design;
- no `TBD`, `TODO`, placeholders, or conflicting requirements remain;
- the scope fits one implementation plan, or is explicitly decomposed;
- interfaces, names, and behavior are unambiguous.

For an optional independent review, use
[spec-document-reviewer-prompt.md](spec-document-reviewer-prompt.md).

## Visual Companion

Offer the visual companion only when a question is genuinely clearer as a
mockup, diagram, or side-by-side comparison. Do not offer it for ordinary text
requirements or trade-off questions. If the user accepts, read
[visual-companion.md](visual-companion.md) before using it.

## Handoff

After the user approves the spec, use `writing-plans` to create the
implementation plan. Do not start implementation in this workflow.
