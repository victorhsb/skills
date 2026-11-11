# jj-guide

A Claude Code / Agent skill for working safely and effectively with [Jujutsu (jj)](https://github.com/jj-vcs/jj), a Git-compatible VCS with mutable commits, automatic snapshotting, no staging area, and first-class conflicts.

The skill is designed for non-interactive agent use: it teaches the agent which jj commands hang in TUI environments, how to avoid them, and how to recover when something goes sideways.

## Installation

This is a [Claude Code skill](https://docs.claude.com/en/docs/claude-code/skills). To install it as a personal skill, clone into your skills directory:

```bash
git clone https://github.com/mtaran/jj-guide.git ~/.claude/skills/jj-guide
```

The skill activates automatically in any repository containing a `.jj/` directory.

## Layout

```
jj-guide/
├── SKILL.md                              # main entry — local commit workflow and topic links
└── references/                           # progressive disclosure, loaded on demand
    ├── git-to-jj.md                      # full Git ⇄ jj command mapping + filesets
    ├── revsets.md                        # operators, functions, string/date patterns, recipes
    ├── bookmarks.md                      # tracking, push safety, multi-remote workflows
    ├── conflicts.md                      # marker formats (jj/snapshot/git), resolution
    ├── operation-log.md                  # undo, --at-op, recovering files from snapshots
    ├── workspaces.md                     # multiple working copies, stale recovery, colocated
    ├── glossary.md                       # formal definitions
    ├── troubleshooting.md                # symptoms, diagnostics, and rebase scope
    ├── workflow-commit-push-pr.md        # ship a PR end-to-end
    └── workflow-new-workspace.md         # isolated workspace + bookmark for parallel work
```

`SKILL.md` contains everything needed for routine work. The files under `references/` are loaded by the agent only when the user's task touches that topic.

## Acknowledgements

This skill is a synthesis of three existing community skills plus the official jj documentation. Most of the material here is repurposed or distilled from these sources — credit and thanks go to their authors.

- **[plasticbeachllc/jj-skipper](https://github.com/plasticbeachllc/jj-skipper)** — provided the structural backbone of `SKILL.md` (critical-rules-first layout, mental model, common-pitfalls list), the foundation for the `git-to-jj.md` reference table, the diagnostic protocol that became `troubleshooting.md` (originally the `jj-doctor` agent), and the step-by-step `workflow-commit-push-pr.md` and `workflow-new-workspace.md` playbooks (originally the `jj-commit-push-pr` and `jj-workspace` skills).

- **[danverbraganza/jujutsu-skill](https://github.com/danverbraganza/jujutsu-skill)** — provided the agent-safety nuance: always pass `-m`, never use `-i`, verify mutations with `jj st`, the "describe-first" refinement workflow, and the explicit list of interactive commands to avoid (`jj resolve`, `jj split -i`, `jj squash -i`, etc.).

- **[kawaz/claude-plugin-jj](https://github.com/kawaz/claude-plugin-jj)** — provided coverage of jj-specific commands beyond the Git mapping (`absorb`, `evolog`, `parallelize`, `metaedit`, `interdiff`, `fix`, `file annotate`, `file search`) and the operation-log snapshot-scan trick for recovering files that were edited or deleted between jj commands.

- **[jj-vcs/jj official documentation](https://github.com/jj-vcs/jj/tree/main/web/docs/src/content/docs)** — the authoritative source for the deep-dive references: the revset expression language (operators, functions, string/date patterns), conflict marker formats (jj / snapshot / git styles, long markers, missing-newline conflicts), bookmark tracking and push-safety semantics, multiple-remote workflows (fork vs. independent integrator), operation-log mechanics (`--at-op`), working-copy auto-tracking and stale recovery, and the glossary.

If you maintain one of these projects and would like changes to attribution or content, please open an issue.

## License

MIT.
