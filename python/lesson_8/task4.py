def val_checker(func_validate):
    def wrapper_parent(func):
        def wrapper(*args, **kwargs):
            if func_validate(*args, **kwargs):
                return func(*args, **kwargs)
            else:
                args_string = ''
                for arg in args:
                    if args_string != '':
                        args_string += ', '
                    args_string += f'{arg}'
                for _, kwarg in kwargs.items():
                    if args_string != '':
                        args_string += ', '
                    args_string += f'{kwarg}'
                msg = f'wrong val {args_string}'
                raise ValueError(msg)
        return wrapper
    return wrapper_parent


@val_checker(lambda x: x > 0)
def calc_cube(x):
    return x ** 3


def calc_cube2(x):
    return x ** 3


a = calc_cube(5)
print(a)

a = calc_cube(-5)

