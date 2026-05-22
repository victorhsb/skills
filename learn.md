---
description: Review the current session and extract learnings into memory plus improve commands/skills that were used
allowed-tools: Read, Write, Edit, Glob, Grep
---

Considering the entire conversation so far you have 2 goals:

# 1: Improve commands and skills
Every skill invocation or slash command called during the session is subject to be reevaluated. Does it have any room for improvement? 

## what to look for;
- Commands/skills that failed or required workarounds.
- Incorrect assumptions in the command (e.g., flags that don't exist or wrong tool behavior)
- Missing steps or edge cases that caused friction
- Workflow patterns the user corrected or refined
- Opportunities to make the command more robust or clear

## Process:
1. Identify which commands/skills were used in this session
2. For each one, read the current file
3. If the session revealed problems or improvements, raise them as a suggestion
4. Present a summary of what you are proposing to change and why
5. If explicitly accepted by the user you can proceed.

## General guidelines
Only change commands/skills directly used in the session. Never speculatively edit others.
If the command works well don't change it. Never propose any change just for the sake of changing it needs to be improvement. 

# 2: Self reflection
Outside of the scope of the skills and commands used you've seen the codebase and you executed commands most probably. 
This means you have some non-obvious knowledge gathered from that experience. Those are valuable.

## What to look for:
1. **Feedback**: Corrections, preferences, or guidance the user gave — especially things that were surprising or non-obvious.
2. **User info**: New information about the user's role, expertise, responsibilities, or working style.
3. **Project context**: Ongoing work, decisions, deadlines, or team dynamics that aren't captured in code/git.
4. **References**: External resources, dashboards, tracking systems, or documentation the user mentioned.

**Process:**
1. Read the existing memory index at the project's `memory/MEMORY.md`
2. For each learning found:
   - Check if an existing memory already covers it — if so, update that file instead of creating a duplicate
   - Write or update the memory file with proper frontmatter (name, description, type)
   - Update `MEMORY.md` index if a new file was created
3. Present a summary of what was saved/updated

**Guidelines:**
- Do NOT save things derivable from the codebase or git history
- Do NOT save ephemeral task details (what was done this session)
- DO save things that will prevent mistakes in future sessions
- DO save corrections to previous assumptions
- Keep memories concise and actionable.
- Convert relative dates to absolute dates (e.g., "next Thursday" → "2026-03-19")

---

## Output

Present a concise summary with two sections:
1. **Commands/skills updated** — what changed and why
2. **Memories saved/updated** — what was learned
