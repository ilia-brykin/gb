# Выполнить логические побитовые операции "И", "ИЛИ" и др. над числами 5 и 6.
# Выполнить над числом 5 побитовый сдвиг вправо и влево на два знака.

a = 5
b = 6
print('a в десятичной системе:', a)
print('b в десятичной системе:', b)
print('a: в двоичной системе:', bin(a))
print('b: в двоичной системе:', bin(b))

# Битовый оператор ~ НЕТ - инверсия
print('Битовый оператор ~ НЕТ - инверсия')
c = ~a
d = ~b
print('~a в десятичной системе', c)
print('~a в двоичной системе', bin(c))
print('~b в десятичной системе', d)
print('~b в двоичной системе', bin(d))

# Операторы сдвига влево <<, вправо >>
print('Операторы сдвига влево <<, вправо >>')
c = a << 3
d = b << 2
e = a >> 3
f = b >> 2
print('a << 3 в десятичной системе', c)
print('a << 3 в двоичной системе', bin(c))
print('a >> 3 в десятичной системе', e)
print('a >> 3 в двоичной системе', bin(e))
print('b << 2 в десятичной системе', d)
print('b << 2 в двоичной системе', bin(d))
print('b >> 2 в десятичной системе', f)
print('b >> 2 в двоичной системе', bin(f))

# Битовый оператор & (И, AND)
print('Битовый оператор & (И, AND)')
c = a & b
print('a & b в десятичной системе', c)
print('a & b в двоичной системе', bin(c))

# Битовый оператор | ИЛИ (OR)
print('Битовый оператор | ИЛИ (OR)')
c = a | b
print('a | b в десятичной системе', c)
print('a | b в двоичной системе', bin(c))

# Битовый оператор ^ (исключающее ИЛИ, XOR)
print('Битовый оператор ^ (исключающее ИЛИ, XOR)')
c = a ^ b
print('a ^ b в десятичной системе', c)
print('a ^ b в двоичной системе', bin(c))