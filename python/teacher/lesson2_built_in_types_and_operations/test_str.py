test_str = 'мама мыла раму, рама мыла маму, +42'
#
print(dir(test_str))
# print(test_str.title())
# print(test_str.capitalize())
str_lines = test_str.split(', ')
result_str = str()
for i, line in enumerate(str_lines):
    str_lines[i] = line[1:].upper()
    print(line[1:].isdigit())
    result_str = result_str + line[1:].upper()

print(str_lines)
print('      '.join(str_lines))
print(result_str.endswith('42'))