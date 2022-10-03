#!/bin/bash

# TODO: enable multiprocessing
# TODO: convert to zx
# TODO: Converting mp4 to mp3 after adding a new file with macos folder action

# From https://askubuntu.com/questions/837916/convert-mp4-to-mp3-using-shell-script

# -o means “OR”
videos=$(find . -type f \( -name '*.mp4' -o -name '*.flv' -o -name '*.m4a' \))
sounds=()
sampleRate="48000"
processedFolder="processed"

for video in $videos; do
    sound=${video%.*}.mp3
    if [ ! -f "$sound" ]; then
        ffmpeg -i "$video" -vn -acodec libmp3lame -ac 2 -qscale:a 4 -ar "$sampleRate" "$sound"
        sounds+=("$sound")
        mv "$video" $processedFolder
    fi
done

echo "Converted ${#sounds[@]}/${#videos[@]} vidoes"

for i in "${sounds[*]}"; do
    echo -e "$i\n"
done

# find . -name "*.mp4" -exec bash -c 'ffmpeg -i "$1" -vn -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 "${1%.mp4}".mp3' - '{}' \;

# echo "Cleaning up mp3 files"
# find . -name "*.mp3" -exec bash -c 'var=${1%.mp3}; var=${var#*/}; rm "${1#*/}"' - '{}' \;

# Explanation
# find . -name "*.mp4" finds all files of .mp4 type. -exec bash -c runs the bash command provided in the succeeding string for each file found. It also passes the filename as variable $1 which can be used in the bash command.

# At this point $1 contains something like ./path/file.mp4. To remove the filetype *.mp4 we use var=${1%.mp4} which stores ./path/file to $var. Now we remove the preceding ./ with var=${var#*/} hence the value of $var is path/file.

# In the ffmpeg command we get the current file name with ${var#*/} which gives path/file.mp4 and we get the output file with ~/PATH/to/NewTopDIr/$var".mp3 where $var has the value path/file as explained above.
