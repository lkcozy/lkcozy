#!/bin/bash

urls=()

for url in "${urls[@]}"; do
    echo "Processing URL: $url"
    ./BBDown "$url" --audio-only --skip-cover --skip-subtitle --hide-streams --work-dir download
done
