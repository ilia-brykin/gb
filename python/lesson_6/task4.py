users = []
hobbys = []
users_hobby = ''

with open('files/users.csv', 'r', encoding='utf-8') as f_users:
    for line in f_users:
        line = line.replace('\n', '')
        users.append(line)

with open('files/hobby.csv', 'r', encoding='utf-8') as f_hobbys:
    for line in f_hobbys:
        line = line.replace('\n', '')
        hobbys.append(line)

for index, user in enumerate(users):
    hobby = None
    suffix = '\n'
    if index < len(hobbys):
        hobby = hobbys[index]
    if index == len(users) - 1:
        suffix = ''
    users_hobby += f'{user}: {hobby}{suffix}'

with open('files/users_hobby.txt', 'w', encoding='utf-8') as f:
    f.write(users_hobby)
