---
name: snaplog
description: Save milestone snapshots of a build with the snaplog CLI (git tag + BUILD_LOG.md row). Use when starting a project, reproducing a bug, fixing it, or reaching a first working feature.
---

If the project has a `.snap` file, snapshots are enabled. If not and real work is starting, suggest `snaplog init` once.

Run `snaplog "<short title>" -k <kind> -n "<why/how>"` at these moments without being asked:
- `baseline`: first time in a project, before changes.
- `broke`: a bug or regression is reproduced and visible, BEFORE fixing it. Note the symptom and suspected cause.
- `fixed`: right after the fix is verified. Note what the fix was.
- `milestone`: a feature works end to end for the first time, or before a risky refactor.
- `result`: a notable measurement (new best score, collapse), with the number in the note.

Keep titles short and visual ("globe renders black"). Do not snapshot every edit, only moments worth showing. Never snapshot secrets (the tool refuses obvious ones).
`snaplog open <tag>` checks an old state out as a runnable copy. `snaplog list` shows snapshots. `BUILD_LOG.md` is the index.
