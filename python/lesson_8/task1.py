import re


def email_parse(email):
    reg_username = r'[a-zA-Z][a-zA-Z0-9_.]+'
    reg_domain_start = r'[a-zA-Z][a-zA-Z0-9_.]+'
    reg_domain_end = r'[a-zA-Z]{2,}'
    reg_email = re.compile(f'{reg_username}@{reg_domain_start}.{reg_domain_end}')
    match = reg_email.fullmatch(email)
    if match is None:
        raise ValueError(f'wrong email: {email}')
    email_list = email.split('@')
    return {
        'username': email_list[0],
        'domain': email_list[1],
    }


print(email_parse('someone@geekbrains.ru'))
print(email_parse('aloha@mail.com'))
print(email_parse('1@geekbrainsru'))
