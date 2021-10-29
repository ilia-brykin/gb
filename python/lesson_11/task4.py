class Warehouse:
    def __init__(self, length: int, width: int, height: int):
        self.length = length
        self.width = width
        self.height = height


class OfficeEquipment:
    def __init__(self, price: float, brand: str):
        self.price = price
        self.brand = brand


class Printer(OfficeEquipment):
    def __init__(self, pages_per_minute: int, *args, **kwargs):
        self.pages_per_minute = pages_per_minute
        super().__init__(*args, **kwargs)


class Scanner(OfficeEquipment):
    def __init__(self, dpi: str, *args, **kwargs):
        self.dpi = dpi
        super().__init__(*args, **kwargs)


class Copier(OfficeEquipment):
    def __init__(self, is_color: bool, *args, **kwargs):
        self.is_color = is_color
        super().__init__(*args, **kwargs)


printer = Printer(50, 100.99, 'HP')
scanner = Scanner('1024x894', 89.50, 'Lenovo')
copier = Copier(True, 200.0, 'HP')
