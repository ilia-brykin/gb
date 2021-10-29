user_data = ['Basil', 'Petrov', 27, 36.6]
'''
indexes:
0 - name
1 - surname
2 - age
3 - temperature
'''

user_data_dict = {'name':'Basil', 'surname':'Petrov', 'age':27}
user_data_health = {'temp':36.6, 'was_ill': False}
print(user_data_dict.get('name'))
# for i in range(0,10):
# #     user_data_dict.setdefault(i, [])
# user_data_dict[0].append('Petr')
# user_data_dict[0].append(42)
# user_data_dict[0].append([1,2,'Vasya'])
#
# user_data_dict[0] = None
# user_data_dict['was_ill'] = False
user_data_all = user_data_dict.copy()
user_data_all.update(user_data_health)


reversed_data = {}
for key, value in user_data_all.items():
    reversed_data[value] = key

empty_dict = dict.fromkeys(user_data_all.keys(), None)
empty_dict['name'] = 'Basil'
print(empty_dict.popitem())
# print(list(empty_dict))
# print(dir(reversed_data))
dict_list = list(user_data_all.items())

keys = ['Tv', 'laptop', 'Fan', 'fridge']
values = [20000, 30000, None, 30000]

# print(*filter(str.istitle, keys))
#
#

# for i in range(len(values)):
#     print(type(str(values[i])))
#
# print(list(map(str, values)))
# print(*map(type, keys))
# print(*map(type, list(map(str, values))))
# keys = list(map(str.upper, keys))
all_prices = dict(zip(keys, values))

print(dict(filter(lambda x: x[1] != None, all_prices.items())))