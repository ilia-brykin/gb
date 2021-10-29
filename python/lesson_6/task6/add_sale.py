import sys

if len(sys.argv) > 1:
    sales_amount = sys.argv[1]
    with open('bakery.csv', 'a', encoding='utf-8') as f:
        f.write(f'{sales_amount}\n')
