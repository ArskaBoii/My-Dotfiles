#!/bin/bash
CONFIG="$HOME/.config/niri/config.kdl"

# Check if the feature is currently enabled (line exists and is NOT commented)
if grep -q "^[[:space:]]*hide-when-typing" "$CONFIG"; then
    # It is ON. Turn it OFF (Add comment)
    sed -i 's/^\([[:space:]]*\)hide-when-typing/\1\/\/ hide-when-typing/' "$CONFIG"
else
    # It is OFF. Turn it ON (Remove comment)
    sed -i 's/^\([[:space:]]*\)\/\/ hide-when-typing/\1hide-when-typing/' "$CONFIG"
fi

# Reload Niri config to apply changes
niri msg action reload-config

# Send signal to Waybar to update the icon immediately
pkill -RTMIN+8 waybar
