class Road:
    def __init__(self, length: int, width: int):
        self._length = length
        self._width = width

    def get_asphalt_mass(self, mass_for_one_sm: int, count_sm: int):
        mass = self._length * self._width * mass_for_one_sm * count_sm / 1000
        return f'{mass} т.'


road_one = Road(5000, 20)
print(road_one.get_asphalt_mass(25, 5))  # 12500.0 т.
