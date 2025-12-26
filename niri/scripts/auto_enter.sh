#!/bin/bash

LOCK_FILE="/tmp/auto_enter.lock"

if [ -f "$LOCK_FILE" ]; then
    # --- STOP ---
    kill $(cat "$LOCK_FILE")
    rm "$LOCK_FILE"
    notify-send -a "Auto Clicker" "Stopped" -u low
else
    # --- START ---
    notify-send -a "Auto Clicker" "Started (Pressing 'e')" -u low

    (
        echo $BASHPID > "$LOCK_FILE"
        while true; do
            # xdotool is safer for games running in XWayland
            xdotool key e

            # Sleep 2-3 seconds
            sleep $(awk -v min=2 -v max=3 'BEGIN{srand(); print min+rand()*(max-min)}')
        done
    ) &
fi
