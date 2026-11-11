# skills

This marketplace publishes one plugin, `victorhsb-tools`, for Claude Code and Codex. Both clients read
[`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json).

## Install in Claude Code

```
/plugin marketplace add victorhsb/skills
/plugin install victorhsb-tools@victorhsb-skills
```

## Install in Codex

Run these commands in your terminal:

```bash
codex plugin marketplace add victorhsb/skills
codex plugin add victorhsb-tools@victorhsb-skills
```

For a local checkout, use `codex plugin marketplace add "$PWD"` from the repository root
in place of the first command. Run `codex plugin list --marketplace victorhsb-skills` to
inspect the catalog and installation status.

Start a new Codex session and invoke `$jj-guide` for Jujutsu workflows. Codex CLI 0.167.0
also imports `/multireview` as `$source-command-multireview`. The other slash commands
and the selectable Unslop output style described below are Claude Code features.

## Included in victorhsb-tools

The plugin includes three command files, the Unslop output style, and two bundled skills. The [Jujutsu skill](skills/jj-guide/SKILL.md) covers local changes, bookmarks, pull requests, and recovery in jj workspaces.

| Command | What it does |
| --- | --- |
| `/bc` | Branchless commit via `git record` (git-branchless), with optional `stack-pr export`. Knows the flags `git record` actually accepts and why `git commit --amend` breaks a stack-pr link. |
| `/learn` | The [learn skill](skills/learn/SKILL.md) improves workflows exercised during the session and saves durable lessons through ai-memory. If ai-memory is unavailable, it reports the unsaved lessons. |
| `/dream` | Curation pass over a project memory directory. Finds stale, redundant, and derivable memories, proposes deletes and merges, then reconciles the index against the files on disk. |
| `/multireview` | Reviews the current change along correctness, robustness, and simplicity in parallel, then converges the findings into one prioritized report. |

The `unslop` output style is an always-on writing voice: lead with the answer, active voice, plain
words, name the mechanism instead of the feeling. It is based on the `unslop` skill from
[cursor/plugins](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop), reworked from a
revision pass into a style that applies while generating. Select it with `/output-style`, where it
appears as "Unslop". That name comes from the file's frontmatter `name`, not its filename, and it is
what lands in `outputStyle` in settings. If you already keep a personal `output-styles/unslop.md`
under `~/.claude`, delete it before installing this plugin so one "Unslop" does not shadow the other.

## Maintaining this

For the repository layout, naming conventions, and what to include in a pull request, see the
[contributor guide](AGENTS.md).

Validate both manifests from the repository root.

```bash
claude plugin validate --strict .
```

Install the plugin from your checkout and inspect its commands and skills.

```bash
claude plugin marketplace add "$PWD"
claude plugin install victorhsb-tools@victorhsb-skills
claude plugin details victorhsb-tools
```

When releasing plugin changes, bump `version` in both `.claude-plugin/plugin.json` and the
`victorhsb-tools` entry in `.claude-plugin/marketplace.json`. The marketplace’s top-level
`version` tracks the catalog separately.

## License

[LICENSE](LICENSE) is MIT and covers what I wrote: `commands/`, the manifests, and this README.

The Unslop output style adapts the `unslop` skill from cursor/plugins. Its upstream terms are
unstated, and the MIT license here excludes the portions derived from that skill.
