#!/bin/bash
source ~/.config/niri/niri-colors.sh

NIRI_CONFIG="$HOME/.config/niri/config.kdl"

NEW_BLOCK="// WAL_COLORS_START
focus-ring {
    width 1
    active-color \"$WAL_COLOR4\"
    inactive-color \"$WAL_COLOR8\"
}

border {
    off
    width 2
    active-color \"$WAL_COLOR4\"
    inactive-color \"$WAL_COLOR0\"
}
// WAL_COLORS_END"

# Replace everything between the sentinel comments
perl -i -0777 -pe "s|// WAL_COLORS_START.*?// WAL_COLORS_END|${NEW_BLOCK}|s" "$NIRI_CONFIG"

# Reload niri
niri msg action load-config-file
