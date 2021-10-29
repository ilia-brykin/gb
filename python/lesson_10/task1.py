class Matrix:
    def __init__(self, matrix: list):
        self.matrix = matrix

    def __str__(self):
        matrix_str = ''
        for index, row in enumerate(self.matrix):
            for col in row:
                matrix_str += f'{col} '
            if index != len(self.matrix) - 1:
                matrix_str += '\n'
        return matrix_str

    def __add__(self, other):
        return Matrix([
            [cell_1 + cell_2 for cell_1, cell_2 in zip(row_1, row_2)]
            for row_1, row_2 in zip(self.matrix, other.matrix)
        ])


matrix_one = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
matrix_two = Matrix([[1, 1, 1], [1, 1, 1], [1, 1, 1]])

matrix_three = matrix_one + matrix_two
print('----matrix_one----')
print(matrix_one)
print('----matrix_two----')
print(matrix_two)
print('----matrix_three----')
print(matrix_three)

matrix_four = Matrix([[1, 2, 3, 4], [5, 6, 7, 8]])
matrix_five = Matrix([[2, 2, 2, 2], [3, 3, 3, 3]])
matrix_six = matrix_four + matrix_five
print('----matrix_six----')
print(matrix_six)
