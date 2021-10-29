import os


# Вот другой вариант
def get_size_group(size: int):
    degree = 0
    while size != 0:
        size = size // 10
        degree += 1
    if degree == 0:  # если размер файла равен 0 бит
        return 0
    return 10 ** degree


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
