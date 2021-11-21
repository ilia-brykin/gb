# Среди натуральных чисел, которые были введены, найти наибольшее по сумме цифр.
# Вывести на экран это число и сумму его цифр.

def get_sum_of_digits(num: str):
    sum_of_digits = 0
    for digit in num:
        sum_of_digits += int(digit)
    return sum_of_digits


numbers = input('Введите числа через пробел: ').split()
print(numbers)
sum_max = 0
number_max = 0

for item in numbers:
    summ_current = get_sum_of_digits(item)
    if summ_current > sum_max:
        sum_max = summ_current
        number_max = item

print(f'наибольшее число по сумме цифр: {number_max}, сумма цифр: {sum_max}')
