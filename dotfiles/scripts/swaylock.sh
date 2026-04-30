COLORS="$HOME/.config/swaylock/colors"
OUT="$HOME/.config/swaylock/config"

[[ -f "$COLORS" ]] || { echo "colors.sh not found: $COLORS"; exit 1; }
 
source "$COLORS"
 
# Strip leading '#' from all color vars
strip() { echo "${1#\#}" | tr '[:upper:]' '[:lower:]'; }
bg=$(strip "$bg")
fg=$(strip "$fg")
c1=$(strip "$color1")
c2=$(strip "$color2")
c4=$(strip "$color4")
c5=$(strip "$color5")
c8=$(strip "$color8")

 
cat > "$OUT" <<- EOF
screenshot
effect-blur=7x5
effect-vignette=0.5:0.5

clock
timestr=%H:%M
datestr=%A, %d %B
font=monospace

color=${bg}cc
inside-color=${bg}00
inside-clear-color=${bg}00
inside-ver-color=${c4}cc
inside-wrong-color=${c1}cc

ring-color=${c8}ff
ring-clear-color=${c2}ff
ring-ver-color=${c4}ff
ring-wrong-color=${c5}ff

line-color=00000000
text-color=${fg}ff
text-clear-color=${c2}ff
text-ver-color=${c4}ff
text-wrong-color=${fg}ff

key-hl-color=${c2}ff
bs-hl-color=${c1}ff
separator-color=00000000

indicator-radius=150
indicator-thickness=15
ignore-empty-password
show-failed-attempts
EOF

echo "swaylock config updated: $OUT"
 

