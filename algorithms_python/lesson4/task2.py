# Написать два алгоритма нахождения i-го по счёту простого числа.
# Без использования «Решета Эратосфена»;
# Используя алгоритм «Решето Эратосфена»

# Проанализировать скорость и сложность алгоритмов. Результаты анализа сохранить в виде комментариев в файле с кодом.
from itertools import count
from math import log, ceil
import cProfile


def is_prime_number(num: int):
    k = 0
    for i in range(2, num // 2 + 1):
        if num % i == 0:
            k += 1
    return k == 0


def get_prime_number(n: int):
    cnt = 0
    for i in count(0):
        if is_prime_number(i):
            cnt += 1
            if cnt == n:
                return i


def get_prime_number_sieve_eratosfen(n: int):
    if n == 1:
        return 0
    if n == 2:
        return 1
    if n == 3:
        return 2
    cnt = 3
    end = ceil(2 * n * log(n))
    last_prime_number = 2
    sieve = [i for i in range(last_prime_number, end)]
    while True:
        sieve = [i for i in sieve if i % last_prime_number]
        last_prime_number = sieve[0]
        cnt += 1
        if cnt == n:
            return last_prime_number


cProfile.run('get_prime_number_sieve_eratosfen(1000)')
cProfile.run('get_prime_number(1000)')

# «Решето Эратосфена»
# сложность алгоритма n * log(log(n))
# ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#         1    0.000    0.000    0.057    0.057 <string>:1(<module>)
#         1    0.002    0.002    0.057    0.057 task2.py:28(get_prime_number_sieve_eratosfen)
#         1    0.000    0.000    0.000    0.000 task2.py:38(<listcomp>)
#       997    0.054    0.000    0.054    0.000 task2.py:40(<listcomp>)
#         1    0.000    0.000    0.057    0.057 {built-in method builtins.exec}
#         1    0.000    0.000    0.000    0.000 {built-in method math.ceil}
#         1    0.000    0.000    0.000    0.000 {built-in method math.log}
#         1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}


# Без использования «Решета Эратосфена»
# сложность алгоритма n ** 2
# ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#         1    0.000    0.000    0.887    0.887 <string>:1(<module>)
#      7902    0.885    0.000    0.885    0.000 task2.py:11(is_prime_number)
#         1    0.002    0.002    0.887    0.887 task2.py:19(get_prime_number)
#         1    0.000    0.000    0.887    0.887 {built-in method builtins.exec}
#         1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
