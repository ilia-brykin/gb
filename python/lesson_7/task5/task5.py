import os
import json


def get_size_group(size: int):
    if size == 0:
        return '0'

    size_str = str(size)
    size_len = len(size_str)
    if size_len == 1:
        return '10'
    max_size = '1'.ljust(size_len - 1, '0')
    if size_str == max_size:
        return max_size
    else:
        return '1'.ljust(size_len, '0')


PATH = '../../../gb_python'
FILES = {}
JSON = {}

for root, dirs, files in os.walk(PATH):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.stat(file_path).st_size
        extension = os.path.splitext(file)[1]
        size_group = get_size_group(file_size)
        if size_group in FILES:
            FILES[size_group]['count'] += 1
            FILES[size_group]['extensions'][extension] = True
        else:
            FILES[size_group] = {
                'count': 1,
                'extensions': {
                    extension: True
                },
            }

for key, item in FILES.items():
    extensions = []
    for extension in item['extensions']:
        extensions.append(extension)
    JSON[key] = (item['count'], extensions)

CURRENT_DIR_NAME = os.path.split(os.getcwd())[1]
with open(f'{CURRENT_DIR_NAME}_summary.json', 'w') as f:
    json.dump(JSON, f)
