# skills

My Claude Code commands and output style, plus a curated catalog of third-party skills that
this repo points at instead of copying.

```
/plugin marketplace add victorhsb/skills
/plugin install victorhsb-tools@victorhsb-skills
```

## What is mine

The `victorhsb-tools` plugin is the content in this repo. It includes four slash commands, one output style, and the locally maintained [Jujutsu skill](skills/jj-guide/SKILL.md). The skill covers local changes, bookmarks, pull requests, and recovery in jj workspaces.

| Command | What it does |
| --- | --- |
| `/bc` | Branchless commit via `git record` (git-branchless), with optional `stack-pr export`. Knows the flags `git record` actually accepts and why `git commit --amend` breaks a stack-pr link. |
| `/learn` | Reviews the session and does two things: proposes fixes to the commands and skills that were exercised, and extracts durable learnings into project memory. |
| `/dream` | Curation pass over a project memory directory. Finds stale, redundant, and derivable memories, proposes deletes and merges, then reconciles the index against the files on disk. |
| `/multireview` | Reviews the current change along correctness, robustness, and simplicity in parallel, then converges the findings into one prioritized report. |

The `unslop` output style is an always-on writing voice: lead with the answer, active voice, plain
words, name the mechanism instead of the feeling. It is based on the `unslop` skill from
[cursor/plugins](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop), reworked from a
revision pass into a style that applies while generating. Select it with `/output-style`, where it
appears as "Unslop". That name comes from the file's frontmatter `name`, not its filename, and it is
what lands in `outputStyle` in settings. If you already keep a personal `output-styles/unslop.md`
under `~/.claude`, delete it before installing this plugin so one "Unslop" does not shadow the other.

## The passthrough catalog

The rest of the entries in `.claude-plugin/marketplace.json` are skills I use but did not write. This
repo holds no copy of them. Each entry is a pointer:

```json
{
  "name": "find-skills",
  "source": {
    "source": "git-subdir",
    "url": "https://github.com/vercel-labs/skills.git",
    "path": "skills/find-skills",
    "sha": "435076e78988e1e6ec40d00b0b1d76bdbbc5419a"
  }
}
```

Claude Code does a sparse partial clone of that one subdirectory from the author's own repository.
Three things follow from that. The code stays under its author's license and never gets
redistributed here. The `sha` pins an exact commit, so an upstream force-push cannot change what
gets installed. And a pin only moves when I move it, deliberately, in a commit.

`plugin.json` is optional for a plugin, and a directory holding a bare `SKILL.md` loads as a single
skill, which is what makes a pointer at someone else's skill folder work with no wrapper.

One entry can also carry many skills. Point `path` at the directory above them and list each one in
a `skills` array, relative to that directory:

```json
{
  "name": "mattpocock-skills",
  "source": {
    "source": "git-subdir",
    "url": "https://github.com/mattpocock/skills.git",
    "path": "skills",
    "sha": "5b15a47f2d7150f545fbcacbfe381787fc0230dc"
  },
  "skills": ["./productivity/grilling", "./engineering/domain-modeling"]
}
```

That is the shape the mattpocock entry uses, eight skills behind one install. Two consequences.
Bundled skills are namespaced by their plugin, so `/grilling` is `/mattpocock-skills:grilling`. And
all eight enable and disable together, with every description loaded into every session whether or
not the skill fires, 308 tokens for this bundle.

Do not set `path` to `"."` to grab a whole repo. The sparse checkout runs in cone mode, so a root
pattern pulls root-level files and no directories at all. The install still reports success and the
plugin loads zero skills. Bundle from a real subdirectory, or use a `github` source, which clones
the whole repo and honors the upstream `plugin.json`.

### Catalog

| Plugin | Upstream | License |
| --- | --- | --- |
| `mattpocock-skills` | mattpocock/skills | MIT |
| `find-skills` | vercel-labs/skills | MIT |
| `blast-radius` | cursor/plugins | none published |
| `unslop-skill` | cursor/plugins | none published |
| `agent-md-refactor` | softaworks/agent-toolkit | MIT |

`mattpocock-skills` carries eight skills: `grilling`, `grill-me`, `grill-with-docs`,
`domain-modeling`, `handoff`, `wayfinder`, `writing-for-agents`, `improve-codebase-architecture`.
Bundling them is what keeps them working. Four call each other by name: `grill-me` and
`improve-codebase-architecture` reach for `grilling`, and `grill-with-docs` reaches for both
`grilling` and `domain-modeling`. As separate entries they broke quietly when installed alone.

cursor/plugins ships no license file, so those two entries carry no license grant. Pointing at them
copies nothing, but read the repo before you depend on the code.

## Maintaining this

**Moving a pin.** Get the new commit, check the path still exists at it, then edit the `sha`:

```bash
git ls-remote https://github.com/mattpocock/skills.git HEAD
gh api "repos/mattpocock/skills/git/trees/<sha>?recursive=1" \
  --jq '.tree[] | select(.path|endswith("SKILL.md")) | .path'
```

That path check is not optional. `writing-great-skills` was renamed to `writing-for-agents`
upstream on 2026-07-31, and a pin bumped without looking would have pointed at a directory that no
longer exists.

**Validating.** CI-grade check on both manifests:

```bash
claude plugin validate --strict .
```

That checks the manifests only. It cannot check a passthrough entry, and pointing it at an upstream
skill folder fails with "No manifest found in directory" even though the runtime installs that folder
fine. To verify a new entry, install it:

```bash
claude plugin marketplace add "$PWD"
claude plugin install <entry>@victorhsb-skills
claude plugin details <entry>            # confirm the skill count and the names
claude plugin uninstall <entry> && claude plugin marketplace remove victorhsb-skills
```

**Releasing.** `victorhsb-tools` sets an explicit `version`, which pins it. Editing a command is not
enough for installed users to see the change; bump it in two places that have to agree, the
`version` in `.claude-plugin/plugin.json` and the `version` on the `victorhsb-tools` entry in
`.claude-plugin/marketplace.json`. The top-level `version` in marketplace.json is the catalog's own
version and does not pin anything. Drop the field from both places if you would rather users track
the default branch and pick up every push.

## License

[LICENSE](LICENSE) is MIT and covers what I wrote: `commands/`, the manifests, and this README.

Two carve-outs. Every passthrough entry stays under its own author's terms, listed in the catalog
table above, and none of that code lives here. And `output-styles/unslop.md` is a derivative of
cursor/plugins' `unslop` skill, which publishes no license, so I cannot grant MIT over the parts that
came from it. Treat that one file as "reused with attribution, upstream terms unstated".
