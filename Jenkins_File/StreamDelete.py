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
  'If-None-Match': '4.3.0-beta51633039184821',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36',
  'X-Project-ID': '31',
  'Content-Type': 'text/plain;charset=UTF-8',
  'Accept': '*/*',
  'Origin': 'http://uic.dtci43.com',
  'Referer': 'http://uic.dtci43.com/stream/',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2021-11-12+20%3A49%3A05; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY2NzU2NjE0NSwiaWF0IjoxNjM2NDYyMTQ5fQ.qz8g3hEGUtU3OYwWaj9aaLhwy1NXE1ZJj9_4T4iBv9I; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=67EFAE18FA5A1E5C5E34C09649E751BA; DT_SESSION_ID=50f08d55-4111-43ff-a6f5-599118efe612'
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
        'If-None-Match': '4.3.0-beta51633039184821',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36',
        'X-Project-ID': '31',
        'Content-Type': 'text/plain;charset=UTF-8',
        'Accept': '*/*',
        'Origin': 'http://uic.dtci43.com',
        'Referer': 'http://uic.dtci43.com/stream/',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2021-11-12+20%3A49%3A05; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY2NzU2NjE0NSwiaWF0IjoxNjM2NDYyMTQ5fQ.qz8g3hEGUtU3OYwWaj9aaLhwy1NXE1ZJj9_4T4iBv9I; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=67EFAE18FA5A1E5C5E34C09649E751BA; DT_SESSION_ID=50f08d55-4111-43ff-a6f5-599118efe612'
    }
    url = "http://uic.dtci43.com/api/streamapp/service/streamTask/deleteTask"
    payload = "{\"id\":%s}" % data[_]['id']
    response1 = requests.request("POST", url, headers=headers, data=payload)
    print(response1.text)
