#!/bin/sh
# Weather information fetching script to get weather data from wttr.in
# Automatically runs every $sleepTime hours

outputPath=/home/$(whoami)/.data/weather
sleepTime=6h

while [ true ]; do
  # Send request and capture output
  echo "[*] Fetching weather data"
  response=$(curl -s https://wttr.in/?format=%t%20%p%20%w)

  # Save to file
  echo "[*] Saving response:\n${response}"
  echo $response > $outputPath

  # Sleep
  echo "[*] Sleeping for $sleepTime"
  sleep $sleepTime
done
