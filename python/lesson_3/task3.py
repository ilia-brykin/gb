def thesaurus(*args):
    thesaurus_args = {}
    for arg in args:
        first_letter = arg[0]
        if first_letter not in thesaurus_args:
            thesaurus_args[first_letter] = []
        thesaurus_args[first_letter].append(arg)
    return dict(sorted(thesaurus_args.items(), key=lambda x: x[0]))


print(thesaurus("Иван", "Мария", "Петр", "Илья"))
