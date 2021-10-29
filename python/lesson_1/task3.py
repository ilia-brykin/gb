name_percent_main_part = 'процент'

while True:
    try:
        percent_from_input = int(input('Введите пожалуйста число от 1 до 20: '))
    except:
        print('Пожалуйста введите целое число')
    else:
        if percent_from_input < 1 or percent_from_input > 20:
            print('Ваше число не входит в диапазон от 1 до 20')
        else:
            break


def get_percent_full_name(percent):
    suffix = get_percent_suffix(percent)
    return f'{percent} {name_percent_main_part}{suffix}'


def get_percent_suffix(percent):
    if percent > 4:
        return 'ов'
    if percent > 1:
        return 'а'
    return ''


print(get_percent_full_name(percent_from_input))
print('Все склонения от 1 до 20:')

for i in range(1, 21):
    print(get_percent_full_name(i))
