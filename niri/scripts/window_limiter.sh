#!/bin/bash

MAX_WINDOWS=20

while true; do
    # 1. Get the ID of the currently active workspace
    active_ws=$(niri msg -j workspaces | jq -r '.[] | select(.is_active).id')

    if [ -n "$active_ws" ]; then
        # 2. Count windows on this specific workspace
        count=$(niri msg -j windows | jq --argjson ws "$active_ws" '[.[] | select(.workspace_id == $ws)] | length')

        # 3. If count exceeds limit, move the focused window away
        if [ "$count" -gt "$MAX_WINDOWS" ]; then
            niri msg action move-window-to-workspace-down
            notify-send "Workspace Full" "Limit of $MAX_WINDOWS reached. Window moved." -i view-restore
        fi
    fi
    
    # Check again in 2 seconds
    sleep 2
done
