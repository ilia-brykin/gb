class ZeroDivisionErrorLocal(Exception):
    def __init__(self):
        super().__init__('деления на ноль')


dividend = int(input('делимое '))
divider = int(input('делитель '))


try:
    if divider == 0:
        raise ZeroDivisionErrorLocal()
    res = dividend / divider
except ZeroDivisionErrorLocal as e:
    print(e)
else:
    print(f"Все хорошо. Результат - {res}")
finally:
    print("Программа завершена")


