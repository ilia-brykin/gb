# Написать программу, которая будет складывать, вычитать, умножать или делить два числа.
# Числа и знак операции вводятся пользователем. После выполнения вычисления программа не должна завершаться,
# а должна запрашивать новые данные для вычислений. Завершение программы должно выполняться
# при вводе символа '0' в качестве знака операции. Если пользователь вводит неверный знак (не '0', '+', '-', '*', '/'),
# то программа должна сообщать ему об ошибке и снова запрашивать знак операции.
# Также сообщать пользователю о невозможности деления на ноль, если он ввел 0 в качестве делителя.

while True:
    expression = input('Введите математическое выражение: ')
    expression_list = expression.split()
    number_first = int(expression_list[0])
    character = expression_list[1]
    number_last = int(expression_list[2])

    if character == '0':
        break
    elif character == '+':
        print(f'{expression} = {number_first + number_last}')
    elif character == '-':
        print(f'{expression} = {number_first - number_last}')
    elif character == '*':
        print(f'{expression} = {number_first * number_last}')
    elif character == '/':
        if number_last == 0:
            print('Невозможно разделить на ноль ')
        else:
            print(f'{expression} = {number_first / number_last}')
    else:
        print('Вы ввели недопустимый символ ')
