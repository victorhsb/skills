# Operation Log, Undo, and Recovery

Every `jj` command that mutates the repo records an **operation**. The set of operations forms a DAG (the *operation log*), which is jj's equivalent of `git reflog` — but more powerful: it's atomic across all bookmarks and the working copy, and it lets you replay or rewind the entire repo state, not just per-ref histories.

## Inspecting

```bash
jj op log                       # full operation history
jj op log --limit 20            # most recent 20
jj op show @                    # details of the most recent operation
jj op show <op-id> -p           # details with patch
```

Each operation contains a **view**: a snapshot of bookmarks, tags, Git refs, visible heads, and the working-copy commit at the end of the operation, plus metadata (timestamps, host, user, description).

In `jj op log`, `@` refers to the *current* operation (similar to how `@` refers to the working-copy commit elsewhere). Operators `@-` and `@+` walk parent/child operations.

## Undo

```bash
jj undo            # reverse the most recent operation
jj op revert <id>  # reverse a specific (non-most-recent) operation
jj op restore <id> # rewind the entire repo to that operation's state
```

Inspect the operation and its patch before reversing it. Use whole-repository restore only when the requested result is the complete earlier local view. Remote pushes and PRs have separate state.

## Loading the Repo at a Past Operation

`--at-operation` (or `--at-op`) is a top-level flag accepted by *any* jj command. It loads the repo state as of a specific operation:

```bash
jj --at-op <op-id> log
jj --at-op <op-id> diff
jj --at-op <op-id> file show path/to/file
```

When `--at-op` is used:

- **No working-copy snapshot is taken.** Your working copy is not committed.
- `@` resolves to the working-copy commit *as recorded in that operation's view*, not your current working copy.
- You can run *any* command, but typically you only want read-only ones (`log`, `st`, `diff`, `show`, `file show`). Mutating commands work but simulate "what if I had run this back then" — usually not what you want.

## Recovering Lost Files from Snapshot History

jj automatically snapshots the working copy at the start of (almost) every command. So if you accidentally edited or deleted a file *and then ran a jj command*, the previous version is preserved as a snapshot operation.

To find every snapshot operation:

```bash
jj op log --no-graph -T 'if(self.snapshot(), self.id() ++ "\n")'
```

Inspect candidate snapshots with `jj --at-op <op-id> file show <path>`. Once the content matches, resolve the historical working-copy commit ID with `jj --at-op <op-id> log -r @ --no-graph -T commit_id`. Run `jj restore --from <commit-id> -- <path>` in the current workspace and inspect the resulting file and diff. Recovery requires an operation that captured the wanted content.

## Concurrent operations

Workspaces share an operation log. If operations diverge, inspect each operation with `jj op show <id>` and compare the affected revisions before deciding which edits to preserve.
