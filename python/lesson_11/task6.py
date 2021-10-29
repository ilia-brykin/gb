class Warehouse:
    def __init__(self, length: int, width: int, height: int):
        self.__length = length
        self.__width = width
        self.__height = height
        self.__office_equipment = {}

    @classmethod
    def build_small_warehouse(cls):
        return cls(10, 10, 3)

    @property
    def office_equipment(self):
        return self.__office_equipment

    @property
    def length(self):
        return self.__length

    @length.setter
    def length(self, length: int):
        self.__length = length

    @length.deleter
    def length(self):
        self.__length = 0

    def add_office_equipment(self, device_type, count):
        if type(count) == str:
            print('нельзя использовать строковый тип данных')
            return
        if device_type not in self.__office_equipment:
            self.__office_equipment[device_type] = {
                'count': 0,
            }
        self.__office_equipment[device_type]['count'] += count

    def transfer_current_device_to_division(self, device_type):
        if device_type in self.__office_equipment and self.__office_equipment[device_type]['count'] > 0:
            self.__office_equipment[device_type]['count'] -= 1


class OfficeEquipment:
    def __init__(self, price: float, brand: str):
        self.price = price
        self.brand = brand


class Printer(OfficeEquipment):
    def __init__(self, pages_per_minute: int, *args, **kwargs):
        self.pages_per_minute = pages_per_minute
        self.type = 'printer'
        super().__init__(*args, **kwargs)


class Scanner(OfficeEquipment):
    def __init__(self, dpi: str, *args, **kwargs):
        self.dpi = dpi
        self.type = 'scanner'
        super().__init__(*args, **kwargs)


class Copier(OfficeEquipment):
    def __init__(self, is_color: bool, *args, **kwargs):
        self.is_color = is_color
        self.type = 'copier'
        super().__init__(*args, **kwargs)


printer = Printer(50, 100.99, 'HP')
scanner = Scanner('1024x894', 89.50, 'Lenovo')
copier = Copier(True, 200.0, 'HP')

warehouse = Warehouse(100, 200, 300)
warehouse.add_office_equipment(printer.type, 2)
warehouse.add_office_equipment(scanner.type, 10)
warehouse.add_office_equipment(copier.type, '4')
print(warehouse.office_equipment)
warehouse.transfer_current_device_to_division('printer')
print(warehouse.office_equipment)

