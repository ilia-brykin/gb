#  Во втором массиве сохранить индексы четных элементов первого массива.
#  Например, если дан массив со значениями 8, 3, 15, 6, 4, 2,
#  то во второй массив надо заполнить значениями 1, 4, 5, 6
#  (или 0, 3, 4, 5 - если индексация начинается с нуля),
#  т.к. именно в этих позициях первого массива стоят четные числа.

from random import sample, randint

list_of_integers = sample(range(1, 100), randint(1, 100))
list_of_keys = [index for index, item in enumerate(list_of_integers) if item % 2 == 0]
print('list_of_integers', list_of_integers)
print('list_of_keys', list_of_keys)
