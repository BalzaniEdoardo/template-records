#!/bin/sh
# Checks that this computer and this clone are set up for editing the records
# (macOS and Linux). Changes nothing; says what is missing and how to fix it.
cd "$(dirname "$0")" || exit 1

if ! command -v safedata >/dev/null 2>&1; then
    echo "safedata is not installed on this computer (or not on PATH). Install it with:" >&2
    echo "  curl -LsSf https://raw.githubusercontent.com/BalzaniEdoardo/safedata/main/install.sh | sh" >&2
    echo "then open a new terminal and run this script again." >&2
    exit 1
fi
exec safedata check
