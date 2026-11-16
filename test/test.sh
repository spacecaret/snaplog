#!/usr/bin/env bash
# minimal smoke test: ./test/test.sh
set -euo pipefail
S="$(cd "$(dirname "$0")/.." && pwd)/bin/snaplog"
T=$(mktemp -d); cd "$T"
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t SNAPLOG_DIR="$T/.open"
"$S" init --chapters >/dev/null
echo hi > a.txt
"$S" "thing breaks" -k broke -n "symptom | with pipe" | grep -q "b02-broke-thing-breaks"
"$S" "thing fixed" -k fixed -c "The fix" | grep -q "b03-fixed-thing-fixed"
"$S" chapters | grep -q "Ch 1"
"$S" list | grep -q b03
d=$("$S" open b02-broke-thing-breaks | head -1); [ -f "$d/a.txt" ]
echo SECRET=1 > .env; mkdir -p k; echo x > k/server.pem
if "$S" "should refuse" 2>/dev/null; then echo "FAIL: secret not blocked"; exit 1; fi
echo "ok"
