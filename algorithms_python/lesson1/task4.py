# Написать программу, которая генерирует в указанных пользователем границах
# случайное целое число,
# случайное вещественное число,
# случайный символ.
# Для каждого из трех случаев пользователь задает свои границы диапазона.
# Например, если надо получить случайный символ от 'a' до 'f', то вводятся эти символы.
# Программа должна вывести на экран любой символ алфавита от 'a' до 'f' включительно.
import random
import string


def get_limit_int_from_input(limit_name: str):
    while True:
        try:
            point = int(input(f'Введите пожалуйста {limit_name} границу диапазона для целого числа: '))
        except ValueError:
            print('Вы ввели не целое число.')
        else:
            break
    return point


def get_limit_float_from_input(limit_name: str):
    while True:
        try:
            point = float(input(f'Введите пожалуйста {limit_name} границу диапазона для вещественного числа: '))
        except ValueError:
            print('Вы ввели не число.')
        else:
            break
    return point


def get_limit_letter_from_input(limit_name: str):
    while True:
        letter = input(f'Введите пожалуйста {limit_name} границу диапазона для случайного символа (одна буква): ')
        if len(letter) > 1 or len(letter) == 0 or not letter.isalpha():
            print('Введите пожалуйста одну букву')
        else:
            break
    return letter


start_text = "начальную"
end_text = "конечную"

limit_int_start = get_limit_int_from_input(start_text)
limit_int_end = get_limit_int_from_input(end_text)
limit_float_start = get_limit_float_from_input(start_text)
limit_float_end = get_limit_float_from_input(end_text)
limit_letter_start = get_limit_letter_from_input(start_text)
limit_letter_end = get_limit_letter_from_input(end_text)

letter_start_index = string.ascii_letters.find(limit_letter_start)
letter_end_index = string.ascii_letters.find(limit_letter_end)
letters = string.ascii_letters[letter_start_index:letter_end_index + 1]

print('случайное целое число:', random.randint(limit_int_start, limit_int_end))
print('случайное вещественное число:', random.uniform(limit_float_start, limit_float_end))
print('случайный символ:', random.choice(letters))
