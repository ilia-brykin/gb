# В массиве случайных целых чисел поменять местами минимальный и максимальный элементы.

from random import sample

max_value = -1
min_value = 101
list_of_integers = sample(range(0, 100), 100)
list_of_integers_new = []

for item in list_of_integers:
    if item > max_value:
        max_value = item
    if item < min_value:
        min_value = item

for item in list_of_integers:
    if item == max_value:
        list_of_integers_new.append(min_value)
    elif item == min_value:
        list_of_integers_new.append(max_value)
    else:
        list_of_integers_new.append(item)

print("before list_of_integers", list_of_integers)
list_of_integers = list_of_integers_new
print("after list_of_integers", list_of_integers)
