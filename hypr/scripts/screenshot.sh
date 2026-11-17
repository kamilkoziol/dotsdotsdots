#!/usr/bin/env bash

USER_DIRS="${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
[[ -f $USER_DIRS ]] && source "$USER_DIRS"

SHOTS="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
CLIPS="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"

require() {
    local missing=()
    for bin in "$@"; do
        command -v "$bin" &>/dev/null || missing+=("$bin")
    done
    if ((${#missing[@]})); then
        notify-send -a Screenshot "Missing tools" "Install: ${missing[*]}"
        exit 1
    fi
}

edit() {
    mkdir -p "$SHOTS"
    satty --filename - \
        --output-filename "$SHOTS/%Y-%m-%d_%H-%M-%S.png" \
        --copy-command wl-copy
}

active_window_geometry() {
    hyprctl activewindow | awk '
        $1 == "at:"   { at = $2 }
        $1 == "size:" { split($2, s, ","); size = s[1] "x" s[2] }
        END { if (at && size) print at " " size }'
}

case "$1" in
    region)
        require grim slurp satty
        geom=$(slurp) || exit 0
        grim -g "$geom" - | edit
        ;;
    full)
        require grim satty
        grim - | edit
        ;;
    window)
        require grim satty
        geom=$(active_window_geometry)
        [[ -n $geom ]] || exit 0
        grim -g "$geom" - | edit
        ;;
    record)
        if pgrep -x wf-recorder &>/dev/null; then
            pkill -INT -x wf-recorder
            notify-send -a Screenshot "Recording saved" "$CLIPS"
            exit 0
        fi
        require slurp wf-recorder
        geom=$(slurp) || exit 0
        mkdir -p "$CLIPS"
        notify-send -a Screenshot "Recording started" "Alt+Print to stop"
        wf-recorder -g "$geom" -f "$CLIPS/$(date +%Y-%m-%d_%H-%M-%S).mp4" &>/dev/null
        ;;
    *)
        printf 'Usage: %s [region|full|window|record]\n' "$0"
        exit 1
        ;;
esac
