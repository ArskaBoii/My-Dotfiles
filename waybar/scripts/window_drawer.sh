#!/bin/bash

# 1. Get list of windows
list=$(niri msg -j windows | jq -r '.[] | "\(.id)   [\(.workspace_id)]  \(.app_id) - \(.title)"')

# 2. Show in Fuzzel (Adjusted Position)
# --width 35: Much narrower (was 50)
# --y-margin 55: Pulled up closer to the bar (was 70)
# --lines 10: Keeps the list compact
selected=$(echo "$list" | fuzzel --dmenu --prompt="Go to: " --lines 10 --width 30 --anchor top-left --x-margin 15 --y-margin 15)

# 3. Focus the selected window
if [ -n "$selected" ]; then
    id=$(echo "$selected" | awk '{print $1}')
    niri msg action focus-window --id "$id"
fi
