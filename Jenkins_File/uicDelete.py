# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/7/25 14:26
# @Author : FanShu
# @Site :
# @File : uicDelete.py
# @Software: PyCharm
import json

import requests

url = "http://172.16.100.108/api/publicService/userCenter/tenant/list?searchText=ci_test&product=&sortField=createTime&sort=desc&pageNum=1&pageSize=50"

payload = {}
headers = {
  'Accept': 'application/json, text/plain, */*',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Cache-Control': 'no-cache',
  'Connection': 'keep-alive',
  'Cookie': 'JSESSIONID=37A3EA961F6C5EEC27CFA703D0490C53; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-07-28+14%3A29%3A25; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5MDc4NDk2NSwiaWF0IjoxNjkwMjY2NTcxfQ.Y6ng4ezbCDrDWA0TeRi_Wb3Xmkt8RDUJj5Pka6FETjs; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=0c9e106a-1d30-44fc-86b6-89fac4206084; DT_SESSION_ID=166d3acf-b728-4932-a7a2-b0c152f8b031',
  'Pragma': 'no-cache',
  'Referer': 'http://172.16.100.108//publicService/',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
  'X-Custom-Header': 'dtuic'
}

response = requests.request("GET", url, headers=headers, data=payload)

response_text = json.loads(response.text)
print(response_text)

data = response_text['data']['data']

for _ in range(len(data)):

    url = "http://172.16.100.108/api/publicService/userCenter/tenant/delete"

    payload = "{\"tenantId\":%s}" % data[_]["tenantId"]
    headers = {
      'Accept': 'application/json, text/plain, */*',
      'Accept-Language': 'zh-CN,zh;q=0.9',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json;charset=UTF-8',
      'Cookie': 'JSESSIONID=37A3EA961F6C5EEC27CFA703D0490C53; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-07-28+14%3A29%3A25; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5MDc4NDk2NSwiaWF0IjoxNjkwMjY2NTcxfQ.Y6ng4ezbCDrDWA0TeRi_Wb3Xmkt8RDUJj5Pka6FETjs; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=8f9e1e88-3af1-4cb9-9fd4-d8e786066d7a; DT_SESSION_ID=8f90f67c-003e-45dd-9beb-918cb5cdd8e1',
      'Origin': 'http://172.16.100.108',
      'Pragma': 'no-cache',
      'Referer': 'http://172.16.100.108//publicService/',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
      'X-Custom-Header': 'dtuic'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    print(response.text)
