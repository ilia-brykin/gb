# Написать программу сложения и умножения двух шестнадцатеричных чисел.
# При этом каждое число представляется как массив, элементы которого это цифры числа.
# Например, пользователь ввёл A2 и C4F. Сохранить их как [‘A’, ‘2’] и [‘C’, ‘4’, ‘F’] соответственно.
# Сумма чисел из примера: [‘C’, ‘F’, ‘1’], произведение - [‘7’, ‘C’, ‘9’, ‘F’, ‘E’].

import random


def get_random_hex_number():
    random_number = random.randint(0, 16777215)
    hex_number = str(hex(random_number))
    return hex_number[2:]


a = list(get_random_hex_number())
b = list(get_random_hex_number())

a_number = int(''.join(a), 16)
b_number = int(''.join(b), 16)

sum_numbers = list(hex(a_number + b_number)[2:])
product_numbers = list(hex(a_number * b_number)[2:])

print(f'number one {a}, number two {b}')
print(f'Сумма чисел {sum_numbers}')
print(f'произведение чисел {product_numbers}')
