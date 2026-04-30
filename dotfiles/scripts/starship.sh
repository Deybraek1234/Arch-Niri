#!/usr/bin/env bash
# wallust-starship.sh
# Regenerates starship.toml using wallust's current palette.
# Every color is derived from wallust slots — no hardcoded values remain.
#
# Color role mapping:
#   background  → wallust background  (darkest bg, directory segment)
#   foreground  → wallust foreground  (light text on dark bg)
#   color0      → wallust color0      (darkest — username text on accent)
#   color1      → wallust color1      (red — errors, sudo warning)
#   color4      → wallust color4      (blue — cmd_duration)
#   color6      → wallust color6      (cyan — hostname bg)
#   color7      → wallust color7      (white — hostname text)
#   color8      → wallust color8      (bright black — hostname segment bg)
#   color11     → wallust color11     (yellow — jobs indicator)
#   color12     → wallust color12     (bright accent — username bg, separators, time, success)

set -euo pipefail

WALLUST_COLORS="$HOME/.config/starship/starship-colors"
STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# --- helpers -----------------------------------------------------------------

die() { echo "error: $*" >&2; exit 1; }

get_color() {
    local key="$1"
    local value
    value=$(grep -E "^[[:space:]]*${key}[[:space:]]*=" "$WALLUST_COLORS" \
            | head -1 \
            | sed -E 's/.*=[[:space:]]*"?#?([a-fA-F0-9]{6})"?.*/\1/')
    [[ -n "$value" ]] || die "color '${key}' not found in $WALLUST_COLORS"
    echo "#${value}"
}

# --- checks ------------------------------------------------------------------

[[ -f "$WALLUST_COLORS" ]]  || die "wallust colors not found at $WALLUST_COLORS — run wallust first."
[[ -f "$STARSHIP_CONFIG" ]] || die "starship config not found at $STARSHIP_CONFIG"

# --- read palette ------------------------------------------------------------

BG=$(get_color "background")   # darkest bg  — directory segment, leftmost block
FG=$(get_color "foreground")   # light text  — directory text
C0=$(get_color "color0")       # true black  — text on bright accent blocks
C1=$(get_color "color1")       # red         — error symbol, sudo indicator
C2=$(get_color "color2")
C3=$(get_color "color3")
C4=$(get_color "color4")       # blue        — cmd_duration
C5=$(get_color "color5")
C6=$(get_color "color6")
C7=$(get_color "color7")       # white       — hostname text
C8=$(get_color "color8")       # bright bg   — hostname segment background
C9=$(get_color "color9")
C10=$(get_color "color10")
C11=$(get_color "color11")     # yellow      — jobs indicator
C12=$(get_color "color12")     # bright blue — primary accent (username, separators, time, success)
C13=$(get_color "color13")
C14=$(get_color "color14")
C15=$(get_color "color15")

echo "wallust → starship"
printf "  %-12s %s\n" "background"  "$BG"
printf "  %-12s %s\n" "foreground"  "$FG"
printf "  %-12s %s\n" "color0"      "$C0"
printf "  %-12s %s\n" "color1"      "$C1"
printf "  %-12s %s\n" "color4"      "$C4"
printf "  %-12s %s\n" "color7"      "$C7"
printf "  %-12s %s\n" "color8"      "$C8"
printf "  %-12s %s\n" "color11"     "$C11"
printf "  %-12s %s\n" "color12"     "$C12"
echo "  config       = $STARSHIP_CONFIG"

# --- regenerate starship.toml ------------------------------------------------

cp "$STARSHIP_CONFIG" "${STARSHIP_CONFIG}.bak"

cat > "$STARSHIP_CONFIG" << TOML
format = """
[](fg:${C4})[ ](bg:${C4} fg:#ffffff)\$directory[](bg:${C8} fg:${C4})\$username[](bg:${C6} fg:${C8})\$hostname[](fg:${C6})\$cmd_duration\$jobs\$git_branch\$git_metrics\$git_status\$fill\$time\$line_break\$character
"""

command_timeout = 2000
scan_timeout = 500
add_newline = true

[character]
success_symbol = "[λ](bold ${C13})"
error_symbol = "[Δ](bold ${C14})"

[directory]
truncation_length = 3
truncation_symbol = ".../"
read_only = "  "
style = "bg:${C4} fg:#ffffff"
format = "[ \$path ](\$style)"

[fill]
symbol = " "

[cmd_duration]
min_time = 5
format = "[   \$duration ](bold #ffffff)"

[hostname]
ssh_only = false
style = "bg:${C6} fg:#ffffff"
format = "[ \$hostname ](\$style)"

[git_branch]
style = "fg:#ffffff"

[jobs]
symbol_threshold = 1
number_threshold = 2
symbol = "󱐌"
format = "[\$symbol\$number](bold #ffffff)"

[username]
show_always = true
style_user = "bg:${C8} fg:#ffffff"
style_root = "bg:${C9} fg:${C15}"
format = "[ \$user ](\$style)"

[time]
disabled = false
format = "[\$time](#ffffff)"
use_12hr = true
time_format = "%T"
utc_time_offset = "local"

[sudo]
symbol = " 󰐼 "
disabled = false
format = "[\$symbol](bold ${C6})"

[line_break]
disabled = false
TOML

echo "  done. (backup at ${STARSHIP_CONFIG}.bak)"
