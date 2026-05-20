#!/bin/bash

# Listen to raw inputs and ONLY trigger Waybar when Grave is pressed
# while the Meta (Command) key is being held down.
stdbuf -oL libinput debug-events --show-keycodes | awk '
BEGIN { meta=0; active=0 }

# Track ONLY the Command/Meta key state
/KEY_(LEFT|RIGHT)META.*pressed/ { meta=1 }
/KEY_(LEFT|RIGHT)META.*released/ { meta=0 }

# Handle the Grave key press
/KEY_GRAVE.*pressed/ {
    # Only trigger if Meta/Command IS being held
    if (meta==1) {
        active=1
        system("killall -SIGUSR1 waybar")
    }
}

# Handle the Grave key release
/KEY_GRAVE.*released/ {
    # Hide Waybar if it was opened by our Mod+Grave combo
    if (active==1) {
        system("killall -SIGUSR1 waybar")
        active=0
    }
}
'
