#!/bin/bash

# Clear terminal
clear

# Optional ASCII header
echo -e "\033[1;32m"
cat << "EOF"

  _________ __                 ___________                          
 /   _____//  |______ _______  \__    ___/_ __  ____   ____   ______
 \_____  \\   __\__  \\_  __ \   |    | |  |  \/    \_/ __ \ /  ___/
 /        \|  |  / __ \|  | \/   |    | |  |  /   |  \  ___/ \___ \ 
/_______  /|__| (____  /__|      |____| |____/|___|  /\___  >____  >
        \/           \/                            \/     \/     \/ 

         Terminal Audio Visualizer
EOF
echo -e "\033[0m"
sleep 1

# Launch cava with custom config if needed
exec cava
