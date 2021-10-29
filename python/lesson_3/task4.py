def thesaurus_adv(*args):
    thesaurus_args = {}
    for arg in args:
        name_and_surname = arg.split()
        name_first_letter = name_and_surname[0][0]
        surname_first_letter = name_and_surname[1][0]
        if surname_first_letter not in thesaurus_args:
            thesaurus_args[surname_first_letter] = {
                name_first_letter: []
            }
        if name_first_letter not in thesaurus_args[surname_first_letter]:
            thesaurus_args[surname_first_letter][name_first_letter] = []
        thesaurus_args[surname_first_letter][name_first_letter].append(arg)
    return dict(sorted(thesaurus_args.items(), key=lambda x: x[0]))


print(thesaurus_adv("Иван Сергеев", "Инна Серова", "Петр Алексеев", "Илья Иванов", "Анна Савельева"))
