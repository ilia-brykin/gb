def type_logger(func):
    def wrapper(*args, **kwargs):
        func_name = func.__name__
        args_string = ''
        for arg in args:
            if args_string != '':
                args_string += ', '
            args_string += f'{arg}: {type(arg)}'
        for _, kwarg in kwargs.items():
            if args_string != '':
                args_string += ', '
            args_string += f'{kwarg}: {type(kwarg)}'
        result = func(*args, **kwargs)
        print(f'{func_name}({args_string}): {type(result)}')
        return result
    return wrapper


@type_logger
def calc_cube(x):
    return x ** 3


@type_logger
def print_all_args(*args, **kwargs):
    print(args)
    print(kwargs)


def test_func(*args, **kwargs):
    print(args, kwargs)


a = calc_cube(5)
print_all_args(5, "4", 5, aloha=34, hola='dsf')

# Сможете ли вы замаскировать работу декоратора?
# Имеете вы ввиду это?
type_logger(test_func(5, "4", 5, aloha=34, hola='dsf'))
