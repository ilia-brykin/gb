# Вводятся три разных числа. Найти, какое из них является средним (больше одного, но меньше другого).

def get_int_from_input():
    while True:
        try:
            number = int(input('Введите пожалуйста целое число: '))
        except ValueError:
            print('Вы ввели не целое число.')
        else:
            break
    return number


def middle_of_three(a: int, b: int, c: int):
    if a <= b <= c or c <= b <= a:
        return b
    if b <= a <= c or c <= a <= b:
        return a
    return c


number1 = get_int_from_input()
number2 = get_int_from_input()
number3 = get_int_from_input()

print('среднее число', middle_of_three(number1, number2, number3))
