#!/bin/bash

urls=('https://www.bilibili.com/video/BV1ZG411P7g3/')

for url in "${urls[@]}"; do
    echo "Processing URL: $url"
    ./BBDown --audio-only --skip-cover "$url"
done
