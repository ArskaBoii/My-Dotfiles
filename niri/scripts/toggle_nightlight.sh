#!/bin/bash

# Check if gammastep is running
if pgrep -x "gammastep" > /dev/null
then
    # If running, kill it (Turn OFF)
    pkill gammastep
    notify-send -r 9991 -u low "Night Light" "Disabled "
else
    # If not running, start it (Turn ON)
    # Using your Ylöjärvi coordinates and preferred temps
    gammastep -l 61.5:23.6 -t 6500:3500 &
    notify-send -r 9991 -u low "Night Light" "Enabled "
fi
