from task1 import get_response_lines, parse_line

response_lines = get_response_lines()
logs = []
ipaddress_count = {}

for response_line in response_lines:
    log = parse_line(response_line)
    ipaddress = log[0]
    logs.append(log)
    if ipaddress in ipaddress_count:
        ipaddress_count[ipaddress] += 1
    else:
        ipaddress_count[ipaddress] = 1

spammer = max(ipaddress_count, key=ipaddress_count.get)
print('спамер:', spammer)
