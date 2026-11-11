---
name: learn
description: Review the current session for durable lessons, improve commands and skills exercised in it, and save relevant learnings to ai-memory. Use when asked to learn from a session or capture its lessons.
---

# Learn from the session

Review the available conversation for two outcomes: evidence-backed improvements to commands or skills used, and durable lessons saved in the appropriate place. If earlier conversation is unavailable, state that limit and base conclusions on the evidence available.

## Improve commands and skills

1. Identify every command or skill actually exercised in the session and read its current source. Resolve paths from the invocation or installed skill catalog rather than assuming a particular agent's directory layout. Follow the source's applicable editing instructions; for generated or installed copies, locate the maintained source when available.
2. Evaluate each against observed failures, workarounds, incorrect assumptions about tools, missing steps, and user corrections. Make a change only when session evidence supports it; leave working instructions alone.
3. Apply the smallest correction that addresses the evidence, preserving the document's scope and useful structure. Use writing-for-agents for agent-facing instructions and skill-creator when editing a skill. Validate changed skills and any affected executable helpers as appropriate.

This pass is complete when every exercised command or skill has been evaluated and each supported improvement is applied or reported with its concrete blocker. Keep unrelated commands and skills outside this pass.

## Extract durable lessons

Look for user feedback and preferences, newly established user context, project decisions or constraints absent from code and git, and useful external references. Preserve corrections to previous assumptions; distinguish a confirmed decision from a question or suggestion.

Triage each candidate before saving:

- **Shared convention:** A repo/tooling convention, test instruction, or language gotcha useful to other contributors belongs in the nearest applicable canonical agent instruction file or maintained skill. Propose the scoped edit, unless the user already authorized applying that class of change. Personal environment guidance belongs in the project's supported local instruction file.
- **Already documented:** Search relevant instructions, skills, and existing memory. Reuse or correct the authoritative source instead of duplicating it.
- **Durable context:** Save useful private workflow preferences, user context, project facts, and references through ai-memory. Exclude facts readily derivable from code or git and ephemeral task progress.

For memory retrieval and writes, load the installed ai-memory-retrieval and ai-memory-durable-pages skills and follow their current tool schemas, project scoping, and page-update rules. This learning-review request authorizes saving the relevant lessons; a request for proposals or review only remains read-only. If ai-memory is unavailable, report the unsaved lessons rather than creating a native file-memory store.

Read existing pages before updating them. Prefer updating a matching page to creating a duplicate, preserve unrelated content and metadata, and save standing cross-project preferences to the profile only when they apply across projects. Write concise, actionable facts with the reason and application context where useful. Resolve relative dates to absolute dates using the session's date context.

This pass is complete when each candidate has been saved, merged with existing knowledge, routed to a proposed instruction edit, or excluded for a stated reason. Report a write as saved only after the tool confirms it.

## Report

Give a concise summary:

- **Commands/skills updated:** what changed and why, with paths.
- **Memories saved/updated:** the lessons and their page references.
- **Routed to instructions/skills:** proposed edits, if any.

Say when a pass found nothing worth changing. Identify blocked writes or unapplied proposals explicitly.
