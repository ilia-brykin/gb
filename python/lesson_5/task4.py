from time import perf_counter

src = [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55]

# A
time_start = perf_counter()
result = []
for index, number in enumerate(src):
    if index < len(src) - 1 and number < src[index + 1]:
        result.append(src[index + 1])
print(perf_counter() - time_start)
print(result)

# B обычно быстрее, но не всегда
time_start = perf_counter()
result2 = [src[index + 1] for index, number in enumerate(src) if index < len(src) - 1 and number < src[index + 1]]
print(perf_counter() - time_start)
print(result2)
