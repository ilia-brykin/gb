SECONDS_UNIT = 'сек'

SECONDS_IN_MINUTE = 60
MINUTES_IN_HOUR = 60
HOURS_IN_DAY = 24
DAYS_IN_MONTH = 31
MONTHS_IN_YEAR = 365

SECONDS_IN_HOUR = SECONDS_IN_MINUTE * MINUTES_IN_HOUR
SECONDS_IN_DAY = SECONDS_IN_HOUR * HOURS_IN_DAY
SECONDS_IN_MONTH = SECONDS_IN_DAY * DAYS_IN_MONTH
SECONDS_IN_YEAR = SECONDS_IN_MONTH * MONTHS_IN_YEAR

TIMES = [
    {
        'unit': 'г',
        'seconds': SECONDS_IN_YEAR,
    },
    {
        'unit': 'мес',
        'seconds': SECONDS_IN_MONTH,
    },
    {
        'unit': 'дн',
        'seconds': SECONDS_IN_DAY,
    },
    {
        'unit': 'час',
        'seconds': SECONDS_IN_HOUR,
    },
    {
        'unit': 'мин',
        'seconds': SECONDS_IN_MINUTE,
    },
]

while True:
    try:
        duration = int(input('Введите пожалуйста промежуток времени в секундах больше 0: '))
    except:
        print('Пожалуйста введите целое число')
    else:
        if duration < 1:
            print('Пожалуйста введите положительное число')
        else:
            break

full_duration = ''
for time in TIMES:
    CURRENT_UNIT = time['unit']
    if time['seconds'] <= duration:
        COUNT_TIME = duration // time['seconds']
        duration = duration % time['seconds']
        full_duration += f'{COUNT_TIME} {CURRENT_UNIT} '
    elif len(full_duration) > 0:  # if we want to get a string like '4 дн 0 час 0 мин 13 сек'
        full_duration += f'0 {CURRENT_UNIT} '

full_duration += f'{duration} {SECONDS_UNIT}'
print(full_duration)
