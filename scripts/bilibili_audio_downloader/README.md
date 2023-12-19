# Bilibili Audio Downloader

Download only the audio part of the video from bilibili.

## Prerequisites

- [zx](https://github.com/google/zx): write shell scripts in Node. `yarn global add zx`
- [jq](https://jqlang.github.io/jq/download/): a lightweight and flexible command-line JSON processor. `brew install jq`
- [ffmpeg](https://formulae.brew.sh/formula/ffmpeg): Play, record, convert, and stream audio and video. `brew install ffmpeg`
- [BBDown](https://github.com/nilaoda/BBDown): Bilibili Downloader

## Usage

Check the latest version

````zsh
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
````

> `-L` follows any redirects that occur while trying to download the file.
> `-k` allows downloading from insecure HTTPS connections if needed.

Make a script file executable

```zsh
chmod +x batchAudio.mjs
# update urls with desired Bilibili video urls
./batchAudio.mjs
```

## Transcribe Audio

- [Lark Minutes](https://www.larksuite.com/en_us/product/minutes): transcribe video meetings into transcripts that you can view, search, and collaborate on.
- [Whisper](https://github.com/openai/whisper): a general-purpose speech recognition model.

## TODOs

- transcribe downloaded audios
