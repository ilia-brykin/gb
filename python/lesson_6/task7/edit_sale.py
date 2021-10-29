import sys

if len(sys.argv) == 3:
    number = int(sys.argv[1])
    empty_line = '               '  # 15 spaces
    sales_amount = sys.argv[2]
    sales_amount_len = len(sales_amount)
    sales_amount_formatted = f'{sales_amount}{empty_line[sales_amount_len:]}\n'
    with open('bakery.csv', 'r+', encoding='utf-8') as f:
        line_number = 1
        is_number_in_text = False
        while True:
            if line_number == number:
                is_number_in_text = True
                break
            line = f.readline()
            if not line:
                break
            line_number += 1
        if is_number_in_text:
            f.seek(f.tell())
            f.write(sales_amount_formatted)
        else:
            print(f'Строки номер {number} не существует')
