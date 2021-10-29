from requests import get
import re

response = get('https://github.com/elastic/examples/raw/master/Common%20Data%20Formats/nginx_logs/nginx_logs')
content = response.text.splitlines()

reg_address = r'(^\S+)[\s\-]+'
reg_date = r'\[([\w\:\/\+\s]+)\]\s'
reg_request_method = r'"([A-Z]+)\s'
reg_url = r'([\w\/\.]+)\s\S+\s'
reg_status = r'(\d+)\s(\d+)\s'
reg_full = re.compile(f'{reg_address}{reg_date}{reg_request_method}{reg_url}{reg_status}')

for item in content:
    print(reg_full.findall(item))
