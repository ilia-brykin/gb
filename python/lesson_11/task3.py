class OnlyNumbers(Exception):
    def __init__(self, text):
        super().__init__(f'{text} не является числом ')


def check_number(user_input_local):
    try:
        user_input_local = int(user_input_local)
    except ValueError:
        raise OnlyNumbers(user_input_local)
    else:
        return user_input_local


numbers = []
while True:
    user_input = input('Введите число, Для завершения ввода введите: stop ')
    if user_input == 'stop':
        break
    try:
        user_input = check_number(user_input)
    except OnlyNumbers as er:
        print(er)
    except Exception as e:
        print(f'global error: {e}')
    else:
        numbers.append(user_input)

print(numbers)
