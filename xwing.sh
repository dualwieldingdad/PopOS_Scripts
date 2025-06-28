#!/bin/bash

# Colors for sci-fi effect
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
red=$(tput setaf 1)

weather=$(curl -s -A "Mozilla/5.0" 'https://wttr.in/Raleigh?format=3')
metar_raw=$(curl -s 'https://aviationweather.gov/api/data/metar?ids=KRDU&format=raw' | grep KRDU || echo "METAR UNAVAILABLE")
last_weather_update=$(date +%s)

i=0

while true; do
    clear

    echo -n " "
    for _ in $(seq 1 40); do
      [ $((RANDOM % 10)) -eq 0 ] && echo -n "*" || echo -n " "
    done
    echo

    cat ~/Documents/Rice/xwing/xwing.txt || echo "Logo Missing"

    echo -e "${purple}──────────────────────────────────────────────────────────────────${normal}"

    pulse_frames=("░" "▒" "▓" "█" "▓" "▒")
    frame=${pulse_frames[$((SECONDS % 6))]}
    echo -e "${purple}[SYS ]${normal} Shields: █████████▓ Weapons: ██████▓▓▓▓  Targeting: ████████▓▓"

    now=$(date +%s)
    if (( now - last_weather_update > 300 )); then
        weather=$(curl -s 'https://wttr.in/Raleigh?format=3')
        metar_raw=$(curl -s 'https://aviationweather.gov/api/data/metar?ids=KRDU&format=raw' | grep KRDU || echo "METAR UNAVAILABLE")
        last_weather_update=$now
    fi

    if [[ $metar_raw == KRDU* ]]; then
        read -a metar_tokens <<< "$metar_raw"
        wind=${metar_tokens[2]}
        visibility=${metar_tokens[3]}
        wx_condition=${metar_tokens[4]}
        clouds="${metar_tokens[5]} ${metar_tokens[6]} ${metar_tokens[7]}"
        tempdew=${metar_tokens[8]}
        temp=$(echo $tempdew | cut -d'/' -f1)
        dew=$(echo $tempdew | cut -d'/' -f2)
    else
        wind="N/A"
        visibility="N/A"
        wx_condition="N/A"
        clouds="N/A"
        temp="?"
        dew="?"
    fi

    echo -e "${purple}[WX  ]${normal} $weather"
    echo -e "${purple}[ATC ]${normal} Wind: ${wind:0:3}° @ ${wind:3:2}kt  |  Vis: $visibility"
    echo -e "${purple}[ATC ]${normal} Conditions: $wx_condition  |  Clouds: $clouds"
    echo -e "${purple}[ATC ]${normal} Temp: $temp°C  |  Dewpoint: $dew°C"

    echo -e "${purple}[NAV ]${normal} $(uptime -p)"

    if command -v sensors &>/dev/null; then
    cpu_temp=$(sensors | grep -E 'Package id 0:|Tctl:' | awk '{for(i=1;i<=NF;i++) if ($i ~ /[0-9]+\.[0-9]+°C/) print $i}' | head -n1 | tr -d '+°C')
    
    if [[ -n "$cpu_temp" ]]; then
        cpu_bar=$(yes "▓" | head -n $(awk -v c="$cpu_temp" 'BEGIN{print int(c/5)}') | tr -d '
')
        echo -e "${purple}[CORE]${normal} CPU Temp: ${cpu_temp}°C [${cpu_bar}]"
    else
        echo -e "${purple}[CORE]${normal} CPU Temp: N/A"
    fi
fi

    if command -v nvidia-smi &>/dev/null; then
        gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
        gpu_bar=$(yes "▓" | head -n $(awk -v g="$gpu_temp" 'BEGIN{print int(g/5)}') | tr -d '
')
        echo -e "${purple}[GPU ]${normal} Temp: ${gpu_temp}°C [${gpu_bar}]"
    fi

    cpu_usage=$(top -bn1 | grep "%Cpu" | awk '{print 100 - $8}')
    cpu_bar=$(yes "#" | head -n $(awk -v u="$cpu_usage" 'BEGIN{print int(u/5)}') | tr -d '
')
    echo -e "${purple}[PROC]${normal} CPU: ${cpu_usage}% [${cpu_bar}]"

    total_mem=$(awk '/MemTotal/ {printf "%.1f", $2/1024/1024}' /proc/meminfo)
    used_mem=$(awk '/MemAvailable/ {avail=$2} END {printf "%.1f", (total-avail)/1024/1024}' /proc/meminfo total=$(awk '/MemTotal/ {print $2}' /proc/meminfo))
    mem_bar=$(yes "#" | head -n $(awk -v u="$used_mem" -v t="$total_mem" 'BEGIN{print int((u/t)*20)}') | tr -d '
')
    mem_usage="$used_mem GiB / $total_mem GiB"
    echo -e "${purple}[MEM ]${normal} RAM: $mem_usage [${mem_bar}]"

    disk=$(df -h / | awk 'NR==2 {print $3 " / " $2 " used (" $5 ")"}')
    disk_used_pct=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
    disk_bar=$(yes "=" | head -n $(awk -v d="$disk_used_pct" 'BEGIN{print int(d/5)}') | tr -d '
')
    echo -e "${purple}[DSK ]${normal} $disk [$disk_bar]"

    spinners=('|' '/' '-' '\\')
    i=$(( (i + 1) % 4 ))
    echo -ne "${blue}Status:${normal} Scanning systems ${spinners[$i]}  ${green}$(date +%T)${normal}
"

    sleep 10
done
