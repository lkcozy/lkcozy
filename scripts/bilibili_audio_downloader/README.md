# Bilibili Audio Downloader

Download only the audio part of the video from bilibili. It supports to download multiple audios at once.

## Prerequisites

- [zx](https://github.com/google/zx): write shell scripts in Node. `yarn global add zx`
  - alternative: [lux](https://github.com/iawia002/lux)
- [jq](https://jqlang.github.io/jq/download/): a lightweight and flexible command-line JSON processor. `brew install jq`
- [ffmpeg](https://formulae.brew.sh/formula/ffmpeg): Play, record, convert, and stream audio and video. `brew install ffmpeg`
- [BBDown](https://github.com/nilaoda/BBDown): Bilibili Downloader

## Usage

Check the latest version

```zsh
curl -s https://api.github.com/repos/nilaoda/BBDown/releases/latest | grep '"tag_name":'
// or
curl -s https://api.github.com/repos/nilaoda/BBDown/releases/latest | jq -r '.tag_name'
```

```zsh
curl -s "https://api.github.com/repos/nilaoda/BBDown/releases/latest" | jq '.assets[] | {name: .name, download_url: .browser_download_url}'
```

Download the latest [BBDown](https://github.com/nilaoda/BBDown/releases)

```zsh
curl -Lk "https://github.com/nilaoda/BBDown/releases/download/1.6.1/BBDown_1.6.1_20230818_osx-x64.zip" -o temp.zip && unzip -o temp.zip && chmod +x BBDOWN && rm temp.zip
```

> `-L` follows any redirects that occur while trying to download the file.
> `-k` allows downloading from insecure HTTPS connections if needed.

Make a script file executable

```zsh
chmod +x batchAudio.mjs
# update urls with desired Bilibili video urls, ["url1","url2"]
./batchAudio.mjs
```

## Docker Version Usage

### Install Docker Containers Manager

- [OrbStack](https://orbstack.dev/download): Fast, light, powerful way to run containers on macOS `brew install orbstack`
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

```zsh
# starts and manages containers based on existing images
docker-compose up
# ensures that the images are built before starting the containers
docker-compose up --build
# disable the Docker build cache when creating images for services
docker-compose build --no-cache
# copy the download folder to your local directory
docker cp bilibili_audio_downloader:/app/download .
# execute a command within the container
docker exec bilibili_audio_downloader ls /app/download
```

## Transcribe Audio

- [Lark Minutes](https://www.larksuite.com/en_us/product/minutes): transcribe video meetings into transcripts that you can view, search, and collaborate on.
- [Whisper](https://github.com/openai/whisper): a general-purpose speech recognition model.
- [AutoCut](https://github.com/mli/autocut): AutoCut automatically generates subtitles for videos. Then you select the sentence you wanted, and AutoCut will choose and save the corresponding segment in your video. You don't need to use video editing software. Just edit the text file to complete the editing.

## TODOs

- transcribe downloaded audios

```

```
