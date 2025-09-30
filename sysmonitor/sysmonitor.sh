#!/bin/sh
# Monitor system over time and save data to ~/.data/system
# Collects:
#   - CPU temp (hardcoded for now)
#   - Battery percent (calculated from energy_now and energy_full)
#   - RAM usage
# Collects data then waits for $sleepTime

outputPath=/home/$(whoami)/.data/system
sleepTime=30s

while true; do
  # Get CPU temp
  printf "[*] Getting CPU temp\n"
  cpuTemp=$(sensors | grep 'Tctl' | awk '{print $2}' | tr -d '+°C')

  # Get battery percentage (calculated from energy_now and energy_full)
  printf "[*] Getting battery percentage\n"
  energyNow=$(cat /sys/class/power_supply/BAT1/energy_now)
  energyFull=$(cat /sys/class/power_supply/BAT1/energy_full)
  batteryPercent=$((100 * energyNow / energyFull))  # Calculate percentage

  # Get RAM usage
  printf "[*] Getting RAM usage\n"
  ramUsed=$(free -h | awk '/^Mem:/ {print $3}')
  ramTotal=$(free -h | awk '/^Mem:/ {print $2}')

  # Format output and save (no -e flag for echo)
  output="CPU: ${cpuTemp}\nBattery: ${batteryPercent}\nRAM: ${ramUsed}/${ramTotal}"
  printf "$output\n" > $outputPath  # Append data to the file

  # Sleep
  printf "[*] Sleeping for $sleepTime\n"
  sleep $sleepTime
done

