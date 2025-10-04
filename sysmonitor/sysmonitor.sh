#!/bin/sh
# Monitor system over time and save data to ~/.data/system
# Collects:
#   - Device name
#   - CPU temp
#   - Battery percent (calculated from energy_now and energy_full)
#   - RAM usage
# Collects data then waits for $sleepTime

outputPath=/home/$(whoami)/.data/system
sleepTime=3s

# Get device name
deviceName=$(cat /sys/class/dmi/id/product_version)

# Get CPU temp
cpuTemp=$(sensors | grep 'Tctl' | awk '{print $2}')

# Get battery percentage (calculated from energy_now and energy_full)
energyNow=$(cat /sys/class/power_supply/BAT1/energy_now)
energyFull=$(cat /sys/class/power_supply/BAT1/energy_full)
batteryPercent=$((100 * energyNow / energyFull)) # Calculate percentage

# Get RAM usage
ramUsed=$(free -h | awk '/^Mem:/ {print $3}')
ramTotal=$(free -h | awk '/^Mem:/ {print $2}')

# Get disk usage
diskUsed=$(df -h | grep mmcblk0p2 | awk '{printf $3}' && echo)
diskTotal=$(df -h | grep mmcblk0p2 | awk '{printf $4}' && echo)

# Format output and save
output="Device: $deviceName\nCPU: ${cpuTemp}\nBattery: ${batteryPercent}%%\nRAM: ${ramUsed}/${ramTotal}\nDisk: ${diskUsed}/${diskTotal}"
printf "$output\n" > $outputPath
echo $output
