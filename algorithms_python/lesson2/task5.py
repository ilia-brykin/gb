# Вывести на экран коды и символы таблицы ASCII, начиная с символа под номером 32 и заканчивая 127-м включительно.
# Вывод выполнить в табличной форме: по десять пар "код-символ" в каждой строке.
output = ""
index_in_row = 0
for item in range(32, 128):
    output += f'{item}: "{chr(item)}", '
    index_in_row += 1
    if index_in_row == 10:
        output += "\n"
        index_in_row = 0

print(output)
