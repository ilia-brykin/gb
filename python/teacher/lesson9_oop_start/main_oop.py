class House:
    district = 'Izmailovo'

    def __init__(self, floors, flats):
        self.__coffers = 100000
        self.floors = floors
        self.flats = flats
        self.color = 'white'
        self._parking = '2 places'

    def print_stat(self):
        res = []
        for key, value in self.__dict__.items():
            res.append(f'{key}: {value}')
        print(' '.join(res))
        # print(f'District: {House.district},\n'
        #       f'Floors: {self.floors},\n'
        #       f'Flats: {self.flats},\n'
        #       f'Color: {self.color}')

    def color_house(self, color):
        self.color = color
        self.__coffers -= 20000

    def show_coffers(self):
        return self.__coffers

    def add_parking_slot(self, num):
        pass


class PassClass:
    def test_second_parent(self):
        print('Hello, I am father!')

    def helicopter_parking(self):
        print('I can\'t do this')


class Skyscraper(House, PassClass):
    def __init__(self, *args):
        super().__init__(*args)
        self.helicopter_place = True
        self.__coffers = 500000

    def helicopter_parking(self):
        if self.helicopter_place:
            self.helicopter_place = False
            print('Welcome')
        else:
            print('No place')





house_one = Skyscraper(55, 20)
house_two = House(15, 60)
house_one.test_second_parent()
# house_one.print_stat()
# house_two.print_stat()
house_one.helicopter_parking()
house_one.helicopter_parking()
# print(house_one.district, house_one.floors, house_one.flats)
# print(house_one.__dict__)
# print(house_two.district, house_two.floors, house_two.flats)
House.district = 'Baumnka'
# print(house_one.__dict__)
# print(house_one.district, house_one.floors, house_one.flats)
# print(house_two.district)
# print(House.district)
#
# house_one.__setattr__('kindergarten', True)
# print(house_one.__dict__)
# print(house_two.__dict__)

# house_one.print_stat() #House.print_stat(house_one)
house_one.color_house('red')
# house_one.print_stat()
# print(house_one.show_coffers())
# print(house_one._parking)
# print(house_one._House__coffers)

