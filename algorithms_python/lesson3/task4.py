# Определить, какое число в массиве встречается чаще всего.
import random

count_integers = {}
list_of_integers = [random.choice(range(10)) for i in range(20)]
print(list_of_integers)
for item in list_of_integers:
    if count_integers.get(item) is None:
        count_integers[item] = 0
    count_integers[item] += 1

print(max(count_integers, key=count_integers.get))
