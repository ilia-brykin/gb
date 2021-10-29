class Car:
    def __init__(self, speed: int, color: str, name: str, is_police: bool):
        self.speed = speed
        self.color = color
        self.name = name
        self.is_police = is_police

    def go(self):
        print(f'машина "{self.name}" поехала')

    def stop(self):
        print(f'машина "{self.name}" остановилась')

    def turn(self, direction):
        print(f'машина "{self.name}" повернула на {direction}')

    def show_speed(self):
        print(f'текущую скорость автомобиля {self.speed}')


class TownCar(Car):
    def show_speed(self):
        if self.speed > 60:
            print(f'превышении скорости')
        super().show_speed()


class SportCar(Car):
    pass


class WorkCar(Car):
    def show_speed(self):
        if self.speed > 40:
            print(f'превышении скорости')
        super().show_speed()


class PoliceCar(Car):
    pass


def show_full_object(object_from_class):
    print(object_from_class.__class__.__name__)
    print(object_from_class.__dict__)
    object_from_class.go()
    object_from_class.stop()
    object_from_class.turn('лево')
    object_from_class.turn('право')
    object_from_class.show_speed()


townCar = TownCar(100, 'red', 'BMW', False)
sportCar = SportCar(250, 'green', 'Ferrari', False)
workCar = WorkCar(39, 'black', 'Garbage truck', False)
policeCar = PoliceCar(200, 'white', 'Opel', True)

show_full_object(townCar)
show_full_object(sportCar)
show_full_object(workCar)
show_full_object(policeCar)
