class Cell:
    def __init__(self, number_of_cells: int):
        self.number_of_cells = number_of_cells

    def __add__(self, other):
        return Cell(self.number_of_cells + other.number_of_cells)

    def __iadd__(self, other):
        self.number_of_cells += other.number_of_cells
        return self

    def __sub__(self, other):
        diff = self.number_of_cells - other.number_of_cells
        if diff > 0:
            return Cell(diff)
        print("разность количества ячеек двух клеток меньше или равна нулю")

    def __isub__(self, other):
        diff = self.number_of_cells - other.number_of_cells
        if diff > 0:
            self.number_of_cells = diff
        else:
            print("разность количества ячеек двух клеток меньше или равна нулю")
        return self

    def __mul__(self, other):
        return Cell(self.number_of_cells * other.number_of_cells)

    def __imul__(self, other):
        self.number_of_cells *= other.number_of_cells
        return self

    def __floordiv__(self, other):
        if other.number_of_cells != 0:
            return Cell(self.number_of_cells // other.number_of_cells)
        print('Ошибка деление на ноль')

    def __ifloordiv__(self, other):
        if other.number_of_cells != 0:
            self.number_of_cells = self.number_of_cells // other.number_of_cells
        else:
            print('Ошибка деление на ноль')
        return self

    def __truediv__(self, other):
        if other.number_of_cells != 0:
            return Cell(int(self.number_of_cells / other.number_of_cells))
        print('Ошибка деление на ноль')

    def __itruediv__(self, other):
        if other.number_of_cells != 0:
            self.number_of_cells = int(self.number_of_cells / other.number_of_cells)
        else:
            print('Ошибка деление на ноль')
        return self

    def make_order(self, number_of_cells_in_row: int):
        row = ''.ljust(number_of_cells_in_row, '*')
        if number_of_cells_in_row >= self.number_of_cells:
            return row
        diff_int = self.number_of_cells // number_of_cells_in_row
        remainder = self.number_of_cells % number_of_cells_in_row
        order = ''
        for i in range(diff_int):
            order += row
            if i != diff_int - 1:
                order += '\n'
        if remainder > 0:
            order += '\n'
            order += ''.ljust(remainder, '*')
        return order


cell_one = Cell(24)
cell_two = Cell(3)

cell_add = cell_one + cell_two
print(cell_add.number_of_cells)
cell_one += cell_two
print(cell_one.number_of_cells)
print(cell_two.make_order(5))
print(cell_one.make_order(5))

cell_one //= cell_two
print(cell_one.number_of_cells)
cell_one /= cell_two
print(cell_one.number_of_cells)
