# snaplog

Save the milestones of a build as git snapshots, and keep a plain-English log of what broke and how you fixed it.

One bash script. No dependencies besides `git`. Works on macOS and Linux.

**Made for AI coding agents to use** (Claude Code, Codex, Cursor and similar), and just as easy for people to run by hand. An agent can snapshot at the right moments on its own; see [Use it with an AI coding agent](#use-it-with-an-ai-coding-agent).

```
snaplog init
snaplog "login page renders blank" -k broke -n "symptom: white screen. suspect: env var missing"
snaplog "login page renders" -k fixed -n "fix: read the env var at build time"
snaplog list
snaplog open b02-broke-login-page-renders-blank    # a runnable copy of that moment
```

## Why

The interesting parts of a build are the broken ones, and they vanish when you fix them. `snaplog` makes each one a git tag and a row in `BUILD_LOG.md`, so you can run the broken state again later (posts, videos, bug reports) and see the story of a project in one table.

## Install

**Easiest:** paste this repo's link into your coding agent (Claude Code, Codex, Cursor) and say "set this up". It will clone it, run the installer and add the skill.

**By hand:**

```bash
git clone https://github.com/spacecaret/snaplog.git
cd snaplog && ./install.sh --skill   # --skill also installs the agent skill; drop it if you don't use one
```

Make sure `~/.local/bin` is on your `PATH`. Or just copy `bin/snaplog` anywhere you like.

## Commands

| command | what it does |
|---|---|
| `snaplog init [--chapters]` | turn snapshots on, init git if needed, save a `baseline` |
| `snaplog "title" [-k kind] [-n note] [-c chapter]` | commit everything, tag it `bNN-kind-title`, add a row to `BUILD_LOG.md` |
| `snaplog list` | list snapshots |
| `snaplog open <tag>` | check an old snapshot out as a runnable copy in `~/.snaplog` (`SNAPLOG_DIR` to change). Dependencies are not copied. |
| `snaplog chapter <tag> "Title"` | mark an existing snapshot as a story chapter |
| `snaplog chapters` | list chapters |

**Kinds** are free text. Suggested: `baseline` (before changes), `broke` (a bug reproduced, before you fix it), `fixed` (right after the fix is verified), `milestone` (a feature works for the first time, or before a risky refactor), `result` (a notable measurement).

## Safety

- Refuses to snapshot secret-looking files (`.env`, `*.pem`, `*.key`, `id_rsa*`, `credentials*`). Override: `SNAPLOG_ALLOW_SECRETS=1`.
- Never pushes. Snapshots stay local until you `git push --follow-tags`.
- Runs `git add -A`, so check your folder first.

## Use it with an AI coding agent

`./install.sh --skill` installs `skill/SKILL.md` for Claude Code. For other agents, paste its text into the agent's instructions. The agent then snapshots at the right moments without being asked.

## License

MIT.

---

Made by spacecaret with Claude.
