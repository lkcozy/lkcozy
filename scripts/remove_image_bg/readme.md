# [Rembg](https://github.com/danielgatis/rembg)

Rembg is a tool to remove images background. That is it.

## Usage as a cli

Remove the background from a remote image

```bash
curl -s http://input.png | rembg i > output.png
```

Remove the background from a local file

```bash
rembg i path/to/input.png path/to/output.png
```

Remove the background from all images in a folder

```bash
rembg p path/to/input path/to/output
```
