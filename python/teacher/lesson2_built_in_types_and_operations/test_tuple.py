# data_tuple = tuple(['Basil', 'Popov', 27, 36.6, False])
data_tuple = ('Basil', 'Popov', 27, 36.6, False, ['MSU', 'HSE'])
# more_data_tuple = ('MSU', 'HSE')
# print(dir(data_tuple))
# all_data = data_tuple + more_data_tuple
# print(all_data)
data_tuple[-1][0] = 'RGGU'
print(data_tuple)