users = []
hobbys = []
users_hobby = ''

# users.csv
while True:
    users_file_name = input('Введите пожалуйста название первого файла: ')
    try:
        with open(f'files/{users_file_name}', 'r', encoding='utf-8') as f_users:
            for line in f_users:
                line = line.replace('\n', '')
                users.append(line)
    except IsADirectoryError:
        print('Файл не найден')
    except FileNotFoundError:
        print('Файл не найден')
    else:
        break

# hobby.csv
while True:
    hobbys_file_name = input('Введите пожалуйста название второго файла: ')
    try:
        with open(f'files/{hobbys_file_name}', 'r', encoding='utf-8') as f_hobbys:
            for line in f_hobbys:
                line = line.replace('\n', '')
                hobbys.append(line)
    except IsADirectoryError:
        print('Файл не найден')
    except FileNotFoundError:
        print('Файл не найден')
    else:
        break

# users_hobby.txt
save_file_name = input('Введите пожалуйста название файла, в который мы сохраним полученные значения: ')
for index, user in enumerate(users):
    hobby = None
    suffix = '\n'
    if index < len(hobbys):
        hobby = hobbys[index]
    if index == len(users) - 1:
        suffix = ''
    users_hobby += f'{user}: {hobby}{suffix}'

with open(f'files/{save_file_name}', 'w', encoding='utf-8') as f:
    f.write(users_hobby)
