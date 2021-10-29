class OneDivision(Exception):
    def __init__(self, message):
        self.txt = message

def division_custom(f_el, s_el):
    if s_el == 1:
        raise OneDivision('One division')
        # raise IsADirectoryError
    else:
        return f_el/s_el
num = 42

num_list = [1, '2', 0]

for el in num_list:
    message = 'Problems'
    try:
        print(division_custom(num, el))
        message = 'Ok'
    except OneDivision:
        print('One division')
    except TypeError as e:
        # message = 'Data fixed'
        message = e
        print(division_custom(num, int(el)))
    except ZeroDivisionError as e:
        # message = 'Zero'
        message = e
        print(float(num))
    else:
        print('No problems')
    finally:
        print(message)