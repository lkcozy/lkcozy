# [AutoCut](https://github.com/mli/autocut)

![](https://github.com/mli/autocut/raw/main/imgs/typora.jpg)

AutoCut automatically generates subtitles for videos. Then you select the sentence you wanted, and AutoCut will choose and save the corresponding segment in your video. You don't need to use video editing software. Just edit the text file to complete the editing.

## Prerequisites

- [ffmpeg](https://ffmpeg.org/)

```zsh
brew install ffmpeg
```

- [AutoCut](https://github.com/mli/autocut)

```zsh
pip install git+https://github.com/mli/autocut.git
```

## Usage

Put videos in the folder `2022` then run:

```zsh
autocut -d 2022
```

### Use the large model for better quality

```zsh
autocut -t 22-52-00.mp4 --whisper-model large
```
