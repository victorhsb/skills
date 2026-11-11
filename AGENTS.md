# Repository Guidelines

## Project structure

This repository publishes the `victorhsb-tools` Claude Code plugin and a marketplace of third-party skills. Edit slash commands in `commands/`, the Unslop output style in `output-styles/unslop.md`, and the bundled Jujutsu skill in `skills/jj-guide/`. Keep the skill’s entry point in `SKILL.md` and detailed procedures in `references/`.

The local plugin manifest is `.claude-plugin/plugin.json`. The marketplace catalog is `.claude-plugin/marketplace.json`. Third-party entries point to upstream directories pinned by commit SHA. When moving a pin, verify that every selected skill directory contains `SKILL.md` at the new commit. Follow the path-check example under “Maintaining this” in [README.md](README.md).

## Style and naming

Use lowercase filenames with hyphens between words, such as `workflow-new-workspace.md`. A command’s filename supplies its command name. Start command files with YAML frontmatter containing a short `description`. For skills, include both `name` and a `description` that explains when to use the skill. Match the existing two-space indentation in JSON manifests.

## Local development and validation

The plugin loads directly from Markdown and JSON. Run these checks from the repository root.

1. Run `claude plugin validate --strict .` to validate both manifests.
2. Run `claude plugin marketplace add "$PWD"` to register the checkout locally.
3. Install the changed entry with `claude plugin install <entry>@victorhsb-skills`, replacing `<entry>` with its catalog name. Run `claude plugin details <entry>` and check the skill names and count. For command or style changes, exercise the changed behavior in Claude Code.

## Commits, pull requests, and releases

Use a short, action-led commit subject, as in “Bundle the reviewed Jujutsu skill”. In the pull request, identify the affected command, style, or skill and describe how you verified it.

When releasing local plugin changes, bump the version in both the plugin manifest and the matching marketplace entry. The marketplace’s top-level version tracks the catalog separately.
