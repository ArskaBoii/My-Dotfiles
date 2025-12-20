#!/bin/bash

# Define the visual options with icons
# Using variables makes it easy to match in the case statement
shutdown="  Shutdown"
reboot="  Reboot"
logout="  Logout"
suspend="  Suspend"
hibernate="󰒲  Hibernate"
lock="  Lock"
exit_opt="❌ Exit"

# Pipe options to Fuzzel
# -p: Prompt text
# --lines 7: Fits all your options perfectly without scrolling
# --width 30: matches the compact look
chosen=$(echo -e "$shutdown\n$reboot\n$logout\n$suspend\n$hibernate\n$lock\n$exit_opt" | fuzzel --dmenu -p "Power Menu: " --lines 7 --width 30)

# Execute the command based on the choice
case $chosen in
    "$shutdown")  systemctl poweroff ;;
    "$reboot")    systemctl reboot ;;
    "$logout")    niri msg action quit --skip-confirmation ;;
    "$suspend")   systemctl suspend ;;
    "$hibernate") systemctl hibernate ;;
    "$lock")      swaylock ;;
    "$exit_opt")  exit 0 ;;
    *)            exit 1 ;;
esac
