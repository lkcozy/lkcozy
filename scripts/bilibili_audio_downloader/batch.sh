#!/bin/bash

urls=('')

for url in "${urls[@]}"; do
    echo "Processing URL: $url"
    ./BBDown --audio-only --skip-cover "$url"
done
