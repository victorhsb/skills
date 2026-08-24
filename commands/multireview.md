---
description: Spawn 3 parallel review agents (correctness, robustness, simplicity) that converge into a unified review.
---

You must review the current change along three dimensions. Each dimension should be reviewed independently by a separate subagent. After all reviews are complete, converge the findings into a single prioritized report.

## Correctness
The code must do what it is intended to do. If the intent is unclear, ask the user before proceeding.

Check for:
- Logic errors or incorrect behavior
- Outdated documentation or comments that no longer match the code (flag as to-do)
- Method or variable names that no longer reflect their behavior (flag as to-do)
- Misuse of APIs, libraries, or language features

## Robustness
The code must handle failures gracefully and be adequately validated. This covers both runtime safety and test coverage.

Check for:
- Missing error handling or unhandled edge cases
- Untested or under-tested code paths
- Missing or incorrect type annotations where the language supports them
- Input validation gaps
- Overly broad catches or silently swallowed errors

## Simplicity
The code must be easy to understand and maintain long-term. This is the lowest-priority dimension — flag issues as warnings rather than blockers.

Check for:
- Methods that are too long or do too many things
- Unnecessarily complex or clever patterns
- Dead code or unused imports
- Poor naming that obscures intent
