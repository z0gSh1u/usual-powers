# Testing Anti-Patterns

Read this reference when adding mocks, test utilities, or test-only production
methods.

## Core Rules

1. Test real behavior, not mock behavior.
2. Do not add methods to production classes only to make tests easier.
3. Do not mock a dependency until you understand its inputs, outputs, and side
   effects.

## Anti-Patterns

### 1. Testing Mock Behavior

Asserting that a mock element, mock method, or mock call exists proves only that
the test double was configured. Assert the behavior the user or caller depends
on. If the mock is necessary for isolation, test the subject's behavior around
the mock rather than the mock itself.

### 2. Test-Only Production Methods

If a method is used only by tests, put it in test utilities or fixtures. A
production class should own the lifecycle and behavior its real callers need.

### 3. Mocking Without Understanding

Before mocking, identify the real dependency's side effects and the behavior
the test needs to preserve. Mock the narrow external or slow boundary, not a
high-level method whose side effects are part of the behavior under test.

### 4. Incomplete Mocks

Mocks should match the complete structure that downstream code can consume.
Partial responses hide assumptions and allow tests to pass while integration
code fails. Prefer a real fixture or integration test when the structure is
large or unstable.

### 5. Tests as an Afterthought

An implementation without a behavior test is incomplete. Add a failing test,
implement the fix or feature, and keep the test as regression protection.

## Quick Review

| Question | If the answer is yes |
|---|---|
| Does an assertion check a mock's existence or call count instead of behavior? | Test the real behavior or the subject's response. |
| Is a production method used only from tests? | Move it to test utilities. |
| Is the mock setup larger than the behavior under test? | Reduce mocking or use an integration test. |
| Do you know the dependency's side effects? | If not, run it or inspect its contract before mocking. |
| Is the test added after implementation? | Reframe the behavior as a failing test first. |

## Before Marking Complete

- The test fails for the expected reason before the implementation change.
- Assertions describe behavior, not test-double configuration.
- Mocks preserve the side effects the test relies on.
- Test-only helpers stay outside production classes.
- Important behavior has regression coverage.
