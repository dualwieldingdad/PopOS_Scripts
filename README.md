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
- `bash`, `shuf`, and standard Linux coreutils

To install most dependencies on Fedora/Nobara:

```bash
sudo dnf install cava fastfetch mpv figlet btop
