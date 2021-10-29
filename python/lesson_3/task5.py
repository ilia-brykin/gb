from random import randrange


def get_jokes(count_jokes: int, is_repeat: bool = True):
    """
    prepares and returns jokes

    :param count_jokes: count jokes
    :param is_repeat: are repetitions allowed
    :return: list of jokes
    """
    nouns = ["автомобиль", "лес", "огонь", "город", "дом"]
    adverbs = ["сегодня", "вчера", "завтра", "позавчера", "ночью"]
    adjectives = ["веселый", "яркий", "зеленый", "утопичный", "мягкий"]
    jokes = []
    for i in range(count_jokes):
        random_idx_nouns = randrange(len(nouns))
        random_idx_adverbs = randrange(len(adverbs))
        random_idx_adjectives = randrange(len(adjectives))
        joke = f'{nouns[random_idx_nouns]} {adverbs[random_idx_adverbs]} {adjectives[random_idx_adjectives]}'
        jokes.append(joke)
        if not is_repeat:
            del nouns[random_idx_nouns]
            del adverbs[random_idx_adverbs]
            del adjectives[random_idx_adjectives]
            if len(nouns) == 0 or len(adverbs) == 0 or len(adjectives) == 0:
                break

    return jokes


print(get_jokes(4, False))
print(get_jokes(3))
print(get_jokes(count_jokes=7, is_repeat=False))
