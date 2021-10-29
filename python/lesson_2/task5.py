prices = [
    57.8,
    46.51,
    97,
    101,
    65.47,
    12,
    105.58,
    78,
    67.99,
    55.5,
    32,
    78.5,
    98.6,
    57,
]
# A
prices_all = ''


def get_formatted_price(price_local):
    price_parts_int_and_fractional = str(price_local).split(".")
    price_part_int = price_parts_int_and_fractional[0]
    price_parts_fractional = get_price_part_fractional(price_parts_int_and_fractional)
    return f'{price_part_int} руб {price_parts_fractional} коп'


def get_price_part_fractional(price_parts):
    if len(price_parts) == 1:
        return "00"
    if len(price_parts[1]) == 1:
        return f'0{price_parts[1]}'
    return price_parts[1]


for index, price in enumerate(prices):
    formatted_price = get_formatted_price(price)
    prefix = ''
    if index != 0:
        prefix = ', '

    prices_all += f'{prefix}{formatted_price}'

print(prices_all)

# B
print(id(prices))
prices.sort()
print(id(prices))
print(prices)

# C
prices_sorted_desc = sorted(prices.copy(), reverse=True)
print(prices_sorted_desc)
print(id(prices_sorted_desc))

# D
print(prices[-5:])
