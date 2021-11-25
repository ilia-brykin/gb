# В одномерном массиве целых чисел определить два наименьших элемента.
# Они могут быть как равны между собой (оба являться минимальными), так и различаться.

from random import choice

list_of_integers = [choice(range(10)) for i in range(20)]

min_value1 = min(list_of_integers)
min_value2 = 11
min_index1 = None
min_index2 = None
print(list_of_integers)

for index, item in enumerate(list_of_integers):
    if item == min_value1:
        if min_index1 is None:
            min_index1 = index
        else:
            min_value2 = min_value1
            min_index2 = index
            break
    if min_value1 < item < min_value2:
        min_value2 = item
        min_index2 = index

print(f'First min: index {min_index1}, value {min_value1}')
print(f'Second min: index {min_index2}, value {min_value2}')

