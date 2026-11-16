#!/usr/bin/env bash
# ./install.sh            install snaplog to ~/.local/bin (or $PREFIX)
# ./install.sh --skill    also install the agent skill for Claude Code (~/.claude/skills/snaplog)
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dest="${PREFIX:-$HOME/.local/bin}"
mkdir -p "$dest"
install -m 755 "$here/bin/snaplog" "$dest/snaplog"
echo "installed $dest/snaplog"
case ":$PATH:" in *":$dest:"*) ;; *) echo "note: add $dest to your PATH";; esac
if [ "${1:-}" = "--skill" ]; then
  sk="$HOME/.claude/skills/snaplog"; mkdir -p "$sk"
  cp "$here/skill/SKILL.md" "$sk/SKILL.md"
  echo "installed skill $sk/SKILL.md"
fi
