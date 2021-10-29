def num_translate_adv(number_en):
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
    is_first_letter_upper = number_en[0].isupper()
    number_en_lower = number_en.lower()
    number_ru = number_en_to_ru.get(number_en_lower)
    if is_first_letter_upper and number_ru:
        return number_ru.capitalize()
    return number_ru


print('zero:', num_translate_adv('zero'))
print('One:', num_translate_adv('One'))
print('Two:', num_translate_adv('Two'))
print('two:', num_translate_adv('two'))
print('eight:', num_translate_adv('eight'))
print('aloha', num_translate_adv('aloha'))
