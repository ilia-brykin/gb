import re

test_message = 'Василий Иванов под ниКом punisher99 Д писал оскорбления на почту  ' \
               'sunny_girl@gmail.com и hello_dolly@yandex.ru на мобильный номер +79853602020 ' \
               '21/07/2020 и 29~07~2021'
"""
[] - обозначают диапазон допустимых символов на оду позицию
+ - 1 и более вхождение шаблона слева
* - 0 и более вхождений шаблона
? - 0 или 1 вхождение шаблона
\s - символ пробела (\S - любой непробельный символ)
[^...] - символ отрицания (любой из символов НЕ входящих сюда)
^ - начало строки
\w - любая буква или цифра (\W все что угодно кроме буквы или цифры)
. - любой имвол кроме переноса строки 
\d - только цифры, \D - все кроме цифр

"""

"""
r'[А-ЯЁ][а-яё]+' - поиск всех наборов букв кириллицы начинающихся с заглавной буквы
"""
# result_sub = re.sub(r'К', r'к',  test_message)

# reg_kiril = re.compile(r'\s[^А-ЯЁ][а-яё]+')
reg_kiril = re.compile(r'^[а-яё]+$')
reg_email = re.compile(r'\w[a-zA-Z0-9_.]+@\w+\.\w+')
reg_data = re.compile(r'\d{2}[/~]\d{2}\S\d{2,4}')
n = 10
reg_mobile = re.compile(r'\+7\d{' + str(n) + '}')
result_list = [reg_kiril.match(word) for word in test_message.split() if reg_kiril.match(word) != None]
# print(result_list)
result = reg_kiril.findall(test_message)
res_match = reg_kiril.match(test_message)
res_email = reg_email.findall(test_message)
res_data = reg_data.findall(test_message)
res_mobile = reg_mobile.findall(test_message)
print(res_mobile)
# print(res_match)
# print(result)


# print(result_sub)

print(ord('Ё'), ord('А'), ord('Я'))