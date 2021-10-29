def num_translate(number_en):
    number_en_to_ru = {
        'zero': 'ноль',
        'one': 'один',
        'two': 'два',
        'three': 'три',
        'four': 'четыре',
        'five': 'пять',
        'six': 'шесть',
        'seven': 'семь',
        'eight': 'восемь',
        'nine': 'девять',
        'ten': 'десять',
    }
    return number_en_to_ru.get(number_en)


print('zero:', num_translate('zero'))
print('one:', num_translate('one'))
print('eight:', num_translate('eight'))
print('aloha', num_translate('aloha'))
