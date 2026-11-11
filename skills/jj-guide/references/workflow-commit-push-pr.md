# Commit, push a bookmark, or open a pull request

Start at the first step the task still needs and finish at the requested endpoint.

1. **Commit.** Review `jj status` and `jj diff`. Record the intended edits using the [commit workflow](../SKILL.md). If the change already exists, inspect it with `jj show <change-id>`. A local commit request is complete once the recorded diff and remaining working copy match the request.
2. **Select the publication target.** Identify the intended remote and feature bookmark with `jj git remote list` and `jj bookmark list --all-remotes`. A bookmark follows rewrites of its target. To advance it to a new change, use `jj bookmark set <name> -r <change-id>`. For a new bookmark use `jj bookmark create <name> -r <change-id>`.
3. **Push.** Inspect the proposed update with `jj git push --dry-run --remote <remote> --bookmark <name>`. When the destination and change match the task, run the same command without `--dry-run`. If the remote moved, fetch it and inspect both tips before choosing how to reconcile them.
4. **Open the requested PR.** Check the destination repository and base branch. Use the verified feature bookmark as the head (for a fork, use `owner:bookmark`). Review the change against the base and write the description to a text file. Run the following with the actual values, then return the PR URL.

   ```sh
   gh pr create --repo "$repo" --base "$base" --head "$head" \
     --title "$title" --body-file "$body_file"
   ```
