weather_forecast = ['в', '5', 'часов', '17', 'минут', 'температура', 'воздуха', 'была', '+5', 'градусов']
weather_forecast_formatted = ''

for index, item in enumerate(weather_forecast):
    if item.isdigit():
        if len(item) == 1:
            item = f'0{item}'
        item = f'"{item}"'
    elif item[1:].isdigit():
        if len(item[1:]) == 1:
            item = f'{item[:1]}0{item[1:]}'
        item = f'"{item}"'
    prefix = ''
    if index != 0:
        prefix = ' '
    weather_forecast_formatted += f'{prefix}{item}'

print(weather_forecast_formatted)
