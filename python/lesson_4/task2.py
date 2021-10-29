from requests import get, utils
from decimal import Decimal


def currency_rates(currency_code: str):
    currency_code = currency_code.upper()
    response = get('http://www.cbr.ru/scripts/XML_daily.asp')
    encodings = utils.get_encoding_from_headers(response.headers)
    content = response.content.decode(encoding=encodings)
    index_currency = content.find(currency_code)
    if index_currency == -1:
        return None
    content = content[index_currency:]
    search_tag_value = '<Value>'
    index_value_start = content.find(search_tag_value)
    index_value_end = content.find('</Value>')
    value = content[index_value_start + len(search_tag_value):index_value_end]
    value = Decimal(value.replace(',', '.'))
    return value


print(currency_rates('Usd'))
print(currency_rates('EUR'))
print(currency_rates('Aloha'))
