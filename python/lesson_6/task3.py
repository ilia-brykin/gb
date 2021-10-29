import json

with open('files/users.csv', 'r', encoding='utf-8') as f_users:
    users = f_users.readlines()

with open('files/hobby.csv', 'r', encoding='utf-8') as f_hobbys:
    hobbys = f_hobbys.readlines()

users_hobby = {}

for index, user in enumerate(users):
    initials_list = user.split(',')
    initials_surname = initials_list[0][:1]
    initials_vorname = initials_list[1][:1]
    initials_middle_name = initials_list[2][:1]
    initials = f'{initials_surname}{initials_vorname}{initials_middle_name}'
    hobby = None
    if index < len(hobbys):
        hobby = hobbys[index].replace('\n', '')
    users_hobby[initials] = hobby

with open('files/users_hobby.json', 'w', encoding='utf-8') as f:
    json.dump(users_hobby, f, ensure_ascii=False)

with open('files/users_hobby.json', 'r', encoding='utf-8') as f:
    print(json.load(f))


