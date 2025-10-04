#!/bin/sh
# Print ASCII art and system information

# Define color sequences
GREEN="\033[32m"
RED="\033[31m"
BLUE="\033[34m"
BOLD="\033[1m"
RESET="\033[0m"

# Define ASCII strings
asciiArtLine1="   _______    "
asciiArtLine2=" _ \\______ -   "
asciiArtLine3="| \\  ___  \\ |  "
asciiArtLine4="| | /   \\ | |  "
asciiArtLine5="| | \\___/ | |  "
asciiArtLine6="| \\______ \\_|  "
asciiArtLine7=" -________\\    "

# Get data
# Device name
deviceName=$(cat /sys/class/dmi/id/product_version)

# CPU model
cpuModel=$(lscpu | grep "Model name" | awk -F': ' '{print $2}' | sed 's/^[[:space:]]*//')

# Distribution
osInfo=$(cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f2- | tr -d '"')

# RAM data
ramUsed=$(free -h | awk '/^Mem:/ {print $3}')
ramTotal=$(free -h | awk '/^Mem:/ {print $2}')

# Colors
colorLine="${BOLD}${RED}###${GREEN}###${BLUE}###${RESET}"

# Echo each line of ASCII art with data
printf "${GREEN}$asciiArtLine1${RESET}\n"

printf "${GREEN}$asciiArtLine2${RED}"
printf "Device: ${RESET}${deviceName}\n"

printf "${GREEN}$asciiArtLine3${RED}"
printf "OS: ${RESET}${osInfo}\n"

printf "${GREEN}$asciiArtLine4${RED}"
printf "CPU: ${RESET}${cpuModel}\n"

printf "${GREEN}$asciiArtLine5${RED}"
printf "RAM: ${RESET}${ramUsed}/${ramTotal}\n"

printf "${GREEN}$asciiArtLine6${RED}"
printf "$colorLine\n"

printf "${GREEN}$asciiArtLine7${RESET}\n"

echo
