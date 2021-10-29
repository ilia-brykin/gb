class_7a = {'Basil Ivanov', 'Natasha Sidrova', 'Katya Petrova', 'Olya Ivanova', 'Sergey Antonov'}
class_7b_list = ['Basil Ivanov',  'Olya Ivanova', 'Vasya Kirillov', 'Ura Korolev', 'Natasha Leonova', 'Natasha Leonova']
class_7b = set(class_7b_list)
# print(class_7b)

# print(dir(class_7a))
class_7a.add('Lena Svetina')
print(class_7b)
print(class_7b.difference_update(class_7a))
print(class_7b)
class_7b.symmetric_difference_update(class_7a)
print(class_7b)
# - and -=
print(class_7b.intersection(class_7a))

test_set = set('hello world')
hell_set = set('hello')
# print(hell_set.issubset(test_set))
# print(hell_set.pop())
hell_set.remove('h')
# print(hell_set)
#
# print(class_7b.update(class_7a))
# print(len(class_7b))