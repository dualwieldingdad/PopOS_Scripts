# XWing Dashboard

> Built for Pop!_OS

---

## 🎮 Scripts Included

| Script Name             | Purpose                                              |
|-------------------------|------------------------------------------------------|
| `launch_visualizer.sh`  | Launches `cava` audio visualizer in terminal         |
| `xwing.sh`              | Displays a Star Wars-inspired system stat header     |
| `empire_scanner_hud.sh` | Live HUD + scrolling Empire-style threat logs + audio stream |

---

## 📦 Requirements

These tools must be installed on your system for the scripts to function:

- [`cava`](https://github.com/karlstav/cava) – Audio spectrum visualizer for terminal  
- [`fastfetch`](https://github.com/fastfetch-cli/fastfetch) – Fast system info banner  
- [`btop`](https://github.com/aristocratos/btop) – System monitor (optional)  
- [`figlet`](http://www.figlet.org/) – ASCII banner generator (optional)  
- [`mpv`](https://mpv.io/) – For streaming audio (police scanner)  

## 🗂️ empire_scanner_hud.sh File Structure

Youll have to edit the script to point to your .txt file directory

- File structure for empire_scanner_hud.sh:
- Make sure line #4 LOG_DIR="$HOME/" is pointing to a directory you created to hold your 6 .txt files
- units.txt
- genders.txt
- species.txt
- actions.txt
- locations.txt
- notes.txt

## 🔗 Useful Links

- Cava Documentation(music visualizer) - https://github.com/karlstav/cava#installation
- Fastfetch - https://github.com/fastfetch-cli/fastfetch#usage
- Btop - https://github.com/aristocratos/btop
- Broadcastify Scanner Feeds - https://www.broadcastify.com/listen/
- YoutubeMusicDesktop - https://flathub.org/apps/app.ytmdesktop.ytmdesktop
- YTMDesktop Themes - https://github.com/OceanicSquirrel/themes-for-ytmdesktop-player


