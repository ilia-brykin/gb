workers = [
    'инженер-конструктор Игорь',
    'главный бухгалтер МАРИНА',
    'токарь высшего разряда нИКОЛАй',
    'директор аэлита',
]

for worker in workers:
    last_word_index = worker.rindex(' ') + 1
    worker_name = worker[last_word_index:].capitalize()
    print(f'Привет, {worker_name}!')
