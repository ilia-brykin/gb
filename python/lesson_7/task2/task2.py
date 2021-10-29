import yaml
import os


def read_config_element(element, path: str = ''):
    if type(element) == dict:
        folder_name = element.get('dir')
        full_path = os.path.join(path, folder_name)
        create_folder(full_path)
        folders_key = 'dirs'
        files_key = 'files'
        if folders_key in element and len(element[folders_key]):
            path = os.path.join(path, folder_name)
            for child in element[folders_key]:
                read_config_element(child, path)
        if files_key in element and len(element[files_key]):
            create_files(element[files_key], full_path)


def create_folder(path):
    if not os.path.exists(path):
        os.mkdir(path)


def create_files(files: list, path: str):
    for file in files:
        file_path = os.path.join(path, file)
        if not os.path.exists(file_path):
            with open(file_path, 'w'):
                pass


with open('config.yaml') as f:
    CONFIG = yaml.full_load(f)

print(CONFIG)

read_config_element(CONFIG)
