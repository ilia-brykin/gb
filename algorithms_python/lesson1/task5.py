# Пользователь вводит две буквы. Определить, на каких местах алфавита они стоят и
# сколько между ними находится букв.
import string


def get_letters_from_input():
    while True:
        letters = input('Введите пожалуйста две буквы: ')
        if len(letters) == 2 and letters.isalpha():
            break
    return letters


letters_from_input = get_letters_from_input()
letter_first_index = string.ascii_letters.find(letters_from_input[0])
letter_second_index = string.ascii_letters.find(letters_from_input[1])
number_of_letters = abs(letter_second_index - letter_first_index - 1)
print(f'Буква {letters_from_input[0]} стоит на месте номер {letter_first_index + 1} в алфавите')
print(f'Буква {letters_from_input[1]} стоит на месте номер {letter_second_index + 1} в алфавите')
print('Количество букв между ними:', number_of_letters)
