#!/usr/bin/env bash

SINK='@DEFAULT_AUDIO_SINK@'

# Function to get the current volume as an integer percentage
get_current_volume() {
    wpctl get-volume "$SINK" | awk '{printf "%.0f", $2 * 100}'
}

is_muted() {
    wpctl get-volume "$SINK" | grep -q MUTED
}

notify-volume () {
    local CURRENT_VOLUME
    CURRENT_VOLUME=$(get_current_volume)
    local MUTED_TEXT=''

    if is_muted; then
        MUTED_TEXT=" (muted)"
    fi

    dunstify \
        -t 3000 \
        -a "Volume control" \
        -h string:x-dunst-stack-tag:VOLUMECONTROL \
        -h int:value:"$CURRENT_VOLUME" \
        "Volume control" \
        "$CURRENT_VOLUME%$MUTED_TEXT"
}

# Check command line arguments
if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute" ) ]]; then
    printf "Usage: %s [inc|dec|mute]\n" "$0"
    exit 1
fi

# Check if wpctl is installed
if ! command -v wpctl &> /dev/null; then
    echo "Error: wpctl is not installed. Please install it and try again."
    exit 1
fi

# Perform volume adjustment
case "$1" in
    inc)
        wpctl set-volume -l 1.5 "$SINK" 5%+
        notify-volume
        ;;
    dec)
        wpctl set-volume "$SINK" 5%-
        notify-volume
        ;;
    mute)
        wpctl set-mute "$SINK" toggle
        notify-volume
        ;;
esac
