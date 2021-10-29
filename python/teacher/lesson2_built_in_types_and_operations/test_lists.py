# x = 123456789
#
# sum_digit = 0
# while x > 0:
#     last_digit = x % 10
#     x = x // 10
#     print(last_digit)

name = 'Basil' #0
surname = 'Popov' #1
age = 27 #2
temp = 36.6 #3
was_ill = False #4

data_list = [name, surname, age, temp, was_ill]
data_list_copy = data_list.copy()
data_list_values = ['Basil', 'Popov', 27, 36.6, False]

# for i in range(len(data_list)):
#     data_list[i] = str(data_list[i]) + '!'

# print(data_list)

for item in data_list:
    item = str(item) + '!'
#     print(item)
#
print(id(data_list))
for i, item in enumerate(data_list):
    data_list[i] = str(item) + '!'

# print(id(data_list))
print(dir(data_list))
print(data_list + data_list_values)
print(data_list)
data_list.append('MSU')
data_list.extend(data_list_values)

print(data_list)
print(data_list[2:7:-1]) #start:end:step
print(data_list[2:])
print(data_list[:7])
print(data_list[::-1])

data_list[-3:] = ['27!', '36.6', 'False']
data_list.insert(2, '7!')

print(data_list.pop(0))
data_list.remove('27!')
# data_list.clear()
# data_list.sort()
# data_list.reverse()
# print(data_list)

new_data_list = sorted(data_list, reverse=True)
print(new_data_list)






# print(id(data_list))