DEGREES_THREE = []
sum1 = 0
sum2 = 0

for i in range(1, 1000, 2):
    DEGREES_THREE.append(i ** 3)

print(DEGREES_THREE)


def is_sum_of_digits_multiple_seven(number):
    current_sum = 0
    for symbol in str(number):
        current_sum += int(symbol)
    return current_sum % 7 == 0


for item in DEGREES_THREE:
    if is_sum_of_digits_multiple_seven(item):
        sum1 += item

print(sum1)

for index in range(len(DEGREES_THREE)):
    DEGREES_THREE[index] += 17
    if is_sum_of_digits_multiple_seven(DEGREES_THREE[index]):
        sum2 += DEGREES_THREE[index]

print(DEGREES_THREE)
print(sum2)
