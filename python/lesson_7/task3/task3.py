import os
from shutil import copy2


def create_folder(path: str):
    if not os.path.exists(path):
        os.mkdir(path)


def copy_html_files(files_local: list, path_target: str, path_source: str):
    for file in files_local:
        if file.endswith('.html'):
            file_path_source = os.path.join(path_source, file)
            file_path_target = os.path.join(path_target, file)
            copy2(file_path_source, file_path_target)


MAIN_PATH = r'../task2/my_project'
TEMPLATES_DIR_NAME = 'templates'
TEMPLATES_PATH = os.path.join(MAIN_PATH, TEMPLATES_DIR_NAME)
if not os.path.exists(TEMPLATES_PATH):
    os.mkdir(TEMPLATES_PATH)

for root, dirs, files in os.walk(MAIN_PATH):
    if root.startswith(TEMPLATES_PATH):  # my_project/templates and children
        continue
    if os.path.dirname(root).endswith(TEMPLATES_DIR_NAME):
        dir_name = os.path.basename(root)
        full_path = os.path.join(TEMPLATES_PATH, dir_name)
        create_folder(full_path)
        copy_html_files(files, full_path, root)

