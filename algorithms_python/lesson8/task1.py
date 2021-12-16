# Определение количества различных подстрок с использованием хэш-функции.
# Пусть дана строка S длиной N, состоящая только из маленьких латинских букв.
# Требуется найти количество различных подстрок в этой строке.

from hashlib import sha1


def get_substrings_count(s: str):
    substrings = set()
    for i in range(len(s)):
        for j in range(len(s), i, -1):
            hash_s = sha1(s[i:j].encode('utf-8')).hexdigest()
            substrings.add(hash_s)

    return len(substrings) - 1


print(get_substrings_count('aloha'))  # 13
