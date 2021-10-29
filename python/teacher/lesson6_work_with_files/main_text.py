import csv
import pandas as pd

# file_test = open('text.txt', 'r', encoding='utf-8')
# data = file_test.read()
# print(data)
# file_test.close()
"""
r - read режим только чтение
r+ - режим редактора, каретка в начале
a - режим открытия файла на дозапись (каретка стоит в конце файла)
w - стирает все данные из существующего файла и записывает новые. (файла нет - создает, файл есть - стирает данные)
a+ - ывает на дозапись, но еще и можем считывать данные
w+ - стирает все данные и уже записанные данные можно записать в заголовок.
x - запись текста, когда файла нет. Если файл существует - выдает ошибку.
b -  работы с бинарными файлами.
"""
year = 1921
data_to_write = ['В.Маяковский', f'\n{year}\n']
with open('text_test.txt', 'r+', encoding='utf-8') as f:
    # print(f.tell())
    # f.seek(0)
    print(f.tell())
    # f.writelines(data_to_write)
    print(f.tell())

with open('text_test.txt', 'r', encoding='utf-8') as f:
    print(f.tell())
    data = f.read()
    print(f.tell())

with open('text.txt', 'r', encoding='utf-8') as f_r, open('text_test.txt', 'w', encoding='utf-8') as f_w:
    # f_w.writelines(data_to_write)
    data = f_r.read()
    f_w.write(data)

with open('text.txt', 'r', encoding='utf-8') as f_r:
    data = f_r.read()

with open('new_text.txt', 'w+', encoding='utf-8') as f:
    f.writelines(data_to_write)
    f.write(data)
    f.seek(0)
    print(f.read())

with open('train.csv', 'r') as f:
    data = csv.reader(f)

    # for line in data:
    #     print(line)

df = pd.read_csv('train.csv')
print(df.head())