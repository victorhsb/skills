---
name: scope
description: Build a mental model of a new digital service with the user in three phases (service, design, implementation) before any plan exists, and keep the decisions in a markdown ledger. Only when the user invokes it by name or as /scope. A request for a plan goes to the plan skill. An ordinary task stays an ordinary task.
---

Scoping gives the user a clear mental model of a service before anyone plans or codes. You research and draft. The user decides.

On invocation, look for the service's ledger folder. If it exists, read it and resume at the first open line. If not, run `init.sh <project> <service>` from this skill's folder to create it, then start the service phase. `init.sh <project> <service> <aspect>` adds an aspect file. The script never overwrites a file.

## Terms

- A service has its own customer persona and its own impact. An aspect is a part of a service that can be designed on its own, and it shares the service's persona and impact.
- A decision is a choice whose options lead to different work and that research cannot settle. It belongs to the user and stays open until they answer.
- A default is a choice you made because the options cost about the same or are cheap to change. The user can veto it.
- A fact is something research settled. A constraint is a fact that rules out an option.

## Phases

1. Service. Runs once per service and covers six things: the customer persona and the context they use it in, the impact (what changes for them in ability, effort or scale), the capabilities they need, what is out of scope, the known constraints, and how it connects to other services. No solutions. Each capability is an aspect, named in the customer's words.
2. Design. How each part of the service behaves and where its boundaries are. Runs per aspect. Add an aspect here when several capabilities share a part of the solution.
3. Implementation. Which code owns each design choice and where it is called. Per aspect.

The definition is free-form. The six service points are prompts, so when the user moves on name any that have no line.

The phases are layers. Each is built on the one below, and work moves between them in either direction. The order is a default. The user may take one aspect through every phase, clear design across all aspects first, or return to an earlier layer. Never ask a question from a later phase than the one in play. Park it by name. A constraint is stated in the phase whose option it rules out. When an answer changes, name the decisions that depended on it and confirm each one again.

Layers have no status. A layer has started when its file exists. When the user says a layer is settled for now, ask what comes next. Stopping, another phase, another aspect, and a regular plan built from the ledger are all normal outcomes.

## Rounds

Research first. A fact the code, the data or a doc can give is never a question to the user.

A reply carries the few points that need the user's attention: what changed in the draft, the defaults you took, numbered so the user can veto by number, and the open decisions. Keep replies short. The ledger is not pasted into chat unless the user asks.

How to put a decision to the user depends on its kind.

- An obvious decision gets one recommendation and its reason.
- A broad decision gets a research subagent that compares strategies, then two or three options. Use a strong model for heavy research and an intermediate one for lookups.
- A yes/no decision, or a closed set of choices that needs no explanation, goes through the question tool. A decision that needs context first goes in chat.

## Ledger

State lives at `~/vaults/sdw/<project>/<service>/`. `service.md` holds the service layer and the aspect list. `<aspect>.md` holds design and implementation for one aspect. `glossary.md` holds the service's terms, and `service.md` points to it on its first line. `parked.md` holds the parked questions, each with the facts that only matter to it.

`service.md` and each aspect file are one-line bullets under these headings: Open, Decided, Defaults, Facts. Ids are D for a decision, Q for a question and AD for an agent decision, which is a default. A number is never reused. Each file opens with this legend under the title, written as `IDs: D = decision; Q = Question, AD = agent decision`, then a line saying a gap means a line was dropped. A decided line that depends on others ends with "Depends on" and their ids. A fact carries a source that can be checked, and a claim without one stays out. No dates. The ledger says "the user", never "I" or "me", even when the user is the customer.

Write the ledger once per turn in which something was settled. Read it only when a session resumes. The user answers in chat and edits the files between sessions, never during one.
