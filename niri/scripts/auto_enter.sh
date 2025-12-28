#!/bin/bash

LOCK_FILE="/tmp/auto_enter.lock"

if [ -f "$LOCK_FILE" ]; then
    kill $(cat "$LOCK_FILE")
    rm "$LOCK_FILE"
    notify-send -a "Auto Clicker" "Stopped" -u low
else
    notify-send -a "Auto Clicker" "Started (Holding 'e')" -u low

    (
        echo $BASHPID > "$LOCK_FILE"
        while true; do
            # 1. Press Key Down
            xdotool keydown e

            # 2. Wait 0.1 seconds (100ms) so the game sees it
            sleep 0.1

            # 3. Release Key
            xdotool keyup e

            # 4. Wait for the next loop
            sleep $(awk -v min=2 -v max=3 'BEGIN{srand(); print min+rand()*(max-min)}')
        done
    ) &
fi
