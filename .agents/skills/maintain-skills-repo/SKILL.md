---
name: maintain-skills-repo
description: Maintain the victorhsb/skills repository. Use when importing or refreshing a locally installed skill, adapting it to this workflow, or updating a marketplace entry or pin.
---

# Maintain the skills repository

## Trace the installed copy

Start with the skill path supplied by the user or the active skill inventory. Otherwise look for the named directory in `~/.agents/skills/`, `${CODEX_HOME:-$HOME/.codex}/skills/`, or `~/.claude/skills/`. For a plugin-provided skill, use the installed plugin’s cache path and version. Resolve symlinks with `realpath`. If multiple copies differ, use the one the user actually invokes.

Read its frontmatter, linked resources, attribution, and license. Identify the upstream repository and revision from the install metadata or source checkout when available. Compare the installed files with the existing repository copy before updating. For example, `diff -ru --exclude=.git skills/jj-guide ~/.agents/skills/jj-guide` shows what a refresh would change. Preserve intentional edits on either side.

## Choose the destination

- **Repository maintenance.** Put skills used to work on this checkout in `.agents/skills/<name>/SKILL.md`. Keep them out of the marketplace catalog and the plugin’s top-level `skills/` directory.
- **Bundled workflow.** For a skill the user wants to maintain and distribute with `victorhsb-tools`, place the reviewed files in `skills/<name>/`. Bring along the scripts, references, assets, and attribution the workflow relies on. Check that redistribution is permitted before bundling third-party material.
- **Upstream skill.** For a third-party skill consumed as maintained upstream, add or update its pinned entry in `.claude-plugin/marketplace.json`. Verify the selected directories at the exact SHA. Keep skills that invoke each other available together. A pin reproduces upstream content only; identify any installed-only changes before choosing this route.

## Adapt and verify

Extract the behavior the user relies on. Replace machine-specific paths, tool names, and installation assumptions with equivalents that work from the destination. Inspect linked files and executable dependencies from that directory. Leave personal settings, credentials, caches, and checkout metadata in the source installation.

Try a representative request using the destination copy. For a refresh, check the behavior that motivated the local edits. For catalog or bundled changes, update the README where the user-facing inventory changes and follow its “Maintaining this” section for manifest validation, install checks, and release versioning. For a repository-only skill, validate the skill directory and confirm its name is absent from the distributed skill inventory.
