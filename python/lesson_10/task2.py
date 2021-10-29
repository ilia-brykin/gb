from abc import ABC, abstractmethod


class InterfaceClothes(ABC):
    @abstractmethod
    def get_fabric_consumption(self):
        pass

    @abstractmethod
    def print_fabric_consumption(self):
        pass


class InterfaceCoat(ABC):
    @abstractmethod
    def get_price(self):
        pass


class InterfaceCostume(ABC):
    @abstractmethod
    def is_available(self):
        pass


class Clothes(InterfaceClothes):
    def __init__(self, name):
        self.name = name
        self.__sale = 10

    def get_fabric_consumption(self):
        pass

    def print_fabric_consumption(self):
        print(f'расхода ткани для изделия "{self.name}" {self.get_fabric_consumption()}')

    @property
    def sale(self):
        return self.__sale

    # сеттер для создания свойств
    @sale.setter
    def sale(self, sale: int):
        if sale <= 50:
            self.__sale = sale
        else:
            self.__sale = 50

    @sale.deleter
    def sale(self):
        self.__sale = 0


class Coat(Clothes, InterfaceCoat):
    def __init__(self, name, size: float):
        super().__init__(name)
        self.size = size
        self.price_per_meter = 100

    def get_fabric_consumption(self):
        return self.size / 6.5 + 0.5

    def get_price(self):
        return self.get_fabric_consumption() * self.price_per_meter


class Costume(Clothes, InterfaceCostume):
    def __init__(self, name, height: float, is_available):
        super().__init__(name)
        self.height = height
        self.__is_available = is_available

    def get_fabric_consumption(self):
        return 2 * self.height + 0.3

    def is_available(self):
        return self.__is_available


coat_one = Coat('Пальто итальянское', 65.0)
costume_one = Costume('Костюм советский', 98.5, True)

coat_one.print_fabric_consumption()
costume_one.print_fabric_consumption()

all_fabric_consumption = coat_one.get_fabric_consumption() + costume_one.get_fabric_consumption()

print(f'общий расход ткани: {all_fabric_consumption}')

coat_one.sale = 78
print(coat_one.sale)

coat_one.sale = 20
print(coat_one.sale)

del coat_one.sale
print(coat_one.sale)
