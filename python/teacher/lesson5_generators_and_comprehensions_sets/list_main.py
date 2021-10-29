cube_list = []
for i in range(1, 11, 2):
    cube_list.append(i**3)

print(cube_list)

cube_list_short = [i**3 for i in range(1, 11, 2)]
print(cube_list_short)

words_list = ['Mother', 'Milk', 'Dictionary', 'Python', 'List',
              'miss', 'moon', 'milky way']

m_words = []
for word in words_list:
    if word.startswith('M'):
        m_words.append(word)
print(m_words)

m_words_short = [word for word in words_list if word.startswith('M')]
print(m_words_short)

m_words_short = [word if word.startswith('M') else word.upper() for word in words_list]
print(m_words_short)

names = ['Ivan', 'Basil', 'Sasha']
surnames = ['Ivanov', 'Petrov', 'Sidorov']

name_matrix = []
for name in names:
    for surname in surnames:
        name_matrix.append(name +' '+ surname)

print(name_matrix)

name_matrix_short = [name + ' ' + surname for name in names for surname in surnames]
print(name_matrix_short)

"""
   1 2 3
   0 1 2
   ____
1|0|1 1 1
2|1|1 1 1
3|2|1 1 1
"""
mat1 = [[1, 1, 1], [1, 1, 1], [1, 1, 1]]
mat2 = [[1, 1, 1], [1, 1, 1], [1, 1, 1]]
res_mat = [[mat1[i][j] + mat2[i][j] for j in range(len(mat1[0]))] for i in range(len(mat1))]
print(res_mat)

