# Diagnose unexpected repository state

Run `jj status`, `jj log --limit 30`, and `jj op log --limit 20` in the affected workspace. Identify the change, bookmark, or operation responsible before applying a fix. If a command is denied, use the environment's approval path when the requested task requires that command.

| Symptom | Inspect and act |
|---|---|
| A change or file disappeared | Inspect the earlier view with `jj --at-op <id> log`. Use the [operation log](operation-log.md) to recover the intended file or change. |
| One change ID has multiple visible commits | Compare the candidates by commit ID with `jj show`. Select the version containing the intended edits before reconciling the divergence. |
| A push targets the wrong change or the remote has advanced | Compare the local and remote tips with `jj bookmark list --all-remotes`. Follow the [bookmark workflow](bookmarks.md) to reconcile the targets. |
| Conflicts appeared across a stack | Use `jj log -r 'conflicts()'` to find the earliest affected change. Resolve the [file conflict](conflicts.md) there if that change is mutable and within scope. |
| A rewrite targets an immutable commit | Identify the mutable source revision. Use the protected commit as a base when needed. |
| The working copy is stale | Run `jj workspace update-stale` in the affected workspace and check `jj status`. |

## Choose a rebase source

Preview the source with `jj log -r '<revset>'`. Use `jj rebase -r <rev> -o <base>` to move a single revision, or `jj rebase -s <rev> -o <base>` to move a revision with its descendants. Check the resulting parents, descendants, and conflicts with `jj log`.
