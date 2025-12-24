#!/bin/bash

# A graphical settings menu using YAD
# It lets you toggle bars, change wallpaper, or open system settings

KEY=$(yad --width=400 --height=300 --center \
    --title="System Control" \
    --text="Manage your Niri Shell" \
    --window-icon="preferences-system" \
    --button="Toggle Waybar:1" \
    --button="Select Wallpaper:2" \
    --button="Edit Config:3" \
    --button="Close:0" \
    --list --column="Quick Toggles" \
    "Wi-Fi Settings" "Bluetooth" "Power Profiles" "Cursor Toggle")

RET=$?

if [[ $RET -eq 1 ]]; then
    # Toggle Waybar
    if pgrep -x "waybar" > /dev/null; then
        pkill waybar
    else
        waybar &
    fi
elif [[ $RET -eq 2 ]]; then
    # Simple wallpaper picker using Fuzzel (or your preferred file picker)
    WALL=$(find ~/Pictures -type f | fuzzel --dmenu -p "Wallpaper: ")
    if [ -n "$WALL" ]; then
        swww img "$WALL" --transition-type grow --transition-pos 0.5,0.5
    fi
elif [[ $RET -eq 3 ]]; then
    # Open Config
    alacritty -e nano ~/.config/niri/config.kdl
fi

# Handle the list selection (if you clicked a row then hit ok)
# You can expand this logic to open specific apps for Wi-Fi/BT
