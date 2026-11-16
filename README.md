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

Most of the interesting parts of a build are the broken ones, and they vanish the moment you fix them. `snaplog` makes each one a git tag and a row in `BUILD_LOG.md`, so you can:

- go back and run the broken state later (blog posts, videos, bug reports, retros),
- see the story of a project in one table,
- hand an AI coding agent a clear history of what was tried.

## Install

```bash
git clone https://github.com/spacecaret/snaplog.git
cd snaplog && ./install.sh        # copies bin/snaplog to ~/.local/bin
```

Make sure `~/.local/bin` is on your `PATH`. Or just copy `bin/snaplog` anywhere you like.

## Commands

| command | what it does |
|---|---|
| `snaplog init [--chapters]` | turn snapshots on, init git if needed, save a `baseline` |
| `snaplog "title" [-k kind] [-n note] [-c chapter]` | commit everything, tag it `bNN-kind-title`, add a row to `BUILD_LOG.md` |
| `snaplog list` | list snapshots |
| `snaplog open <tag>` | check an old snapshot out as a separate runnable copy (git worktree) |
| `snaplog chapter <tag> "Title"` | mark an existing snapshot as a story chapter |
| `snaplog chapters` | list chapters |

**Kinds** are free text. Suggested: `baseline` (before changes), `broke` (a bug reproduced, before you fix it), `fixed` (right after the fix is verified), `milestone` (a feature works for the first time, or before a risky refactor), `result` (a notable measurement).

## Safety

- It refuses to snapshot files that look like secrets (`.env`, `*.pem`, `*.key`, `id_rsa*`, `credentials*`). Override with `SNAPLOG_ALLOW_SECRETS=1`.
- It creates a `.gitignore` (node_modules, .venv, .env, logs, model checkpoints) if you do not have one.
- It never pushes anything. Snapshots are local until you `git push --follow-tags`.
- `snaplog` runs `git add -A`, so review what is in your folder first.

## Use it with an AI coding agent

Copy `skill/SKILL.md` into `~/.claude/skills/snaplog/` (Claude Code) or paste its text into your agent's instructions. The agent will then snapshot at the right moments without being asked.

## Notes

- The binary is `snaplog`, not `snap`, to avoid clashing with Ubuntu's `snap` package manager.
- `snaplog open` puts copies in `~/.snaplog` (set `SNAPLOG_DIR` to change). Dependencies are not copied.
- Test: `./test/test.sh`

## License

MIT.

---

Made by spacecaret with Claude.
