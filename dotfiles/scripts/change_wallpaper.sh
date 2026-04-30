#!/bin/bash

if [ "$1" == "random" ]; then
    dir="$HOME/Pictures/wallpaper"
    l="$(find "$dir" -maxdepth 1 -type f | shuf -n 10 | shuf -n 1)"
else
    l="$1"
    close=1
fi

cp "$l" /tmp/picture.jpg &
wallust run "$l" 
awww img "$l" --transition-type "wave" --transition-fps 60 --transition-duration 1 &

~/scripts/niri.sh &
~/scripts/mako.sh &
~/scripts/swaylock.sh &
~/scripts/starship.sh &

if [ $close == 1 ]; then
    niri msg -j windows | jq '.[] | select(.app_id == "wallpaper") | .id' | xargs -r -I {} niri msg action close-window --id {}
fi
