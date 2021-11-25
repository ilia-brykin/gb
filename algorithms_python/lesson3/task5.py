# В массиве найти максимальный отрицательный элемент. Вывести на экран его значение и позицию в массиве.

import random

list_of_integers = [random.choice(range(-100, 100)) for i in range(20)]
print(list_of_integers)

max_negative_element = -101
max_negative_index = -1

for index, item in enumerate(list_of_integers):
    if max_negative_element < item < 0:
        max_negative_element = item
        max_negative_index = index

print(f'value: {max_negative_element}, index: {max_negative_index}')
