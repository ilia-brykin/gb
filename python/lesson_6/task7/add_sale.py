import sys

if len(sys.argv) > 1:
    empty_line = '               '  # 15 spaces
    sales_amount = sys.argv[1]
    sales_amount_len = len(sales_amount)
    sales_amount_formatted = f'{sales_amount}{empty_line[sales_amount_len:]}\n'
    with open('bakery.csv', 'a', encoding='utf-8') as f:
        f.write(sales_amount_formatted)
