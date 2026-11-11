# Create an isolated workspace

Choose an unused directory, workspace name, and base revision for the task. A sibling directory keeps the new files outside the original working copy. Each workspace has its own working-copy commit and shares the repository graph and bookmarks.

1. Run `jj workspace add --name <name> -r <base> <path>` from the existing workspace. The new working-copy commit is already a child of the selected base.
2. Enter the new directory. Check `jj workspace root` and `jj log -r '@ | @-'` to verify the path and parent.
3. If the task needs a bookmark, create it with `jj bookmark create <name> -r @` and verify its target with `jj bookmark list`. Use distinct bookmarks for independent work.

For GitHub operations from a workspace without Git metadata, pass the intended repository to `gh` with `--repo OWNER/REPO`. See the [publication workflow](workflow-commit-push-pr.md) for PR creation.

When retiring a workspace, inspect its status and on-disk files, including ignored files. From a surviving workspace, use `jj workspace forget <name>` to unregister the intended workspace and verify with `jj workspace list`. Directory deletion is a separate action.
