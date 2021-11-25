# Матрица 5x4 заполняется вводом с клавиатуры кроме последних элементов строк.
# Программа должна вычислять сумму введенных элементов каждой строки и записывать ее в последнюю ячейку строки.
# В конце следует вывести полученную матрицу.
from random import choice

list_of_integers = []

matrix = [
    [choice(range(100)) for a in range(4)],
    [choice(range(100)) for b in range(4)],
    [choice(range(100)) for c in range(4)],
    [choice(range(100)) for d in range(4)],
]

for item in matrix:
    item += [sum(item)]
print(matrix)
