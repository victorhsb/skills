---
name: jj-guide
description: Use Jujutsu (jj) for version-control tasks in workspaces with a .jj directory, including local changes, bookmarks, remote publication, conflicts, and recovery.
---

# Working with Jujutsu

Use jj for repository mutations. A colocated workspace also has Git metadata. Run commands from the workspace containing the intended files.

## Inspect and record a change

1. Run `jj status` and `jj diff` to see what belongs to the task. Most jj commands snapshot eligible file edits into the working-copy commit (`@`). Existing edits may already belong to someone else.
2. Choose the commit style that fits the task.
   - To finalize all reviewed edits, run `jj commit -m "message"`. The completed change becomes `@-`. To commit only selected paths, supply those paths after the message. The remaining edits stay in `@`.
   - To keep refining the same change, use `jj describe -m "message"` and continue editing it. To start distinct work on top, use `jj new`.
3. Inspect the resulting change with `jj show <change-id>` and check `jj status` for remaining edits. Use the change ID when referring to a change across rewrites.

For a file-level split, supply both the selected paths and a message, as in `jj split -m "add tests" tests/`. For a squash that should retain the destination description, use `jj squash --use-destination-message`. Both forms run without opening an editor.

## Choose the workflow

- **Push or open a PR.** Follow the [publication workflow](references/workflow-commit-push-pr.md) through the requested endpoint. For remote tracking, forks, or conflicting bookmark targets, see [bookmarks](references/bookmarks.md).
- **Create an isolated working copy.** Follow the [new workspace workflow](references/workflow-new-workspace.md). For stale workspaces, colocation, or ignored files, see [workspaces](references/workspaces.md).
- **Resolve a file conflict.** Inspect the affected revisions, edit the conflicted files, and check that the intended changes have cleared from `jj log -r 'conflicts()'`. See [conflict markers](references/conflicts.md) to interpret the base and sides.
- **Diagnose unexpected state.** Start with [troubleshooting](references/troubleshooting.md). To recover a file or reverse a particular operation, use the [operation log](references/operation-log.md).
- **Select revisions or translate a Git command.** Use [revsets](references/revsets.md) for graph queries, the [Git command mapping](references/git-to-jj.md) for equivalents, and the [glossary](references/glossary.md) for terminology.
