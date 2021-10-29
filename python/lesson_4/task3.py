from requests import get, utils
from datetime import datetime


def get_date_from_str(date: str):
    date_list = date.split('.')
    return datetime(year=int(date_list[2]), month=int(date_list[1]), day=int(date_list[0]))


def currency_rates(currency_code: str):
    currency_code = currency_code.upper()
    response = get('http://www.cbr.ru/scripts/XML_daily.asp')
    encodings = utils.get_encoding_from_headers(response.headers)
    content = response.content.decode(encoding=encodings)
    date_text_search = 'Date="'
    index_date_start = content.find(date_text_search) + len(date_text_search)
    content = content[index_date_start:]
    index_date_end = content.find('"')
    date = content[:index_date_end]

    index_currency = content.find(currency_code)
    if index_currency == -1:
        return {
            'currency': None,
            'date': get_date_from_str(date),
        }
    content = content[index_currency:]
    search_tag_value = '<Value>'
    index_value_start = content.find(search_tag_value)
    index_value_end = content.find('</Value>')
    currency = content[index_value_start + len(search_tag_value):index_value_end]
    currency = float(currency.replace(',', '.'))
    return {
        'currency': currency,
        'date': get_date_from_str(date),
    }


print(currency_rates('Usd'))
print(currency_rates('EUR'))
print(currency_rates('Aloha'))
