#!/bin/bash

# Usage check
if [ -z "$1" ]; then
  echo "Usage: $0 <minutes>"
  exit 1
fi

# Convert minutes to seconds
total_seconds=$(( $1 * 60 ))
cols=$(tput cols)
bar_width=$((cols - 30))  # adjust to leave space for text

# Make sure bar_width is at least 10
if [ $bar_width -lt 10 ]; then bar_width=10; fi

# Timer loop
for ((elapsed=0; elapsed<=total_seconds; elapsed++)); do
  # Progress calculation
  percent=$(( 100 * elapsed / total_seconds ))
  filled=$(( bar_width * elapsed / total_seconds ))
  empty=$(( bar_width - filled ))

  # Time remaining
  remaining=$(( total_seconds - elapsed ))
  mins=$(( remaining / 60 ))
  secs=$(( remaining % 60 ))

  # Draw bar
  printf "\r["
  printf "%0.s#" $(seq 1 $filled)
  printf "%0.s-" $(seq 1 $empty)
  printf "] %3d%% | %02d:%02d remaining" "$percent" "$mins" "$secs"

  sleep 1
done

# Done
echo -e "\n\nTime's up"

