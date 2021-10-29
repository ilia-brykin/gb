from time import perf_counter
import numpy as np

def print_stars(func):
    print('Welcome to print stars')
    def wrapper(*args):
        print('Welcome to wrapper')
        print('*******************')
        func(*args)
        print('*******************')
    return wrapper


def bench_time_iter(iter_num):
    def bench_time(func):
        def wrapper(*args, **kwargs):
            res_mean = []
            for _ in range(iter_num):
                start = perf_counter()
                res = func(*args, **kwargs)
                finish = perf_counter()
                res_mean.append(finish - start)
            print(f'Time of func {np.array(res_mean).mean()}')
            return res
        return wrapper
    return bench_time

@bench_time_iter(5)
def print_kitten():
    print('Kitten')

@bench_time_iter(5)
@print_stars
def pow_list(data_list):
    print('list in process')
    return [el ** 2 for el in data_list]

@print_stars
def print_puppy():
    print('Puppy')


print_kitten()

pow_list(list(range(10,200)))

