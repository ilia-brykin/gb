class Stationery:
    def __init__(self, title: str):
        self.title = title

    def draw(self):
        print('«Запуск отрисовки»')


class Pen(Stationery):
    def draw(self):
        print('«Запуск ручки»')


class Pencil(Stationery):
    def draw(self):
        print('«Запуск карандаша»')


class Handle(Stationery):
    def draw(self):
        print('«Запуск маркера»')


stationery = Stationery('циркуль')
pen = Pen('ручка')
pencil = Pencil('карандаш')
handle = Handle('маркер')

stationery.draw()
pen.draw()
pencil.draw()
handle.draw()


