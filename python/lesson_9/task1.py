import time


class TrafficLight:
    def __init__(self):
        self.__color = None
        self.__is_running = False

    def running(self, color):
        if (color == 'красный' and (self.__color is None or self.__color == 'зелёный')) or \
                (color == 'жёлтый' and self.__color == 'красный') or \
                (color == 'зелёный' and self.__color == 'жёлтый'):
            self.__color = color
            print(f'Включен {self.__color}')
        else:
            print('Нарушен порядок цветов светофора')


traffic_light_one = TrafficLight()

traffic_light_one.running('красный')
time.sleep(7)
traffic_light_one.running('жёлтый')
time.sleep(2)
traffic_light_one.running('зелёный')
time.sleep(5)
traffic_light_one.running('жёлтый')
