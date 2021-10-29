import re


class Date:
    def __init__(self, date: str):
        self.date = date

    @classmethod
    def parse_date(cls, date: str):
        reg_numbers = re.compile(r'(\d+)-(\d+)-(\d+)')
        numbers = reg_numbers.findall(date)[0]
        day = int(numbers[0])
        month = int(numbers[1])
        year = int(numbers[2])
        cls.validate_date(day, month, year)
        return cls(date)

    @staticmethod
    def validate_date(day: int, month: int, year: int):
        is_leap_year = not bool(year % 4)
        month_with_30_days = {
            4: True,
            6: True,
            9: True,
            11: True,
        }
        day_error_massage = 'недопустимое значение дня'
        if year < 1 or year > 9999:
            print('недопустимое значение года')
        if month < 1 or month > 12:
            print('недопустимое значение месяца')
        if day < 1 or day > 31:
            print(day_error_massage)
        elif month == 2:
            if (day > 28 and not is_leap_year) or (day > 29 and is_leap_year):
                print(day_error_massage)
        elif month in month_with_30_days and day > 30:
            print(day_error_massage)


date_one = Date.parse_date('29-2-2021')
date_two = Date.parse_date('28-2-2021')
date_three = Date.parse_date('123-16-2021')
date_four = Date.parse_date('28-2-1991')
