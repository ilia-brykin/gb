# Add Two Numbers
# You are given two non-empty linked lists representing two non-negative integers.
# The digits are stored in reverse order, and each of their nodes contains a single digit.
# Add the two numbers and return the sum as a linked list.
#
# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

# Constraints:
#
# The number of nodes in each linked list is in the range [1, 100].
# 0 <= Node.val <= 9
# It is guaranteed that the list represents a number that does not have leading zeros.
import cProfile


def get_sum(l1: list, l2: list):
    l1.reverse()
    l2.reverse()
    l1 = [str(i) for i in l1]
    l2 = [str(i) for i in l2]

    first_number = int(''.join(l1))
    second_number = int(''.join(l2))
    sum_numbers = str(first_number + second_number)
    sum_list = [int(char) for char in sum_numbers]
    sum_list.reverse()
    return sum_list


def get_sum2(l1: list, l2: list):
    len1 = len(l1)
    len2 = len(l2)
    max_len = max(len1, len2)
    diff = len1 - len2
    diff_abs = abs(diff)
    sum_list = []
    ten_part = 0
    for i in range(max_len - 1, -1, -1):
        number1 = number2 = 0
        index_diff = i - diff_abs
        if diff == 0:
            number1 = l1[i]
            number2 = l2[i]
        elif diff < 0:
            number2 = l2[i]
            if index_diff >= 0:
                number1 = l1[index_diff]
        else:
            number1 = l1[i]
            if index_diff >= 0:
                number2 = l2[index_diff]
        sum_numbers = number1 + number2 + ten_part
        sum_list.append(sum_numbers % 10)
        ten_part = sum_numbers // 10
    if ten_part > 0:
        sum_list.append(ten_part)
    return sum_list


print(get_sum([2, 4, 3], [5, 6, 4]))
print(get_sum2([2, 4, 3], [5, 6, 4]))
print(get_sum([0], [0]))
print(get_sum2([0], [0]))
print(get_sum([9, 9, 9, 9, 9, 9, 9], [9, 9, 9, 9]))
print(get_sum2([9, 9, 9, 9, 9, 9, 9], [9, 9, 9, 9]))
print(get_sum([9, 9, 9, 9], [9, 9, 9, 9, 9, 9, 9]))
print(get_sum2([9, 9, 9, 9], [9, 9, 9, 9, 9, 9, 9]))
