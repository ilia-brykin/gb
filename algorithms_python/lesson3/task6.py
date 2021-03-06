# В одномерном массиве найти сумму элементов, находящихся между минимальным и максимальным элементами.
# Сами минимальный и максимальный элементы в сумму не включать.
from random import sample


def get_sum_between_min_max():
    list_of_integers = sample(range(0, 100000), 100000)
    max_value = -1
    min_value = 101
    max_index = -1
    min_index = -1

    for index, item in enumerate(list_of_integers):
        if item > max_value:
            max_value = item
            max_index = index
        if item < min_value:
            min_value = item
            min_index = index

    index_first = min_index
    index_last = max_index
    if max_index < min_index:
        index_first = max_index
        index_last = min_index
    return sum(list_of_integers[index_first + 1:index_last])


if __name__ == '__main__':
    print(get_sum_between_min_max())
