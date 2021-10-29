weather_forecast = ['в', '5', 'часов', '17', 'минут', 'температура', 'воздуха', 'была', '+5', 'градусов']
weather_forecast_new = []
weather_forecast_formatted = ''


def append_item_with_quotes(item_local):
    weather_forecast_new.append('"')
    weather_forecast_new.append(item_local)
    weather_forecast_new.append('"')


for item in weather_forecast:
    if item.isdigit():
        if len(item) == 1:
            item = f'0{item}'
        append_item_with_quotes(item)
    elif item[1:].isdigit():
        if len(item[1:]) == 1:
            item = f'{item[:1]}0{item[1:]}'
        append_item_with_quotes(item)
    else:
        weather_forecast_new.append(item)

is_without_space = False
for index, item in enumerate(weather_forecast_new):
    prefix = ' '
    if index == 0 or is_without_space:
        prefix = ''
    weather_forecast_formatted += f'{prefix}{item}'
    if item == '"':
        is_without_space = not is_without_space


print(weather_forecast_formatted)

