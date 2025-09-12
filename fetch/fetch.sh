#!/bin/bash
# Fetch system information and print it with Debian ASCII art

# ASCII Art (6 lines)
asciiArt=(
"  _____    "
" /  __ \\   "
"|  /    |  "
"|  \\___-   "
" -_        "
"   --_     "
)

set -e

# System Information
DEVICE_NAME=$(hostname)
OS_RELEASE=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
UPTIME=$(uptime -p)
MEM_INFO=$(free -h | awk '/^Mem:/ {print $3 " / " $2}')
CPU_MODEL=$(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ //')

# Format data lines to print next to ASCII art
data=(
"DEVICE: $DEVICE_NAME"
"OS:     $OS_RELEASE"
"UPTIME: $UPTIME"
"MEM/CPU:"
"$MEM_INFO / $CPU_MODEL"
)

# Define color codes
colors=(31 32 33 34 35 36)

# Generate colored hash line
hashLine=""
for i in "${!colors[@]}"; do
  hashLine+="\e[1;${colors[$i]}m██\e[0m"
done

# Print ASCII art + data, inserting the hash line into the last line
for i in "${!asciiArt[@]}"; do
  if [[ $i -eq $((${#asciiArt[@]} - 1)) ]]; then
    # Last line — add hash line
    printf "%s %s %b\n" "${asciiArt[$i]}" "${data[$i]}" "$hashLine"
  else
    printf "%s  %s\n" "${asciiArt[$i]}" "${data[$i]}"
  fi
done

echo ""
