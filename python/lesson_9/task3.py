class Worker:
    def __init__(self, name: str, surname: str, position: str, wage, bonus):
        self.name = name
        self.surname = surname
        self.position = position
        self._income = {
            'wage': wage,
            'bonus': bonus,
        }


class Position(Worker):
    def get_full_name(self):
        return f'{self.name} {self.surname}'

    def get_total_income(self):
        return self._income['wage'] + self._income['bonus']


position_one = Position('Boris', 'Elzin', 'president', 10000, 5000)
print(position_one.get_full_name())
print(position_one.get_total_income())
print(position_one.__dict__)
