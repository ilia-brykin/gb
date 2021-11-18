# По длинам трех отрезков, введенных пользователем, определить возможность существования треугольника,
# составленного из этих отрезков. Если такой треугольник существует, то определить,
# является ли он разносторонним, равнобедренным или равносторонним.

# Треугольник существует только тогда, когда сумма любых двух его сторон больше третьей.

def get_segment_from_input(segment_name: str):
    while True:
        try:
            segment_length = int(input(f'Введите пожалуйста длину {segment_name} отрезка (целое положительное число): '))
        except ValueError:
            print('Вы ввели не целое число.')
        else:
            if segment_length > 0:
                break
    return segment_length


segment1 = get_segment_from_input('первого')
segment2 = get_segment_from_input('второго')
segment3 = get_segment_from_input('третьего')

if segment1 < segment2 + segment3 and segment2 < segment1 + segment3 and segment3 < segment1 + segment2:
    print('Треугольник существует.')
    if segment1 == segment2 == segment3:
        print('Треугольник является равносторонним.')
    elif segment1 == segment2 or segment2 == segment3 or segment1 == segment3:
        print('Треугольник является равнобедренным.')
    else:
        print('Треугольник является разносторонним.')
else:
    print('Треугольник не существует.')
