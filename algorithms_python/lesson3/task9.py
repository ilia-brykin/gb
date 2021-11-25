# Найти максимальный элемент среди минимальных элементов столбцов матрицы.

from random import choice, randint

cols_count = randint(4, 90)
row_count = randint(4, 90)
matrix = []
matrix_new = []
min_list = []

for item in range(row_count):
    matrix.append([choice(range(100)) for a in range(cols_count)])

for _ in range(cols_count):
    matrix_new.append([])

for row in matrix:
    for index, item in enumerate(row):
        matrix_new[index].append(item)

for item in matrix_new:
    min_list.append(min(item))

print(max(min_list))
