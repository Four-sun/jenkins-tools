# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/11/10 10:18 上午
# @Author : FanShu
# @Site :
# @File : StreamDelete.py
# @Software: PyCharm
import json

import requests

url = "http://uic.dtci43.com/api/streamapp/service/streamCatalogue/getCatalogue"

payload = "{\"nodePid\":195,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
headers = {
  'Connection': 'keep-alive',
  'Pragma': 'no-cache',
  'Cache-Control': 'no-cache',
  'If-None-Match': '4.3.61641240912293',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36',
  'X-Project-ID': '31',
  'Content-Type': 'text/plain;charset=UTF-8',
  'Accept': '*/*',
  'Origin': 'http://rdos.dtstack.dtci43.com',
  'Referer': 'http://rdos.dtstack.dtci43.com/stream/',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Cookie': 'dt_product_code=RDOS; track_rdos=true; SESSION=NDUxOGU2ZDAtZWQwMS00NGE5LTg0YjgtMGZjZmIyODkyODgy; dt_language=zh; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2022-01-23+15%3A15%3A10; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3Mzc2NjkxMCwiaWF0IjoxNjQyNjYyOTE2fQ.9cimPq36JAFsrsdJvn4iJIe_eCntbdt-wpNEn3Jf3wk; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=60328b4f-3233-438a-aff4-a38746757657; JSESSIONID=88B1E15D6DE1627E1162A6E8D17962CA; JSESSIONID=479E5BACA102A771BBA4A1C15C214677'
}

response = requests.request("POST", url, headers=headers, data=payload)

response_text = json.loads(response.text)

data = response_text['data']['children']
print(data)


for _ in range(len(data)):
    headers = {
        'Connection': 'keep-alive',
        'Pragma': 'no-cache',
        'Cache-Control': 'no-cache',
        'If-None-Match': '4.3.61641240912293',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36',
        'X-Project-ID': '31',
        'Content-Type': 'text/plain;charset=UTF-8',
        'Accept': '*/*',
        'Origin': 'http://rdos.dtstack.dtci43.com',
        'Referer': 'http://rdos.dtstack.dtci43.com/stream/',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cookie': 'dt_product_code=RDOS; track_rdos=true; SESSION=NDUxOGU2ZDAtZWQwMS00NGE5LTg0YjgtMGZjZmIyODkyODgy; dt_language=zh; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2022-01-23+15%3A15%3A10; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3Mzc2NjkxMCwiaWF0IjoxNjQyNjYyOTE2fQ.9cimPq36JAFsrsdJvn4iJIe_eCntbdt-wpNEn3Jf3wk; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=60328b4f-3233-438a-aff4-a38746757657; JSESSIONID=88B1E15D6DE1627E1162A6E8D17962CA; JSESSIONID=479E5BACA102A771BBA4A1C15C214677'
    }
    url = "http://uic.dtci43.com/api/streamapp/service/streamTask/deleteTask"
    payload = "{\"id\":%s}" % data[_]['id']
    response1 = requests.request("POST", url, headers=headers, data=payload)
    print(response1.text)
