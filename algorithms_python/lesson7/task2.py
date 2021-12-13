# Отсортируйте по возрастанию методом слияния одномерный вещественный массив,
# заданный случайными числами на промежутке [0; 50). Выведите на экран исходный и отсортированный массивы.
from random import randint


def sort_merge(numbers: list):
    if len(numbers) < 2:
        return numbers[:]
    else:
        middle = int(len(numbers) / 2)
        left = sort_merge(numbers[:middle])
        right = sort_merge(numbers[middle:])
        return merge(left, right)


def merge(left: list, right: list):
    result = []
    i, j = 0, 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    while i < len(left):
        result.append(left[i])
        i += 1
    while j < len(right):
        result.append(right[j])
        j += 1
    return result


array = [randint(0, 49) for _ in range(15)]
print(array)
print(sort_merge(array))




