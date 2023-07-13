# Bilibili Audio Downloader

Download only the audio part of the video from bilibili.

## Prerequisites

- [zx](https://github.com/google/zx): write shell scripts in Node. `yarn global add zx`
- [ffmpeg](https://formulae.brew.sh/formula/ffmpeg): Play, record, convert, and stream audio and video. `brew install ffmpeg`
- [BBDown](https://github.com/nilaoda/BBDown): Bilibili Downloader

## Usage

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
