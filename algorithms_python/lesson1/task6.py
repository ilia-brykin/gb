# Пользователь вводит номер буквы в алфавите. Определить, какая это буква.
import string


def get_index_from_input():
    while True:
        try:
            index = int(input('Введите пожалуйста номер буквы в алфавите (от 1 до 52): '))
        except ValueError:
            print('Вы ввели не целое число.')
        else:
            if 0 < index < 53:
                break
    return index - 1


letter_index = get_index_from_input()
print('Это буква:', string.ascii_letters[letter_index])
