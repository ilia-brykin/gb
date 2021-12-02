# Пользователь вводит данные о количестве предприятий, их наименования и прибыль за 4 квартала
# (т.е. 4 отдельных числа) для каждого предприятия.
# Программа должна определить среднюю прибыль (за год для всех предприятий) и вывести наименования предприятий,
# чья прибыль выше среднего и отдельно вывести наименования предприятий, чья прибыль ниже среднего.

# Примечание: для решения задач попробуйте применить какую-нибудь коллекцию из модуля collections

from urllib.request import Request, urlopen
from random import choice, randint

url = "https://svnweb.freebsd.org/csrg/share/dict/words?revision=61569&view=co"
req = Request(url, headers={'User-Agent': 'Mozilla/5.0'})

web_byte = urlopen(req).read()

webpage = web_byte.decode('utf-8')
first500 = webpage[:500].split("\n")

enterprises = []
year_profits = []
for i in range(randint(5, 10)):
    enterprises.append({
        'name': choice(first500),
        'profit': (randint(0, 1000), randint(0, 1000), randint(0, 1000), randint(0, 1000)),
        'year_profit': 0,
    })

for item in enterprises:
    year_profit = sum(item['profit'])
    item['year_profit'] = year_profit
    year_profits.append(year_profit)

average_profit = sum(year_profits) / len(year_profits)

for item in enterprises:
    if item['year_profit'] > average_profit:
        print('выше среднего', item['name'])
    else:
        print('ниже среднего', item['name'])
