# Отсортируйте по убыванию методом "пузырька" одномерный целочисленный массив,
# заданный случайными числами на промежутке [-100; 100).
# Выведите на экран исходный и отсортированный массивы.
# Сортировка должна быть реализована в виде функции. По возможности доработайте алгоритм (сделайте его умнее).

from random import randint


def sort_desc(arr: list):
    numbers = arr
    max_index = len(numbers) - 1
    n = max_index
    while n >= 0:
        n -= 1
        for i in range(max_index, max_index - n - 2, -1):
            if numbers[i] > numbers[i - 1]:
                numbers[i], numbers[i - 1] = numbers[i - 1], numbers[i]
    return numbers


array = [randint(-100, 99) for _ in range(15)]
print(array)
print(sort_desc(array))
