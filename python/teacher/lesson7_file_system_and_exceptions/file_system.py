import os
import shutil
import datetime

for i in range(1, 25):
    with open(f'{(i % 3)}_{i}.txt', 'w') as f:
        f.write(str(i ** (i % 3)))

for i in range(25, 50):
    with open(f'{(i % 3)}_{i}.csv', 'w') as f:
        f.write(str(i ** (i % 3)))

for i in range(50, 75):
    with open(f'{(i % 3)}_{i}.png', 'w') as f:
        f.write(str(i ** (i % 3)))

files = os.listdir()
# print(files)

# shutil.rmtree('data')
#
CURRENT_PATH = os.getcwd()
CSV_PATH = os.path.join('data','csv')
TXT_PATH = os.path.join('data','txt')
TXT_PATH_COPY = os.path.join('data','txt_copy')
PNG_PATH = os.path.join('data','png')

print(os.path.exists(PNG_PATH))

print(CURRENT_PATH)
csv_data = os.path.join('data','csv')
print(os.path.join(CURRENT_PATH, csv_data))
print(os.path.abspath('data'))

os.makedirs(CSV_PATH, exist_ok=True)
os.makedirs(TXT_PATH, exist_ok=True)
os.makedirs(PNG_PATH, exist_ok=True)
os.makedirs(TXT_PATH_COPY, exist_ok=True)

for file in files:
    if file.endswith('.txt'):
        os.replace(file, os.path.join(TXT_PATH, file))
    if file.endswith('.png'):
        os.rename(file, os.path.join(PNG_PATH, file))
    if file.endswith('.csv'):
        os.replace(file, os.path.join(CSV_PATH, file))


files_scandirs = os.scandir(TXT_PATH)
print(dir(next(files_scandirs)))
test_file_scandir = next(files_scandirs)
print(test_file_scandir.name)
scandir_stat = test_file_scandir.stat()
print(oct(scandir_stat.st_mode)[-3:])
print(datetime.datetime.fromtimestamp(scandir_stat.st_atime))
print(datetime.datetime.fromtimestamp(scandir_stat.st_mtime))
print(scandir_stat.st_size)

print(os.stat(os.path.abspath('data')))

for file_data in os.scandir(TXT_PATH):
    if os.path.isfile(os.path.join(TXT_PATH, file_data.name)) and file_data.stat().st_size > 1:
        shutil.copy2(os.path.join(TXT_PATH, file_data.name), os.path.join(TXT_PATH_COPY, file_data.name))


# print(os.stat(os.path.join(TXT_PATH, '1_10.txt')))
# print(os.stat(os.path.join(TXT_PATH_COPY, '1_10.txt')))

# shutil.move(TXT_PATH_COPY, os.path.join(TXT_PATH, 'txt_copy'))
# print(TXT_PATH_COPY, os.path.join(TXT_PATH, 'txt_copy'))

res_files = [res[2] for res in os.walk('data') if res[2] != []]
print(res_files)
print("###########################################")
for root_dir, list_dir, files in os.walk('data'):
    print("###########################################\n")
    print(root_dir, list_dir, files)




