# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/2/23 2:26 下午
# @Author : FanShu
# @Site :
# @File : BatchDelete.py
# @Software: PyCharm
import json

import requests
#
# url = "http://uic.insightci.cc/api/rdos/batch/batchCatalogue/getCatalogue"
#
# payload = "{\"isGetFile\":true,\"nodePid\":1579,\"catalogueType\":\"TaskDevelop\"}"
# headers = {
#   'Accept': '*/*',
#   'Accept-Language': 'zh-CN,zh;q=0.9',
#   'Cache-Control': 'no-cache',
#   'Connection': 'keep-alive',
#   'Content-Type': 'text/plain;charset=UTF-8',
#   'Cookie': 'dt_product_code=RDOS; SESSION=NWFmNjE4Y2UtNjM4YS00YTcxLTgxODYtOTdjYzdhZGVjZDc4; dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-05-19+09%3A31%3A56; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4Mzc2ODcxNiwiaWF0IjoxNjUyNjY0NzIzfQ.s-1q-XsK3K3qgSmFB6LHc8ThxqXLSX3TgXgtAtCOy0k; dt_is_tenant_admin=true; dt_is_tenant_creator=false; track_rdos=true; JSESSIONID=8633B75D5873BAD38477AE8A541F017F; DT_SESSION_ID=6ea4d609-8c7e-4a57-85bc-2b8370ffa5a3',
#   'If-None-Match': '5.0.261652293487686',
#   'Origin': 'http://uic.insightci.cc',
#   'Pragma': 'no-cache',
#   'Referer': 'http://uic.insightci.cc/batch/',
#   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36',
#   'X-Project-ID': '109'
# }
#
# response = requests.request("POST", url, headers=headers, data=payload)
#
# print(response.text)
#
# response_text = json.loads(response.text)
#
# data = response_text['data']['children']
# print(data)
#
# for _ in range(len(data)):
#     payload = "{\"taskId\":%s}" % data[_]['id']
#
#     url = "http://uic.insightci.cc/api/rdos/batch/batchTask/deleteTask"
#
#     headers = {
#         'Accept': '*/*',
#         'Accept-Language': 'zh-CN,zh;q=0.9',
#         'Cache-Control': 'no-cache',
#         'Connection': 'keep-alive',
#         'Content-Type': 'text/plain;charset=UTF-8',
#         'Cookie': 'dt_product_code=RDOS; SESSION=NWFmNjE4Y2UtNjM4YS00YTcxLTgxODYtOTdjYzdhZGVjZDc4; dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-05-19+09%3A31%3A56; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4Mzc2ODcxNiwiaWF0IjoxNjUyNjY0NzIzfQ.s-1q-XsK3K3qgSmFB6LHc8ThxqXLSX3TgXgtAtCOy0k; dt_is_tenant_admin=true; dt_is_tenant_creator=false; track_rdos=true; JSESSIONID=8633B75D5873BAD38477AE8A541F017F; DT_SESSION_ID=6ea4d609-8c7e-4a57-85bc-2b8370ffa5a3',
#         'If-None-Match': '5.0.261652293487686',
#         'Origin': 'http://uic.insightci.cc',
#         'Pragma': 'no-cache',
#         'Referer': 'http://uic.insightci.cc/batch/',
#         'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36',
#         'X-Project-ID': '109'
#     }
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)
#
#
import requests

url = "http://172.16.82.132/api/rdos/batch/batchCatalogue/getCatalogue"

payload = "{\"isGetFile\":true,\"nodePid\":499,\"catalogueType\":\"TaskDevelop\"}"
headers = {
  'Accept': '*/*',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Cache-Control': 'no-cache',
  'Connection': 'keep-alive',
  'Content-Type': 'text/plain;charset=UTF-8',
  'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-07-14+15%3A18%3A59; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY1ODA0MjMzOSwiaWF0IjoxNjU3NTIzOTQzfQ.6dkcqf0m5XIAKlCzBfMDKKDQ1Wpj6gUbmH7dF6_z5m4; dt_is_tenant_admin=true; dt_is_tenant_creator=false; track_rdos=true; DT_SESSION_ID=2a988d3f-ae3d-4450-b2ac-87a36bfb5306; JSESSIONID=67992CFCA32346060C9FEE2953F984E6',
  # 'If-None-Match': '5.1.0-beta161653767777389',
  'Origin': 'http://172.16.82.132',
  'Pragma': 'no-cache',
  'Referer': 'http://172.16.82.132/batch/',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36',
  'X-Project-ID': '25'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)


response_text = json.loads(response.text)

data = response_text['data']['children']
print(data)


for _ in range(len(data)):

    url = "http://172.16.82.132/api/rdos/batch/batchTask/deleteTask"

    payload = "{\"taskId\":%s}" % data[_]['id']
    headers = {
        'Accept': '*/*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'text/plain;charset=UTF-8',
        'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-07-14+15%3A18%3A59; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY1ODA0MjMzOSwiaWF0IjoxNjU3NTIzOTQzfQ.6dkcqf0m5XIAKlCzBfMDKKDQ1Wpj6gUbmH7dF6_z5m4; dt_is_tenant_admin=true; dt_is_tenant_creator=false; track_rdos=true; DT_SESSION_ID=2a988d3f-ae3d-4450-b2ac-87a36bfb5306; JSESSIONID=67992CFCA32346060C9FEE2953F984E6',
        # 'If-None-Match': '5.1.0-beta161653767777389',
        'Origin': 'http://172.16.82.132',
        'Pragma': 'no-cache',
        'Referer': 'http://172.16.82.132/batch/',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36',
        'X-Project-ID': '25'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    print(response.text)



# import requests
#
# url = "http://uic.dttest.cn/api/rdos/batch/batchCatalogue/getCatalogue"
#
# payload = "{\"isGetFile\":true,\"nodePid\":331,\"catalogueType\":\"TaskDevelop\",\"parentId\":195}"
# headers = {
#   'Accept': '*/*',
#   'Accept-Language': 'zh-CN,zh;q=0.9',
#   'Cache-Control': 'no-cache',
#   'Connection': 'keep-alive',
#   'Content-Type': 'text/plain;charset=UTF-8',
#   'Cookie': 'dt_expire_cycle=0; dt_product_code=RDOS; dt_can_redirect=true; JSESSIONID=027314AE5F69B6BE8A4CE97F73DB11E3; dt_user_id=1; dt_username=admin%40dtstack.com; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3MDk4MjYzMiwiaWF0IjoxNjU1NDMwNjMyfQ.Fr93MNSy6gkrYy5Rc157YMfIeBjhDlXQn90psFt3yqs; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_is_tenant_admin=true; dt_is_tenant_creator=true; dt_cookie_time=2022-06-20+09%3A50%3A32; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; track_rdos=true; DT_SESSION_ID=a81eed12-0f1b-405e-8cc0-d487f25e1031',
#   'If-None-Match': '5.1.0-beta51649212083973',
#   'Origin': 'http://uic.dttest.cn',
#   'Pragma': 'no-cache',
#   'Referer': 'http://uic.dttest.cn/batch/',
#   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36',
#   'X-Project-ID': '11'
# }
#
# response = requests.request("POST", url, headers=headers, data=payload)
#
# print(response.text)
#
# response_text = json.loads(response.text)
#
# data = response_text['data']['children']
# print(data)
#
# for _ in range(len(data)):
#
#     url = "http://uic.dttest.cn/api/rdos/batch/batchTask/deleteTask"
#
#     payload = "{\"taskId\":%s}" % data[_]['id']
#     headers = {
#         'Accept': '*/*',
#         'Accept-Language': 'zh-CN,zh;q=0.9',
#         'Cache-Control': 'no-cache',
#         'Connection': 'keep-alive',
#         'Content-Type': 'text/plain;charset=UTF-8',
#         'Cookie': 'dt_expire_cycle=0; dt_product_code=RDOS; dt_can_redirect=true; JSESSIONID=027314AE5F69B6BE8A4CE97F73DB11E3; dt_user_id=1; dt_username=admin%40dtstack.com; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3MDk4MjYzMiwiaWF0IjoxNjU1NDMwNjMyfQ.Fr93MNSy6gkrYy5Rc157YMfIeBjhDlXQn90psFt3yqs; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_is_tenant_admin=true; dt_is_tenant_creator=true; dt_cookie_time=2022-06-20+09%3A50%3A32; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; track_rdos=true; DT_SESSION_ID=a81eed12-0f1b-405e-8cc0-d487f25e1031',
#         'If-None-Match': '5.1.0-beta51649212083973',
#         'Origin': 'http://uic.dttest.cn',
#         'Pragma': 'no-cache',
#         'Referer': 'http://uic.dttest.cn/batch/',
#         'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36',
#         'X-Project-ID': '11'
#     }
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)
#
#
