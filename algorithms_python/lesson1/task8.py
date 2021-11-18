# Определить, является ли год, который ввел пользователем, високосным или невисокосным.
# год является високосным в двух случаях: либо он кратен 4, но при этом не кратен 100, либо кратен 400.

def get_year_from_input():
    while True:
        try:
            year = int(input('Введите пожалуйста год, начиная с 0: '))
        except ValueError:
            print('Вы ввели не целое число.')
        else:
            if year >= 0:
                break
    return year


user_year = get_year_from_input()
if not user_year % 400 or (not user_year % 4 and user_year % 100):
    print('год високосный')
else:
    print('год невисокосный')
