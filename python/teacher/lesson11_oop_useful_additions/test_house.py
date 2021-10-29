from main_oop import House, Skyscraper

test_house = House(flats=10, families={})
print(test_house)

test_build_small_house = test_house.build_small_house()
print(test_build_small_house)

test_build_from_money = House.build_from_given_money(100000)
print(test_build_from_money)

test_skyscraper = Skyscraper(flats=50, families={}, type='sky')
print(test_skyscraper)

# test_build_small_house_sk = test_skyscraper.build_small_house()
# print(test_build_small_house_sk)

# test_build_from_money_sk = Skyscraper.build_from_given_money(100000)
# print(test_build_from_money_sk)

print(House._counter)
print(Skyscraper._counter)

print(House.choose_biggest_house([test_house, test_skyscraper]))

