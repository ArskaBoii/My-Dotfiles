#!/bin/bash
# Checks if touchpad is enabled in Niri config and toggles it.
# NOTE: Niri doesn't have a simple CLI toggle command yet, so we swap a config file snippet.

CONFIG_FILE="$HOME/.config/niri/config.kdl"

if grep -q "tap-disabled" "$CONFIG_FILE"; then
    # Enable Touchpad
    sed -i 's/tap-disabled/tap/g' "$CONFIG_FILE"
    notify-send -a "System" "Touchpad: ON" "Input enabled."
else
    # Disable Touchpad
    sed -i 's/tap/tap-disabled/g' "$CONFIG_FILE"
    notify-send -a "System" "Touchpad: OFF" "Input disabled."
fi
