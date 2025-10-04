#!/bin/sh
# Weather information fetching script to get weather data from wttr.in
# Automatically runs every $sleepTime hours

outputPath=/home/$(whoami)/.data/weather
sleepTime=6h

# Send request and capture output
response=$(curl -s https://wttr.in/?format=%t%20%p%20%w)

# Save to file
echo $response > $outputPath
echo $response
