def odd_nums_generator(max_num):
    return (number for number in range(1, max_num + 1, 2))


odd_nums = odd_nums_generator(15)

print(next(odd_nums))
print(next(odd_nums))
print(next(odd_nums))
print(next(odd_nums))
print(next(odd_nums))
print(next(odd_nums))
print(next(odd_nums))
print(next(odd_nums))
