import fitz
import re
import os
import shutil
from glob import glob
from pathlib import Path


def find_files_by_extension(dir_path, extension):
    return glob(os.path.join(dir_path, "*.{}".format(extension)))


def get_file_name_no_extension(path):
    return Path(path).stem


def snake_case(s):
    return '_'.join(
        re.sub('([A-Z][a-z]+)', r' \1',
               re.sub('([A-Z]+)', r' \1',
                      s.replace('-', ' '))).split()).lower()


pdf_file_path = 'test.pdf'
dir_path = 'images'
unprocessed_dir_path = 'unprocessed'
processed_dir_path = 'processed'


def init_dir_paths():
    for path in [dir_path, processed_dir_path, unprocessed_dir_path]:
        if not os.path.exists(path):
            os.mkdir(path)
            print(f'Create directory {path}')


def pdf_to_image_fitz(path, pic_path, minimal_pix_size=10000):
    check_im = r"/Subtype(?= */Image)"
    pdf = fitz.open(path)
    title = get_file_name_no_extension(path)
    len_xref = pdf.xref_length()
    count = 1
    des_path = f"{pic_path}/{title}"
    if not os.path.exists(des_path):
        os.mkdir(des_path)
    for i in range(1, len_xref):
        text = pdf.xref_object(i)
        is_image = re.search(check_im, text)
        if not is_image:
            continue
        pix = fitz.Pixmap(pdf, i)
        if pix.size < minimal_pix_size:
            continue
        new_name = f"img_{count}.png"
        pix.save(os.path.join(des_path, new_name))
        count += 1
        pix = None
    shutil.move(path, processed_dir_path)


init_dir_paths()
unprocessed_pdf_files = find_files_by_extension(unprocessed_dir_path, "pdf")
unprocessed_pdf_files_len = len(unprocessed_pdf_files)
for i in range(unprocessed_pdf_files_len):
    file = unprocessed_pdf_files[i]
    print(f"Start extracting [{file}]({i+1}/{unprocessed_pdf_files_len})")
    pdf_to_image_fitz(file, dir_path)
    print(f"Finish extracting [{file}]")
print(
    f"Finish processing {unprocessed_pdf_files_len} files. These files will be moved to the folder<{processed_dir_path}>")
