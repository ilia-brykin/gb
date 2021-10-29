src = [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11]
result_with_duplicates = {}

for number in src:
    if number in result_with_duplicates:
        result_with_duplicates[number] = True
    else:
        result_with_duplicates[number] = False

result = [key for key, item in result_with_duplicates.items() if not item]
print(result)
