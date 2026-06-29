#!/usr/bin/env bash

set -euo pipefail

VENV="$HOME/.local/state/quickshell/.venv"
CACHE="$HOME/.cache/ricelin"
COLOR_FILE="$HOME/.local/state/quickshell/user/generated/color.txt"

color=$(tr -d '\n' < "$COLOR_FILE")

mode_file="$CACHE/kde-mode.txt"
mode_flag="-d"  # default to dark
if [[ -f "$mode_file" ]]; then
    m=$(tr -d '\n' < "$mode_file")
    if [[ "$m" == "light" ]]; then
        mode_flag="-l"
    fi
fi

source "$VENV/bin/activate"
timeout 5 kde-material-you-colors "$mode_flag" --color "$color" >/dev/null 2>&1 || true
deactivate
