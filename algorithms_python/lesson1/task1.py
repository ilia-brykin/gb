# Найти сумму и произведение цифр трехзначного числа, которое вводит пользователь.
while True:
    try:
        number_from_input = int(input('Введите пожалуйста трехзначное число: '))
    except ValueError:
        print('Вы ввели не целое число.')
    else:
        if 99 < number_from_input < 1000:
            break

summ_of_digits = 0
product_of_digits = 1
for i in range(3):
    number = number_from_input % 10
    summ_of_digits += number
    product_of_digits *= number
    number_from_input //= 10

print(f'Сумма равна: {summ_of_digits}')
print(f'Произведение равно: {product_of_digits}')

