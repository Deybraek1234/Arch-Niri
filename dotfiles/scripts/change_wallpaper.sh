#!/bin/bash

dir="$HOME/Pictures/wallpaper"
l="$(find "$dir" -maxdepth 1 -type f | shuf -n 10 | shuf -n 1)"

if [ -z "$l" ]; then
	exit1
fi

cp "$l" /tmp/picture.jpg &
wallust run "$l" &
awww img "$l" --transition-type "wave" --transition-fps 60 --transition-duration 1 &

~/scripts/niri.sh &
~/scripts/mako.sh &
~/scripts/swaylock.sh &
~/scripts/starship.sh &

