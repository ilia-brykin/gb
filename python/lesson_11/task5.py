from copy import deepcopy


class Warehouse:
    def __init__(self, length: int, width: int, height: int):
        self.length = length
        self.width = width
        self.height = height
        self.office_equipment = {}

    def add_office_equipment(self, device):
        if device.type not in self.office_equipment:
            self.office_equipment[device.type] = {
                'count': 0,
                'devices': {},
            }
        self.office_equipment[device.type]['devices'][device.serial_number] = deepcopy(device)
        self.office_equipment[device.type]['count'] += 1

    def transfer_current_device_to_division(self, device_type, serial_number):
        if device_type in self.office_equipment and serial_number in self.office_equipment[device_type]['devices']:
            self.office_equipment[device_type]['count'] -= 1
            device = deepcopy(self.office_equipment[device_type]['devices'][serial_number])
            del self.office_equipment[device_type]['devices'][serial_number]
            return device


class OfficeEquipment:
    def __init__(self, price: float, brand: str, serial_number: str):
        self.price = price
        self.brand = brand
        self.serial_number = serial_number


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


printer = Printer(50, 100.99, 'HP', '1111111')
scanner = Scanner('1024x894', 89.50, 'Lenovo', '2222222')
copier = Copier(True, 200.0, 'HP', '3333333')

warehouse = Warehouse(100, 200, 300)
warehouse.add_office_equipment(printer)
warehouse.add_office_equipment(scanner)
warehouse.add_office_equipment(copier)
print(warehouse.office_equipment)
print(warehouse.transfer_current_device_to_division('printer', '1111111'))
print(warehouse.office_equipment)

