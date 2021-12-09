# Подсчитать, сколько было выделено памяти под переменные в ранее разработанных программах в рамках первых трех уроков.
# Проанализировать результат и определить программы с наиболее эффективным использованием памяти.
# Примечание: Для анализа возьмите любые 1-3 ваших программы или несколько вариантов кода для одной и той же задачи.
# Результаты анализа вставьте в виде комментариев к коду.
# Также укажите в комментариях версию Python и разрядность вашей ОС.

from memory_profiler import profile


@profile
def get_prime_number_sieve_eratosfen(n: int):
    from math import log, ceil

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


if __name__ == '__main__':
    get_prime_number_sieve_eratosfen(100)

# Line #    Mem usage    Increment  Occurrences   Line Contents
# =============================================================
#     10     18.2 MiB     18.2 MiB           1   @profile
#     11                                         def get_prime_number_sieve_eratosfen(n: int):
#     12     18.2 MiB      0.0 MiB           1       from math import log, ceil
#     13
#     14     18.2 MiB      0.0 MiB           1       if n == 1:
#     15                                                 return 0
#     16     18.2 MiB      0.0 MiB           1       if n == 2:
#     17                                                 return 1
#     18     18.2 MiB      0.0 MiB           1       if n == 3:
#     19                                                 return 2
#     20     18.2 MiB      0.0 MiB           1       cnt = 3
#     21     18.2 MiB      0.0 MiB           1       end = ceil(2 * n * log(n))
#     22     18.2 MiB      0.0 MiB           1       last_prime_number = 2
#     23     18.2 MiB      0.0 MiB         923       sieve = [i for i in range(last_prime_number, end)]
#     24                                             while True:
#     25     18.2 MiB      0.0 MiB       12314           sieve = [i for i in sieve if i % last_prime_number]
#     26     18.2 MiB      0.0 MiB          97           last_prime_number = sieve[0]
#     27     18.2 MiB      0.0 MiB          97           cnt += 1
#     28     18.2 MiB      0.0 MiB          97           if cnt == n:
#     29     18.2 MiB      0.0 MiB           1               return last_prime_number


# Python 3.9 ОС 64
