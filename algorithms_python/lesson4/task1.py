# Проанализировать скорость и сложность одного любого алгоритма,
# разработанных в рамках практического задания первых трех уроков.
#
# Примечание: попробуйте написать несколько реализаций алгоритма и сравнить их.

# Проанализировать скорость и сложность алгоритмов. Результаты анализа сохранить в виде комментариев в файле с кодом.

# В одномерном массиве найти сумму элементов, находящихся между минимальным и максимальным элементами.
# Сами минимальный и максимальный элементы в сумму не включать.

from algorithms_python.lesson3.task6 import get_sum_between_min_max
import cProfile
from random import sample


def get_sum_between_min_max_v2():
    list_of_integers = sample(range(0, 100000), 100000)
    index_first = list_of_integers.index(max(list_of_integers))
    index_last = list_of_integers.index(min(list_of_integers))
    print(index_first, index_last)
    if index_last < index_first:
        index_first, index_last = index_last, index_first
    return sum(list_of_integers[index_first + 1:index_last])


cProfile.run('get_sum_between_min_max()')
cProfile.run('get_sum_between_min_max_v2()')

# сложность алгоритмов O(n)
# первый алгоритм немного быстрее второго

# get_sum_between_min_max 0.084 seconds
# ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#         1    0.001    0.001    0.084    0.084 <string>:1(<module>)
#         1    0.000    0.000    0.000    0.000 _collections_abc.py:302(__subclasshook__)
#         6    0.000    0.000    0.000    0.000 _collections_abc.py:392(__subclasshook__)
#       7/2    0.000    0.000    0.000    0.000 abc.py:100(__subclasscheck__)
#         2    0.000    0.000    0.000    0.000 abc.py:96(__instancecheck__)
#    100000    0.030    0.000    0.043    0.000 random.py:250(_randbelow_with_getrandbits)
#         1    0.032    0.032    0.075    0.075 random.py:315(sample)
#         1    0.008    0.008    0.083    0.083 task6.py:6(get_sum_between_min_max)
#         2    0.000    0.000    0.000    0.000 {built-in method _abc._abc_instancecheck}
#       7/2    0.000    0.000    0.000    0.000 {built-in method _abc._abc_subclasscheck}
#         1    0.000    0.000    0.084    0.084 {built-in method builtins.exec}
#         2    0.000    0.000    0.000    0.000 {built-in method builtins.isinstance}
#         1    0.000    0.000    0.000    0.000 {built-in method builtins.len}
#         1    0.000    0.000    0.000    0.000 {built-in method builtins.sum}
#         1    0.000    0.000    0.000    0.000 {built-in method math.ceil}
#         1    0.000    0.000    0.000    0.000 {built-in method math.log}
#    100000    0.005    0.000    0.005    0.000 {method 'bit_length' of 'int' objects}
#         1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
#    146368    0.008    0.000    0.008    0.000 {method 'getrandbits' of '_random.Random' objects}

# get_sum_between_min_max_v2 0.087 seconds
# ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#         1    0.001    0.001    0.087    0.087 <string>:1(<module>)
#         1    0.000    0.000    0.000    0.000 _collections_abc.py:302(__subclasshook__)
#         1    0.000    0.000    0.000    0.000 abc.py:100(__subclasscheck__)
#         2    0.000    0.000    0.000    0.000 abc.py:96(__instancecheck__)
#    100000    0.034    0.000    0.049    0.000 random.py:250(_randbelow_with_getrandbits)
#         1    0.032    0.032    0.081    0.081 random.py:315(sample)
#         1    0.000    0.000    0.086    0.086 task1.py:16(get_sum_between_min_max_v2)
#         2    0.000    0.000    0.000    0.000 {built-in method _abc._abc_instancecheck}
#         1    0.000    0.000    0.000    0.000 {built-in method _abc._abc_subclasscheck}
#         1    0.000    0.000    0.087    0.087 {built-in method builtins.exec}
#         2    0.000    0.000    0.000    0.000 {built-in method builtins.isinstance}
#         1    0.000    0.000    0.000    0.000 {built-in method builtins.len}
#         1    0.002    0.002    0.002    0.002 {built-in method builtins.max}
#         1    0.001    0.001    0.001    0.001 {built-in method builtins.min}
#         1    0.000    0.000    0.000    0.000 {built-in method builtins.print}
#         1    0.000    0.000    0.000    0.000 {built-in method builtins.sum}
#         1    0.000    0.000    0.000    0.000 {built-in method math.ceil}
#         1    0.000    0.000    0.000    0.000 {built-in method math.log}
#    100000    0.005    0.000    0.005    0.000 {method 'bit_length' of 'int' objects}
#         1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
#    146151    0.010    0.000    0.010    0.000 {method 'getrandbits' of '_random.Random' objects}
#         2    0.001    0.001    0.001    0.001 {method 'index' of 'list' objects}


