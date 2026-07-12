---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
---

# Test-Driven Development

Write the test first, observe the expected failure, implement the smallest
behavior that passes, then refactor without changing behavior.

## When to Use

Use for new features, bug fixes, refactors, and behavior changes. Ask before
skipping it for throwaway prototypes, generated code, or configuration-only
changes.

## The Rule

Do not write production code before a failing test exists for the behavior.

## Cycle

1. **RED:** Write one focused test for the desired behavior.
2. **Verify RED:** Run it and confirm it fails for the expected missing or
   incorrect behavior, not because of a test error.
3. **GREEN:** Write the minimum production code that passes.
4. **Verify GREEN:** Run the focused test and relevant regressions. Keep output
   clean.
5. **REFACTOR:** Remove duplication and improve names or structure while tests
   stay green.
6. Repeat for the next behavior.

## Test Quality

- Test real behavior rather than mock behavior.
- Keep each test focused, with a clear name and meaningful assertions.
- Mock only an understood external boundary or unavoidable dependency.
- Cover important errors and edge cases without speculative behavior.
- Prefer a simple integration test over a complex arrangement of mocks.

## Verification Checklist

- [ ] The test failed for the expected reason before implementation.
- [ ] The implementation is the minimum needed for the behavior.
- [ ] Focused and relevant regression tests pass.
- [ ] Tests use real behavior where practical.
- [ ] Output is clean and edge cases are covered.

## When Stuck

- If the API is unclear, write the assertion for the API you wish existed.
- If the test is difficult to set up, simplify the design or isolate a real
  boundary.
- If mocking feels necessary, first understand the dependency and its side
  effects.
- If a bug is found, first add a failing regression test.

For mock-specific guidance, read
[testing-anti-patterns.md](testing-anti-patterns.md).
