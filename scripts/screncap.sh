#!/bin/bash
# script to run screencapture every one second

screenshot="$(which screencapture) -x -m -C"
freq=30     #take a screenshot every 30 seconds
maxshots=45 #take 45 screenshots then quit

while getopts "af:m" opt; do
    case $opt in
    f) freq=$OPTARG ;;
    m) maxshots=$OPTARG ;;
    ?)
        echo "Usage: $0 [-f frequency] [-m maxcaps]" >&2
        exit 1
        ;;
    esac
done

counter=1 #set startng number; incrementally append to filename

while [ $counter -lt $maxshots ]; do
    $screenshot screenshot${counter}.jpg
    counter=$((counter + 1))
    sleep $freq
done

exit
