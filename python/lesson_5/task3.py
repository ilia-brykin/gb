def tutors_in_classes_generator(tutors_local: list, classes_local: list):
    for index, tutor in enumerate(tutors_local):
        if index < len(classes_local):
            yield tutor, classes_local[index]
        else:
            yield tutor, None


tutors = [
    'Иван',
    'Анастасия',
    'Петр',
    'Сергей',
    'Дмитрий',
    'Борис',
    'Елена',
    'Aloha',
    'Ксения',
]
classes = [
    '9А',
    '7В',
    '9Б',
    '9В',
    '8Б',
    '10А',
    '10Б',
    '9А',
]

tutors_in_classes = tutors_in_classes_generator(tutors, classes)
print(type(tutors_in_classes))
print(next(tutors_in_classes))
for item in tutors_in_classes:
    print(item)
