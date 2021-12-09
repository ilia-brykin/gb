# Подсчитать, сколько было выделено памяти под переменные в ранее разработанных программах в рамках первых трех уроков.
# Проанализировать результат и определить программы с наиболее эффективным использованием памяти.
# Примечание: Для анализа возьмите любые 1-3 ваших программы или несколько вариантов кода для одной и той же задачи.
# Результаты анализа вставьте в виде комментариев к коду.
# Также укажите в комментариях версию Python и разрядность вашей ОС.

from memory_profiler import profile

@profile
def get_max_min_from_matrix():
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


if __name__ == '__main__':
    get_max_min_from_matrix()

# Line #    Mem usage    Increment  Occurrences   Line Contents
# =============================================================
#      9     18.5 MiB     18.5 MiB           1   @profile
#     10                                         def get_max_min_from_matrix():
#     11     18.6 MiB      0.2 MiB           1       from random import choice, randint
#     12
#     13     18.6 MiB      0.0 MiB           1       cols_count = randint(4, 90)
#     14     18.6 MiB      0.0 MiB           1       row_count = randint(4, 90)
#     15     18.6 MiB      0.0 MiB           1       matrix = []
#     16     18.6 MiB      0.0 MiB           1       matrix_new = []
#     17     18.6 MiB      0.0 MiB           1       min_list = []
#     18
#     19     18.6 MiB      0.0 MiB          27       for item in range(row_count):
#     20     18.6 MiB      0.0 MiB        1222           matrix.append([choice(range(100)) for a in range(cols_count)])
#     21
#     22     18.6 MiB      0.0 MiB          45       for _ in range(cols_count):
#     23     18.6 MiB      0.0 MiB          44           matrix_new.append([])
#     24
#     25     18.6 MiB      0.0 MiB          27       for row in matrix:
#     26     18.6 MiB      0.0 MiB        1170           for index, item in enumerate(row):
#     27     18.6 MiB      0.0 MiB        1144               matrix_new[index].append(item)
#     28
#     29     18.6 MiB      0.0 MiB          45       for item in matrix_new:
#     30     18.6 MiB      0.0 MiB          44           min_list.append(min(item))
#     31
#     32     18.6 MiB      0.0 MiB           1       print(max(min_list))


# Python 3.9 ОС 64
