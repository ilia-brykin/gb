def create_dictionary_from_lists(keys: list, values: list, *args, del_none=True, **kwargs):
    """

    :param keys: list, tuple
    :param values: list, tuple
    :return:
    """
    print(kwargs)
    if kwargs.get('upper'):
        keys = list(map(str.upper, keys))
    all_prices = dict(zip(keys, values))
    if del_none:
        all_prices = list(filter(lambda x: x[1] != None, all_prices.items()))
        if kwargs.get('sort_by_price'):
            all_prices.sort(key=lambda x: x[1])
        else:
            all_prices.sort()
    return dict(all_prices)


def print_dict(d: dict):
    for key, value in d.items():
        print(f'Key: {key}, value: {value}')


keys = ['Tv', 'laptop', 'Fan', 'fridge']
values = [20000, 30000, None, 30000]

new_dict = create_dictionary_from_lists(keys, values, del_none=True, upper=True, sort_by_price=True)
print_dict(new_dict)

names = ['Basil', 'Ivan', 'Katya', 'Sveta']
surname = ['Ivanov', 'Petrov', 'Sinichkina', 'Petrova']

fio_dict = create_dictionary_from_lists(names, values=surname)
print_dict(fio_dict)

short_names = list(map(lambda x: f'{x[0][0]}. {x[1]}', fio_dict.items()))
print(short_names)