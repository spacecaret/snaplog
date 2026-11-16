#!/usr/bin/env bash
set -euo pipefail
dest="${PREFIX:-$HOME/.local/bin}"
mkdir -p "$dest"
install -m 755 "$(cd "$(dirname "$0")" && pwd)/bin/snaplog" "$dest/snaplog"
echo "installed $dest/snaplog"
case ":$PATH:" in *":$dest:"*) ;; *) echo "note: add $dest to your PATH";; esac
