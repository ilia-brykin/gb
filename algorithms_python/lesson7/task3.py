# Массив размером 2m + 1, где m – натуральное число, заполнен случайным образом.
# Найдите в массиве медиану. Медианой называется элемент ряда, делящий его на две равные части:
# в одной находятся элементы, которые не меньше медианы, в другой – не больше медианы.
# Задачу можно решить без сортировки исходного массива. Но если это слишком сложно, то используйте метод сортировки,
# который не рассматривался на уроках

from random import randint, choice
from statistics import median


def get_median(numbers):
    return select(numbers, len(numbers) / 2)


def select(numbers, k):
    if len(numbers) == 1:
        return numbers[0]

    pivot = choice(numbers)

    lows = [el for el in numbers if el < pivot]
    highs = [el for el in numbers if el > pivot]
    pivots = [el for el in numbers if el == pivot]

    if k < len(lows):
        return select(lows, k)
    elif k < len(lows) + len(pivots):
        return pivots[0]
    else:
        return select(highs, k - len(lows) - len(pivots))


array = [randint(0, 99) for _ in range(15)]
print(array)
print(median(array))
print(get_median(array))
