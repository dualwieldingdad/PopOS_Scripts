#!/bin/bash

# Clear terminal
clear

# Optional ASCII header
echo -e "\033[1;32m"
cat << "EOF"
   ___  ____  __     __    _    _   _ _____ ____  
  / _ \|  _ \ \ \   / /   / \  | \ | | ____|  _ \ 
 | | | | |_) | \ \ / /   / _ \ |  \| |  _| | | | |
 | |_| |  __/   \ V /   / ___ \| |\  | |___| |_| |
  \___/|_|       \_/   /_/   \_\_| \_|_____|____/ 
         Terminal Audio Visualizer
EOF
echo -e "\033[0m"
sleep 1

# Launch cava with custom config if needed
exec cava
