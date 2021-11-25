# В диапазоне натуральных чисел от 2 до 99 определить, сколько из них кратны каждому из чисел в диапазоне от 2 до 9.

multiples_obj = {}
for i in range(2, 10):
    multiples_obj[i] = 0

for i in range(2, 100):
    for j in range(2, 10):
        if i % j == 0:
            multiples_obj[j] += 1

print(multiples_obj)
