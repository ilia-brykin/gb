# Add Two Numbers
# You are given two non-empty linked lists representing two non-negative integers.
# The digits are stored in reverse order, and each of their nodes contains a single digit.
# Add the two numbers and return the sum as a linked list.
#
# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

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


print(get_sum([2, 4, 3], [5, 6, 4]))
print(get_sum([0], [0]))
print(get_sum([9, 9, 9, 9, 9, 9, 9], [9, 9, 9, 9]))
