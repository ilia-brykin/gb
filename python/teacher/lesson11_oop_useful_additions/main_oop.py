from abc import ABC, abstractmethod
from main_exceptions import FloorsException


class AbstractPattern(ABC):
    @abstractmethod
    def update_data(self):
        pass

    @abstractmethod
    def send_data(self):
        pass

    @abstractmethod
    def color_house(self):
        pass

class House(AbstractPattern):
    district = 'Izmailovo'
    _counter = 0

    # def __init__(self, floors, flats):
    def __init__(self, flats, families, parking_slots=2, color='white', floors=5, coffers=100000, type='house'):
        self.__coffers = coffers
        self.coffers_updated = False
        self.floors = floors
        self.flats = flats
        self.color = color
        self._parking = parking_slots
        self.families = families
        House.update_counter(type=type)

        # House.counter += 1
        # {'409':'simpsons',
        #                  '312':'flanders',
        #                  '456': 'dyatlovs'}

    @staticmethod
    def update_counter(type):
        if type == 'sky':
            Skyscraper._counter += 1
        if type == 'house':
            House._counter += 1

    @staticmethod
    def choose_biggest_house(list_of_house):
        return max(list_of_house, key= lambda x: x.flats)

    # @classmethod
    # def update_counter(cls):
    #     cls.counter += 1

    @classmethod
    def six_floors_white_house(cls, flats, families, parking_slots, coffers=100000):
        return cls(flats, families, parking_slots=parking_slots,
                   color='white', floors=6, coffers=coffers)

    @classmethod
    def build_from_given_money(cls, amount):
        floors = int(amount // 50000)
        parking_slots = 0
        if floors > 10:
            parking_slots = 0
        else:
            raise FloorsException(floors)
            # parking_slots = House.six_floors_white_house(20, {}, 20)
        return cls(floors=floors, flats=50, families={}, parking_slots=parking_slots,
                   color='white', coffers=0)

    def build_small_house(self):
        return House(floors=3, flats=10, families={}, parking_slots=10,
                   color='white', coffers=0)

    def __str__(self):
        res = []
        for key, value in self.__dict__.items():
            res.append(f'{key}: {value} \n')
        return ' '.join(res)

    def __len__(self):
        return self.floors

    def __iadd__(self, other):
        self.flats += other.flats
        self.floors = max([self.floors, other.floors])
        return self

    def __add__(self, other):
        return House(max([self.floors, other.floors]), self.flats + other.flats)

    def __eq__(self, other):
        return self.flats == other.flats and self.floors == other.floors

    def __getitem__(self, item):
        return self.families[item]

    def __setitem__(self, key, value):
        if key not in self.families:
            self.families[key] = value
            return self
        else:
            print('Not empty flat')

    def color_house(self, color):
        self.color = color
        self.__coffers -= 20000

    def show_coffers(self):
        return self.__coffers

    @property
    def coffers(self):
        return self.__coffers

    @coffers.setter
    def coffers(self, value_key: list):
        if value_key[1] == 'admin':
            if not self.coffers_updated:
                self.__coffers *= value_key[0]
                self.coffers_updated = True
            else:
                print('Were updated allready')
        else:
            print('Permission denied')

    @coffers.deleter
    def coffers(self):
        print('Deleted')
        self.__coffers = 0

    def add_parking_slot(self, num):
        pass

    def update_data(self):
        print('NOT IMPLEMENTED')
        return str(self)

    def send_data(self):
        print('NOT IMPLEMENTED')


class PassClass:
    def test_second_parent(self):
        print('Hello, I am father!')

    def helicopter_parking(self):
        print('I can\'t do this')


class Skyscraper(House, PassClass):
    _counter = 0
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helicopter_place = True
        self.__coffers = 500000

    def helicopter_parking(self):
        if self.helicopter_place: #if self.helicopter_place == True:
            self.helicopter_place = False
            print('Welcome')
        else:
            print('No place')

    def __add__(self, other):
        return Skyscraper(max([self.floors, other.floors]), self.flats + other.flats)

    def update_data(self):
        return str(self)

    def send_data(self):
        print('Data sent')


if __name__ == '__main__':
    house_one = House.six_floors_white_house(flats=50, families={}, parking_slots=3)
    house_two = House.build_from_given_money(60000)
    # print(house_two)

    house_two = Skyscraper.build_from_given_money(60000)
    # print(house_two)




