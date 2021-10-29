class InfStr:
    def __init__(self, data_str, num):
        self.str_ = data_str
        self.num = num
        self.i = -1

    def __iter__(self):
        return self

    def __next__(self):
        self.i += 1
        if self.i == len(self.str_):
            self.num -= self.i
            self.i = 0
            return self.str_[self.i]
        elif self.i < self.num:
            return self.str_[self.i]
        else:
            raise StopIteration


itter_one = InfStr('hello dolly!', 30)
for el in itter_one:
    print(el)

