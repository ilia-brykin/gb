import json
import pickle
from time import perf_counter

# user_info = {'name' : 'Basil',
#              'age' : 27,
#              'education' : ['MSU', 'HSE'],
#              'was_ill' : False}

user_info = list(range(1,150000))
# user_info = (1, 2, 3, 4, 5)

# user_info_json = json.dumps(user_info)
# # print(user_info_json, type(user_info_json))
#
# with open('user_data.json', 'w', encoding='utf-8') as f:
#     f.write(user_info_json)
#
# with open('user_data.json', 'r', encoding='utf-8') as f:
#     user_data_raw = f.read()
# user_data = json.loads(user_data_raw)
# print(user_data['education'])

user_info_json = json.dumps(user_info)
# print(user_info_json, type(user_info_json))

# with open('user_data.json', 'w', encoding='utf-8') as f:
#     # f.write(user_info_json)
#     json.dump(user_info, f)
#
# with open('user_data.json', 'r', encoding='utf-8') as f:
#     data = json.load(f)
#     user_data_raw = f.read()
# user_data = json.loads(user_data_raw)
# print(type(data['was_ill']))

# user_info_pickle = pickle.dumps(user_info)
# # print(user_info_json, type(user_info_json))
#
# with open('user_data.pickle', 'wb') as f:
#     f.write(user_info_pickle)
#
# with open('user_data.pickle', 'rb') as f:
#     user_data_raw = f.read()
# user_data = pickle.loads(user_data_raw)
#
# print(user_data)
start = perf_counter()
with open('user_data.pickle', 'wb') as f:
    # f.write(user_info_json)
    pickle.dump(user_info, f)

with open('user_data.pickle', 'rb') as f:
    data = pickle.load(f)
finish = perf_counter()
print('PICKLE:', finish - start)

start = perf_counter()
with open('user_data.json', 'w', encoding='utf-8') as f:
    # f.write(user_info_json)
    json.dump(user_info, f)

with open('user_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

finish = perf_counter()
print('JSON:', finish - start)