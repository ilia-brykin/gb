import json
import os


def read_element(element, path: str = ''):
    if type(element) == str:
        create_folder(element, path)
    elif type(element) == dict:
        folder_name = element.get('name')
        create_folder(folder_name, path)
        if 'children' in element and len(element['children']):
            path = os.path.join(path, folder_name)
            for child in element['children']:
                read_element(child, path)


def create_folder(name: str, path: str):
    full_path = os.path.join(path, name)
    if not os.path.exists(full_path):
        os.mkdir(full_path)


with open('config.json') as f:
    CONFIG = json.load(f)


for item in CONFIG:
    read_element(item)
