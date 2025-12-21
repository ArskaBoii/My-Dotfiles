#!/bin/bash

MAX_WINDOWS=20

# Use 'niri msg event-stream' to listen for events instead of checking every 2 seconds.
# logic: Wait for "WindowOpened" -> Check count -> Move if full.

niri msg event-stream | jq --unbuffered -c 'select(.WindowOpened)' | while read -r event; do

    # 1. Get the ID of the currently active workspace
    active_ws=$(niri msg -j workspaces | jq -r '.[] | select(.is_active).id')

    if [ -n "$active_ws" ]; then
        # 2. Count windows ONLY on this specific workspace
        count=$(niri msg -j windows | jq --argjson ws "$active_ws" '[.[] | select(.workspace_id == $ws)] | length')

        # 3. If count exceeds limit, move the NEW window (which is currently focused)
        if [ "$count" -gt "$MAX_WINDOWS" ]; then
            niri msg action move-window-to-workspace-down
            notify-send "Workspace Full" "Limit of $MAX_WINDOWS reached. New window moved down." -i view-restore
        fi
    fi
done
