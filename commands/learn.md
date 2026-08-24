---
description: Review the current session — extract learnings into memory AND improve commands/skills that were used
allowed-tools: Read, Write, Edit, Glob, Grep
---

Review this entire conversation and do TWO things:

---

## Part 1: Improve commands and skills used in this session

For every slash command (`.claude/commands/*.md`) or skill (`.claude/skills/**/*.md`) that was invoked during this session, evaluate whether the session revealed issues or improvement opportunities.

**What to look for:**
- Commands/skills that failed, required workarounds, or produced incorrect output
- Incorrect assumptions in the command (e.g., flags that don't exist, wrong tool behavior)
- Missing steps or edge cases that caused friction
- Workflow patterns the user corrected or refined
- Opportunities to make the command more robust or clear

**Process:**
1. Identify which commands/skills were used in this session
2. For each one, read the current file
3. If the session revealed problems or improvements, edit the file directly
4. Present a summary of what was changed and why

**Guidelines:**
- Only change commands/skills that were actually exercised this session — don't speculatively edit others
- Preserve the existing structure and style of the file
- If the command already works well, skip it — don't change things for the sake of changing

---

## Part 2: Extract learnings into memory

Look for the following types of learnings:

1. **Feedback**: Corrections, preferences, or guidance the user gave — especially things that were surprising or non-obvious.
2. **User info**: New information about the user's role, expertise, responsibilities, or working style.
3. **Project context**: Ongoing work, decisions, deadlines, or team dynamics that aren't captured in code/git.
4. **References**: External resources, dashboards, tracking systems, or documentation the user mentioned.

**Process:**
1. Read the existing memory index at the project's `memory/MEMORY.md`
2. **Triage each learning before saving** — personal memory is not the default sink:
   - Would another agent, developer, or CI bot benefit (a repo/tooling convention, test command, language gotcha)? → it belongs in the nearest-scoped `CLAUDE.md` (team-wide) or your `CLAUDE.local.md` (personal-env), NOT personal memory. Propose that edit instead: a convention that helps anyone on the repo does not belong in one person's memory.
   - Is it already documented in a skill (`.claude/skills/`) or a CLAUDE.md? → don't duplicate it. A "how to run X" reference usually already lives in a skill; grep before creating.
   - Only things specific to THIS user's private workflow, context, or preferences belong in personal memory.
3. For each learning that survives triage:
   - Check if an existing memory already covers it — if so, update that file instead of creating a duplicate
   - Write or update the memory file with proper frontmatter (`metadata.type` = user | feedback | project | reference). For feedback/project, lead with the rule/fact, then `**Why:**` and `**How to apply:**` lines. Link related memories with `[[wikilinks]]`.
   - Update `MEMORY.md` if a new file was created — one line per file, format `- [Title](file.md) — <hook>`, under ~150 chars. Never write memory content into the index itself.
4. Present a summary of what was saved/updated

**Guidelines:**
- Do NOT save things derivable from the codebase or git history
- Do NOT save ephemeral task details (what was done this session)
- DO save things that will prevent mistakes in future sessions
- DO save corrections to previous assumptions
- Keep memories concise and actionable
- Convert relative dates to absolute dates (e.g., "next Thursday" → "2026-03-19")

---

## Output

Present a concise summary with these sections:
1. **Commands/skills updated** — what changed and why
2. **Memories saved/updated** — what was learned
3. **Routed to CLAUDE.md/skills** — any learning that triage sent out of personal memory (only if there were any)
