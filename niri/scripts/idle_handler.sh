#!/bin/bash

case "$1" in
    dim)
        # Get current and max brightness
        current=$(brightnessctl g)
        max=$(brightnessctl m)
        # Calculate 30% threshold
        limit=$((max * 30 / 100))

        # Only dim if current brightness is higher than 30%
        if [ "$current" -gt "$limit" ]; then
            brightnessctl -s set 30%
            # Create a flag file so we know we dimmed it
            touch /tmp/niri_is_dimmed
        fi
        ;;
    restore)
        # Only restore if we actually dimmed it previously
        if [ -f /tmp/niri_is_dimmed ]; then
            brightnessctl -r
            rm /tmp/niri_is_dimmed
        fi
        ;;
esac
