class ComplexNumber:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def get_complex_number(self):
        return f'{self.a} + {self.b}i'

    def __add__(self, other):
        new_a = self.a + other.a
        new_b = self.b + other.b
        return ComplexNumber(new_a, new_b)

    def __mul__(self, other):
        new_a = self.a * other.a - self.b * other.b
        new_b = self.a * other.b + self.b * other.a
        return ComplexNumber(new_a, new_b)


complex_one = ComplexNumber(5, 4)
complex_two = ComplexNumber(1, 2)
complex_sum = complex_one + complex_two
complex_mul = complex_one * complex_two
print(complex_sum.get_complex_number())
print(complex_mul.get_complex_number())
