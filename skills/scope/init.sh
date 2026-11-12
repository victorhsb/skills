#!/usr/bin/env bash
# Creates the ledger files for a service, or one aspect file inside it.
# Usage: init.sh <project> <service> [aspect]
# Never overwrites an existing file. SDW_ROOT overrides the ledger root.
set -euo pipefail

if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  echo "usage: init.sh <project> <service> [aspect]" >&2
  exit 2
fi

root="${SDW_ROOT:-$HOME/vaults/sdw}"
project="$1"
service="$2"
aspect="${3:-}"
dir="$root/$project/$service"

legend='IDs: D = decision; Q = Question, AD = agent decision
A number is never reused, so a gap means a line was dropped.'

sections='## Open

## Decided

## Defaults

## Facts'

# create <path>: writes stdin to the path unless the file exists.
create() {
  if [ -e "$1" ]; then
    echo "kept    $1"
    cat >/dev/null
  else
    cat >"$1"
    echo "created $1"
  fi
}

mkdir -p "$dir"

if [ -n "$aspect" ]; then
  create "$dir/$aspect.md" <<EOF
# $aspect

Aspect of $service. Read \`glossary.md\` first.

$legend

## Design

## Implementation

$sections
EOF
  exit 0
fi

create "$dir/service.md" <<EOF
# $service

Read \`glossary.md\` first. Its terms define how the rest reads. Parked questions are in \`parked.md\`.

$legend

Project: $project.

## Service

- Customer persona and context.
- Impact.
- Capabilities.
- Out of scope.
- Known constraints.
- Connections.

## Aspects

$sections
EOF

create "$dir/glossary.md" <<'EOF'
# Glossary

## Ledger terms

- Service: Something with its own customer persona and its own impact.
- Aspect: A part of a service that can be designed on its own. It shares the service's persona and impact.
- Decision: A choice whose options lead to different work and that research cannot settle. It belongs to the user and is open until they answer.
- Agent decision: A default the agent took because the options cost about the same or are cheap to change. The user can veto it.
- Fact: Something research settled, with its source.
- Constraint: A fact that rules out an option.
- Parked: A question that belongs to a later phase.

## Service terms
EOF

create "$dir/parked.md" <<'EOF'
# Parked

Questions that belong to a later phase. A fact that only matters to one of them sits under it.
EOF
