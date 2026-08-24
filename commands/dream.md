---
description: Audit and consolidate the project memory system — remove stale entries, merge duplicates, tighten index
---

Review the project's memory directory and clean it up. Do NOT invent new learnings — this is purely a curation pass.

## Process

1. **Read the index first** (`memory/MEMORY.md`) and each linked file. Build a mental map of what exists, grouped by type (feedback / user / project / reference) and by topic.

2. **For each memory, evaluate:**
   - **Stale?** — Does it reference code, files, or flags that no longer exist? Does it refer to deadlines or team states that have passed? Spot-check file paths with `ls` and referenced symbols with `grep`; **never delete a memory just because recall feels wrong — verify against the repo first**.
   - **Redundant?** — Is it fully covered by a `CLAUDE.md`, a skill under `.claude/skills/`, or another memory? Grep the skills too — a "how to run X" reference often duplicates a command already documented in a skill. Repo-wide conventions belong in CLAUDE.md or a skill, not in memory.
   - **Derivable?** — Can this be recovered from `git log`, code, or a quick grep? If yes, drop it.
   - **Mergeable?** — Are two or more memories covering the same topic at similar altitude? Prefer merging into one well-structured file over keeping fragments.
   - **Inbound references?** — Before proposing a delete/rename, grep the other memories for the file's name and its `[[wikilinks]]`, plus any consolidated-index memory (a lookup table that lists other memories by name). A deletion that leaves a dangling pointer or a stale row is half-done.
   - **Well-structured?** — Feedback/project memories should lead with the rule/fact, then `**Why:**` and `**How to apply:**` lines. Fix missing structure.

3. **For each candidate change, propose it to the user before acting.** Present a short list:
   - `DELETE: <file> — <reason>`
   - `MERGE: <a> + <b> → <new name> — <reason>`
   - `MIGRATE: <file> → <CLAUDE.md path> — <reason>` (relocate a repo/tooling convention out of personal memory, then delete the memory)
   - `UPDATE: <file> — <what changed and why>`
   - `KEEP: <file>` (only list keeps if there are fewer than ~5 changes total)

   Wait for approval. Deleting memory is lossy and easy to regret.

   For a `MIGRATE`, ask (or infer) whether the target is the **checked-in** `CLAUDE.md` (team-wide convention) or the user's **`CLAUDE.local.md`** (personal/local-env preference, gitignored). When unsure which, ask — they are not interchangeable.

4. **After approval, apply changes:**
   - Update or delete individual memory files. For a `MIGRATE`, write the convention into the chosen CLAUDE.md/CLAUDE.local.md first, then delete the memory.
   - Fix inbound references: when a file is deleted or renamed, remove/repoint every `[[wikilink]]` and every row in a consolidated-index memory that named it.
   - Keep `MEMORY.md` index lines under ~150 chars, one line per file.
   - Remove index entries for deleted files; update descriptions for renamed/merged/updated files.
   - Never write memory content directly into `MEMORY.md` — it stays an index.

5. **Reconcile, then report.** Diff the index against the files on disk to prove they match exactly — no orphaned index lines, no unindexed files:
   ```bash
   cd <memory-dir> && diff <(ls *.md | grep -v '^MEMORY.md$' | sort) \
     <(grep -oE '\./[a-z0-9_]+\.md' MEMORY.md | sed 's|\./||' | sort)
   ```
   Then report the diff — what was removed, merged, migrated, or updated, and roughly how many memories remain. Flag any new untracked file a `MIGRATE` created (e.g. a fresh `CLAUDE.local.md`) in case it needs a gitignore entry.

## Guardrails

- Do NOT add new learnings — that's `/learn`'s job.
- Do NOT delete a memory because it seems "obvious now"; obvious-to-you now may be a hard-won correction worth preserving.
- Date-stamp decay carefully: a project memory from 6+ months ago about a pending migration is likely stale, but a feedback memory from last year about how the user likes commits is likely still valid.
- If a memory contradicts current repo state, prefer **updating** it (with the new state + why) over deleting, unless the underlying topic no longer applies at all.
- Treat feedback-type memories as the highest bar to delete — they encode the user's preferences, which don't decay as fast as project state.
