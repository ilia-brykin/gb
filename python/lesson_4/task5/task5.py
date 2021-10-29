from utils import currency_rates
from sys import argv

if len(argv) < 2:
    print('Передайте пожалуйста валюту в скрипт')
else:
    current_currency = currency_rates(argv[1])
    print('{}, {}'.format(current_currency['currency'], current_currency['date']))
