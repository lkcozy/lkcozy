# [Extract images from pdf](https://mp.weixin.qq.com/s/Y7temTf4fcXUtzV9ZnXmrg)

## Prerequisites

- [Pipenv](https://pypi.org/project/pipenv/): Python Development Workflow for Humans

## Usage

Put PDF files to the folder `unprocessed`.

```python
pipenv install
pipenv shell
python index.py
```

The extracted images will be saved to the to the folder `images`.

The processed PDF files will be moved to the folder `processed`.

## [PyMuPDF](https://pymupdf.readthedocs.io/en/latest/tutorial.html)

PyMuPDF adds Python bindings and abstractions to MuPDF, a lightweight PDF, XPS, and eBook viewer, renderer, and toolkit. Both PyMuPDF and MuPDF are maintained and developed by Artifex Software, Inc.
