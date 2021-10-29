import sys
import itertools

with open('bakery.csv', 'r', encoding='utf-8') as f:
    if len(sys.argv) == 1:
        for line in f:
            print(line.strip())

    elif len(sys.argv) == 2:
        start = int(sys.argv[1]) - 1
        for line in itertools.islice(f, start, None):
            print(line.strip())

    elif len(sys.argv) == 3:
        start = int(sys.argv[1]) - 1
        end = int(sys.argv[2])
        for line in itertools.islice(f, start, end):
            print(line.strip())

