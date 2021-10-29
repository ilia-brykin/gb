import sys
import random
from itertools import islice

def gen_nums(n, num_itter: int):
    for i in range(num_itter):
        r_pow = random.randint(1, 100)
        yield (r_pow, n**r_pow)

big_numbers = [i**(int(i/100))for i in range(1000, 15000)]
big_numbers_gen = (i**(int(i/100))for i in range(1000, 15000))

print(sys.getsizeof(big_numbers))
print(sys.getsizeof(big_numbers_gen))
# print(next(big_numbers_gen))
# print(next(big_numbers_gen))

for el in big_numbers_gen:
    pass
print('Print gen again')

big_numbers_gen = (i**(int(i/100))for i in range(1000, 15000))
# for _ in range(10):
#     print(next(big_numbers_gen))

pow_gen = gen_nums(2, 10)

# print(list(islice(pow_gen, 4)))
print(list(pow_gen))
# for el in pow_gen:
#     print(el)

