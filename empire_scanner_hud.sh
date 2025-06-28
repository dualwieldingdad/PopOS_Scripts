#!/bin/bash

# === Empire Activity Monitor — Static HUD Style ===
LOG_DIR="$HOME/PathToYourScriptDirectory"
#generic mp3 for scanner audio. Replace with real scanner audio URL
STREAM_URL="https://ice1.somafm.com/dronezone-128-mp3"

UNITS="$LOG_DIR/units.txt"
GENDERS="$LOG_DIR/genders.txt"
SPECIES="$LOG_DIR/species.txt"
ACTIONS="$LOG_DIR/actions.txt"
LOCATIONS="$LOG_DIR/locations.txt"
NOTES="$LOG_DIR/notes.txt"

MAX_LOGS=8
LOG_LINES=()

draw_screen() {
    tput clear
    tput cup 0 0
    echo -e "\033[1;31m"
    cat << "EOF"
.___                                 .__         .__     __      __          __           .__     
|   |  _____  ______    ____ _______ |__|_____   |  |   /  \    /  \_____  _/  |_   ____  |  |__  
|   | /     \ \____ \ _/ __ \\_  __ \|  |\__  \  |  |   \   \/\/   /\__  \ \   __\_/ ___\ |  |  \ 
|   ||  Y Y  \|  |_> >\  ___/ |  | \/|  | / __ \_|  |__  \        /  / __ \_|  |  \  \___ |   Y  \
|___||__|_|  /|   __/  \___  >|__|   |__|(____  /|____/   \__/\  /  (____  /|__|   \___  >|___|  /         
           \/ |__|         \/                 \/               \/        \/            \/      \/          //Imperial Surveillance Terminal

╔╦╗┌─┐  ┌─┐┬─┐  ┌┬┐┌─┐  ┌┐┌┌─┐┌┬┐  ╔╦╗┬ ┬┌─┐┬─┐┌─┐  ┬┌─┐  ┌┐┌┌─┐  ╔╦╗┬─┐┬ ┬
 ║║│ │  │ │├┬┘   │││ │  ││││ │ │    ║ ├─┤├┤ ├┬┘├┤   │└─┐  ││││ │   ║ ├┬┘└┬┘
═╩╝└─┘  └─┘┴└─  ─┴┘└─┘  ┘└┘└─┘ ┴o   ╩ ┴ ┴└─┘┴└─└─┘  ┴└─┘  ┘└┘└─┘   ╩ ┴└─ ┴ 

EOF
    echo -e "\033[0m"
    echo ""
    echo "🔴 Initializing threat matrix..."
    echo "📡 Synchronizing field units..."
    echo "🛰️  Comm-link to patrol grid online."
    echo ""

    # Draw log lines
    for log in "${LOG_LINES[@]}"; do
        echo -e "$log"
    done
}

# Background audio stream
mpv --no-video --volume=0 "$STREAM_URL" &

# HUD loop
while true; do
    if [[ -f "$UNITS" && -f "$GENDERS" && -f "$SPECIES" && -f "$ACTIONS" && -f "$LOCATIONS" && -f "$NOTES" ]]; then
        UNIT=$(shuf -n1 "$UNITS")
        GENDER=$(shuf -n1 "$GENDERS")
        RACE=$(shuf -n1 "$SPECIES")
        ACT=$(shuf -n1 "$ACTIONS")
        LOC=$(shuf -n1 "$LOCATIONS")
        NOTE=$(shuf -n1 "$NOTES")

        NEW_LINE="\033[0;31m[$(date +%H:%M:%S)] $UNIT — $GENDER $RACE $ACT at $LOC. $NOTE\033[0m"

        # Maintain a rolling buffer of log lines
        LOG_LINES+=("$NEW_LINE")
        if [ "${#LOG_LINES[@]}" -gt "$MAX_LOGS" ]; then
            LOG_LINES=("${LOG_LINES[@]:1}")
        fi

        draw_screen
    else
        echo -e "\033[0;31m[$(date +%H:%M:%S)] Empire Dispatch: Data file missing.\033[0m"
    fi

    sleep $((RANDOM % 6 + 4))
done
