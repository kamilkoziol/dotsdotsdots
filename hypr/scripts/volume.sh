#!/bin/bash

# Function to get the current volume
get_current_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//'
}

notify-volume () {

    local TOGGLE_OPTION=$1
    local MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | sed 's/Mute: //')
    local MUTED_TEXT=''

    local CURRENT_VOLUME=$(get_current_volume)
    echo $MUTED

    if [[ $MUTED = "yes" ]]; then
        MUTED_TEXT=" \(muted)"
    fi



    dunstify \
        -a "Volume control" \
        -h string:x-dunst-stack-tag:VOLUMECONTROL \
        -h int:value:$CURRENT_VOLUME \
        "Volume control" \
        "$CURRENT_VOLUME%$MUTED_TEXT" 
}

# Check command line arguments
if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute" ) ]]; then
    printf "Usage: $0 [inc|dec|mute]\n"
    exit 1
fi

# Check if pactl is installed
if ! command -v pactl &> /dev/null; then
    echo "Error: pactl is not installed. Please install it and try again."
    exit 1
fi

# Perform volume adjustment
if [[ "$1" == "inc" ]]; then
    [ "$(get_current_volume)" -lt 150 ] && pactl set-sink-volume @DEFAULT_SINK@ +5%
    notify-volume 
elif [[ "$1" == "dec" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    notify-volume 
elif [[ "$1" == "mute" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    notify-volume 
fi

