#!/bin/bash

# --- 1. THE MENU (YAD) ---
# We capture the selection (echoed to stdout) in $CHOICE
# We capture the button clicked (exit code) in $?

CHOICE=$(yad --width=450 --height=500 --center \
    --title="Control Center" \
    --window-icon="preferences-system" \
    --text="<b>System Controls</b>" \
    --image="preferences-system" \
    --image-on-top \
    --button="Toggle Waybar:10" \
    --button="Wallpaper:11" \
    --button="Edit Config:12" \
    --button="Close:1" \
    --button="<b>Open Selected</b>:0" \
    --list \
    --column="Option" --column="Description" \
    "Wi-Fi Settings" "Manage Networks (nm-connection-editor)" \
    "Bluetooth" "Manage Devices (blueman)" \
    "Volume Mixer" "Audio Settings (pavucontrol)" \
    "Night Light" "Toggle Eye Saver (Gammastep)" \
    "Power Mode" "Performance vs Battery" \
    "Cursor" "Show/Hide Mouse Cursor" \
    "Screenshot" "Take a full screen shot" \
    "System Update" "Update Arch/CachyOS" \
    "Power Menu" "Logout, Restart, Shutdown")

# Capture the exit code (Which button was pressed?)
RET=$?

# Remove the trailing separator "|" that YAD adds to the selection
SELECTION=$(echo $CHOICE | awk -F'|' '{print $1}')

# --- 2. HANDLE TOP BUTTONS ---
if [[ $RET -eq 10 ]]; then
    # Toggle Waybar
    if pgrep -x "waybar" > /dev/null; then
        pkill waybar
    else
        waybar &
    fi
    exit 0

elif [[ $RET -eq 11 ]]; then
    # Wallpaper Picker
    WALL=$(find ~/Pictures -type f | fuzzel --dmenu -p "Wallpaper: ")
    if [ -n "$WALL" ]; then
        swww img "$WALL" --transition-type grow --transition-pos 0.5,0.5
    fi
    exit 0

elif [[ $RET -eq 12 ]]; then
    # Edit Config
    alacritty -e nano ~/.config/niri/config.kdl
    exit 0
fi

# --- 3. HANDLE LIST SELECTION ---
# This happens if you clicked "Open Selected" (Exit code 0)

case "$SELECTION" in
    "Wi-Fi Settings")
        nm-connection-editor &
        ;;
    "Bluetooth")
        blueman-manager &
        ;;
    "Volume Mixer")
        pavucontrol &
        ;;
    "Night Light")
        ~/.config/niri/scripts/toggle_nightlight.sh &
        ;;
    "Power Mode")
        ~/.config/waybar/scripts/power_profile.sh &
        ;;
    "Cursor")
        ~/.config/niri/scripts/toggle_cursor.sh &
        ;;
    "Screenshot")
        # Uses Niri's built-in message system
        niri msg action screenshot &
        ;;
    "System Update")
        alacritty -e sudo pacman -Syu &
        ;;
    "Power Menu")
        wlogout &
        ;;
    *)
        # Do nothing if nothing selected
        ;;
esac
