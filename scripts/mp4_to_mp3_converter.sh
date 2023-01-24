#!/bin/bash

# From https://askubuntu.com/questions/837916/convert-mp4-to-mp3-using-shell-script

# IFS: Internal Field Separator
# determines how fields (or items) within a string are separated.
# by default, Bash will treat any combination of space, tab, or newline characters as a separator when splitting strings.
OIFS=$IFS
IFS=$'\n'

# From https://askubuntu.com/questions/837916/convert-mp4-to-mp3-using-shell-script
types=("mp4" "m4a" "wav" "flv" "mov")

cmd="find . "

for type in "${types[@]}"; do
    cmd+="-name '*.$type' -o " # -o means “OR”
done

# Remove the last " -o " from the command string
cmd=${cmd% -o *}
videos=$(eval "$cmd")
sounds=()
sampleRate="48000"
processedFolder="processed"
keepOriginal=true

declare -i video_count=0

for video in $videos; do
    sound=${video/ (enhanced)/}
    sound=${sound%.*}.mp3
    video_count+=1
    if [ ! -f "$sound" ]; then
        ffmpeg -i "$video" -vn -acodec libmp3lame -ac 2 -qscale:a 4 -ar "$sampleRate" "$sound"
        sounds+=("$sound")
        if [ "$keepOriginal" = true ]; then
            mv "$video" $processedFolder
        else
            rm "$video"
        fi
    fi
done

echo "Converted ${#sounds[@]}/$video_count vidoes"

for s in $sounds; do
    echo -e "$s\n"
done

# restore $IFS
IFS=$OIFS

# find . -name "*.mp4" -exec bash -c 'ffmpeg -i "$1" -vn -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 "${1%.mp4}".mp3' - '{}' \;

# echo "Cleaning up mp3 files"
# find . -name "*.mp3" -exec bash -c 'var=${1%.mp3}; var=${var#*/}; rm "${1#*/}"' - '{}' \;

# Explanation
# find . -name "*.mp4" finds all files of .mp4 type. -exec bash -c runs the bash command provided in the succeeding string for each file found. It also passes the filename as variable $1 which can be used in the bash command.

# At this point $1 contains something like ./path/file.mp4. To remove the filetype *.mp4 we use var=${1%.mp4} which stores ./path/file to $var. Now we remove the preceding ./ with var=${var#*/} hence the value of $var is path/file.

# In the ffmpeg command we get the current file name with ${var#*/} which gives path/file.mp4 and we get the output file with ~/PATH/to/NewTopDIr/$var".mp3 where $var has the value path/file as explained above.
