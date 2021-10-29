from requests import get


def get_response_lines():
    response = get('https://github.com/elastic/examples/raw/master/Common%20Data%20Formats/nginx_logs/nginx_logs')
    return response.text.splitlines()


def parse_line(line):
    ipaddress_index_end = line.find(' ')
    ipaddress = line[:ipaddress_index_end]
    line = line[ipaddress_index_end:]
    request_type_index_start = line.find('"') + 1
    line = line[request_type_index_start:]
    request_type_index_end = line.find(' ')
    request_type = line[:request_type_index_end]
    line = line[request_type_index_end + 1:]
    path_index_end = line.find(' ')
    path = line[:path_index_end]
    return ipaddress, request_type, path


if __name__ == '__main__':
    response_lines = get_response_lines()
    logs = []

    for response_line in response_lines:
        logs.append(parse_line(response_line))

    print(logs)
