#!/bin/bash
CURRENT=$(powerprofilesctl get)
SELECTION=$(echo -e "Performance \nBalanced \nPower Saver " | fuzzel --dmenu --prompt="Current: $CURRENT > " --lines=3 --width=25)

if [[ "$SELECTION" == *"Performance"* ]]; then
    powerprofilesctl set performance
    notify-send -a "System" "Mode: Performance" "CPU at max speed for gaming."
elif [[ "$SELECTION" == *"Balanced"* ]]; then
    powerprofilesctl set balanced
    notify-send -a "System" "Mode: Balanced" "Standard settings applied."
elif [[ "$SELECTION" == *"Power Saver"* ]]; then
    powerprofilesctl set power-saver
    notify-send -a "System" "Mode: Power Saver" "Saving battery."
fi
