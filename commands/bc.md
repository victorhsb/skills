---
description: Branchless commit using git-branchless (git record) with optional stack-pr export
model: haiku
allowed-tools: Bash(git *), Bash(stack-pr *), Bash(bpr *)
---

Create a branchless commit for the current changes using `git record` (git-branchless) with optional `stack-pr export`.

**Argument handling:**
- `/bc` → commit only
- `/bc export` or `/bc push` → commit + run `stack-pr export` afterward so publish the pull request stack

Steps to follow:

1. Run `git status`, `git diff --staged` (or `git diff` if nothing staged), and `git log --oneline -5` to understand changes and commit style

2. **Do NOT detach from main**: Just use `git record -d` (the `-d` flag creates a detached commit automatically). Do not run `git branchless detach` — it is not a valid subcommand and will error.

3. Analyze the changes and determine the commit type based on these categories:
   - `feat` — New features, functionality, or capabilities
   - `fix` — Bug fixes, error corrections, or patches
   - `refactor` — Code restructuring without behavior change
   - `chore` — Docs, config, tooling, dependencies, maintenance
   - `cleanup` — Dead code removal, consolidation
   - `test` — Test additions, modifications, or improvements
   - `infra` — Infrastructure, deployment, or environment changes
   - `breaking` — Breaking changes that affect backwards compatibility
   - `revert` — Reverting previous commits
   - `release` — Release-related commits

4. Write a clear commit message in English that:
   - Uses imperative mood ("Add feature" not "Added feature")
   - Focuses on why, not just what
   - Keeps first line under 72 characters
   - **If working from a Linear ticket** (e.g., ABC-123), include the ticket ID in the commit message **body**, not the subject line: e.g., `Resolves ABC-123`

5. Stage relevant files with `git add`
   - **Splitting one file across multiple stacked commits** (e.g., a shared manifest with one hunk per commit): temporarily Edit the file back so only the first commit's change is present, stage + record, then re-apply the second change and record again. This avoids interactive `git add -p`, which is unavailable. Also normalize incidental churn first (e.g., a JSON serializer re-escaping a literal em-dash as the backslash-u2014 escape sequence in untouched entries) so diffs only show real changes

6. Create commit using `git record -d -m` with HEREDOC format. The `-d` flag is **mandatory** — it creates a detached commit so `main` doesn't advance. The commit type goes as the **first word of the message**, NOT as a flag:

```bash
git record -d -m "$(cat <<'EOF'
<type> [scope→component] Brief summary of changes

Optional longer description explaining the changes and their impact.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

**CRITICAL — always use `-d` flag**:
- ❌ WRONG: `git record -m "message"` — This advances `main` with your commit
- ✅ CORRECT: `git record -d -m "message"` — This creates a detached commit off `main`

**CRITICAL — `git record` does NOT support type flags**:
- ❌ WRONG: `git record -d -fix -m "message"` — This will error with "unexpected argument"
- ❌ WRONG: `git record -d -feat -m "message"` — Same error
- ✅ CORRECT: `git record -d -m "fix [scope] message"` — Type is part of the message text
- The only flags `git record` accepts are: `-m`, `-i`, `-c`, `-d`, `-I` (see `git record --help`)

7. **Conditional export**: If the user's argument includes "export" or "push", run `bpr export` after committing (`bpr` is a personal `stack-pr` wrapper; drop to plain `stack-pr export` if you do not have one). If it fails with a gh-auth-shaped error (`get_gh_username ... exit status 1`), don't retry — ask the user to run `! bpr export` themselves

8. Run `git status` after committing (and exporting, if applicable) to verify

IMPORTANT:
- DO NOT commit secrets (.env, credentials.json, etc.)
- DO NOT push unless explicitly requested via the "export" or "push" argument
- Use `git record` instead of `git commit` — this is the branchless equivalent
- To amend an existing commit, use `git amend` (git-branchless), NOT `git record --amend` (unsupported flag) or `git commit --amend`. `git amend` folds staged changes into the current HEAD commit and automatically rewrites descendants.
- **NEVER use `git commit --amend`** — it rewrites the commit hash and discards the `stack-info:` metadata that `stack-pr export` appended, breaking the link to any open PR. Always use `git amend` (branchless) which preserves the stack-pr association.
- **Do NOT rewrite commit messages** when amending. If you need to amend code changes into an existing commit, just `git add` + `git amend`. The original message (including `stack-info:` lines) is preserved automatically.
- Follow the repo's own commit conventions where a CLAUDE.md or contributing guide states them
