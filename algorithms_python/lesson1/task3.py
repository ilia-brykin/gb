# По введенным пользователем координатам двух точек вывести уравнение прямой вида
# y = kx + b, проходящей через эти точки.


def get_point_from_input(coordinate: str, point_name: str):
    while True:
        try:
            point = float(input(f'Введите пожалуйста {coordinate}-координату {point_name} точки: '))
        except ValueError:
            print('Вы ввели не число.')
        else:
            break
    return point


x1 = get_point_from_input('X', 'первой')
y1 = get_point_from_input('Y', 'первой')
x2 = get_point_from_input('X', 'второй')
y2 = get_point_from_input('Y', 'второй')

k = (y2 - y1) / (x2 - x1)
b = y1 - k * x1
equation = 'y ='
if k != 0:
    equation += f' {k}x'
if b > 0:
    equation += f' + {b}'
elif b < 0:
    equation += f' - {b * -1}'

print('уравнение прямой проходящей через точки:')
print(equation)
