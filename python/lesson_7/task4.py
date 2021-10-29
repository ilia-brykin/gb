import os


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


PATH = '../../gb_python'
FILES_SIZES = {}

for root, dirs, files in os.walk(PATH):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.stat(file_path).st_size
        size_group = get_size_group(file_size)
        if size_group in FILES_SIZES:
            FILES_SIZES[size_group] += 1
        else:
            FILES_SIZES[size_group] = 1

print(FILES_SIZES)
# {'10': 70, '100': 365, '1000': 875, '10000': 408, '10000000': 3, '100000': 36, '0': 39, '1000000': 2}
