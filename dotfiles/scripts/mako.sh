#!/bin/bash
source $HOME/.config/mako/mako-colors.sh

MAKO_CONFIG="$HOME/.config/mako/config"

NEW_BLOCK="#MAKO_COLORS_START
border-color=$WAL_COLOR
#MAKO_COLORS_END"

perl -i -0777 -pe "s|#MAKO_COLORS_START.*?#MAKO_COLORS_END|${NEW_BLOCK}|s" "$MAKO_CONFIG"
echo "Done"
makoctl reload
