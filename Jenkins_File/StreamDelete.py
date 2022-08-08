# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/11/10 10:18 上午
# @Author : FanShu
# @Site :
# @File : StreamDelete.py
# @Software: PyCharm
import json
import requests

def delete_5_1():
    url = "http://172.16.82.132/api/streamapp/service/streamCatalogue/getCatalogue"

    payload = "{\"nodePid\":91,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
    headers = {
      'Accept': '*/*',
      'Accept-Language': 'zh-CN,zh;q=0.9',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'text/plain;charset=UTF-8',
      'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-07-01+12%3A24%3A22; dt_is_tenant_admin=true; JSESSIONID=82C2F3002CECD8A55ADDAD18B13635C9; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTc0OTcwMjI2MiwiaWF0IjoxNjU2NDA1Mzc5fQ.t2S7cN46-gYbje_CJTssJlW5I2--hxxKr08Kp8ue-9c; dt_is_tenant_creator=false; DT_SESSION_ID=ba05d9fc-6d45-411f-a09b-45f44c5020a2',
      'If-None-Match': '5.1.0-stream1655749127174',
      'Origin': 'http://172.16.82.132',
      'Pragma': 'no-cache',
      'Referer': 'http://172.16.82.132/stream/',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
      'X-Project-ID': '13'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)

    data = response_text['data']['children']
    print(data)


    for _ in range(len(data)):

        url = "http://172.16.82.132/api/streamapp/service/streamTask/deleteTask"

        payload = "{\"id\":%s}" % data[_]['id']
        headers = {
            'Accept': '*/*',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
            'Content-Type': 'text/plain;charset=UTF-8',
            'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-07-01+12%3A24%3A22; dt_is_tenant_admin=true; JSESSIONID=82C2F3002CECD8A55ADDAD18B13635C9; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTc0OTcwMjI2MiwiaWF0IjoxNjU2NDA1Mzc5fQ.t2S7cN46-gYbje_CJTssJlW5I2--hxxKr08Kp8ue-9c; dt_is_tenant_creator=false; DT_SESSION_ID=ba05d9fc-6d45-411f-a09b-45f44c5020a2',
            'If-None-Match': '5.1.0-stream1655749127174',
            'Origin': 'http://172.16.82.132',
            'Pragma': 'no-cache',
            'Referer': 'http://172.16.82.132/stream/',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
            'X-Project-ID': '13'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)


def delete_5_2():

    url = "http://172.16.101.201/api/streamapp/service/streamCatalogue/getCatalogue"

    payload = "{\"nodePid\":79,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
    headers = {
      'Accept': '*/*',
      'Accept-Language': 'zh-CN,zh;q=0.9',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'text/plain;charset=UTF-8',
      'Cookie': 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2022-07-28+09%3A47%3A56; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY1OTIzMjA3NiwiaWF0IjoxNjU4NzEzNjgxfQ.h4dwCwSlhJlJjQZC1q449H1ftenP0QfTc6KVgDGrVAs; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; dt_has_permission_datasource=true; JSESSIONID=DCF4C83EF3646C6CA3D56B72214C8A59; DT_SESSION_ID=37a656b3-defb-40c4-9393-ef205b73a656',
      # 'If-None-Match': '5.2.0-beta2-stream1657141497500',
      'Origin': 'http://172.16.101.201',
      'Pragma': 'no-cache',
      'Referer': 'http://172.16.101.201/stream/',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
      'X-Project-ID': '11'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)

    data = response_text['data']['children']
    print(data)


    for _ in range(len(data)):

        url = "http://172.16.101.201/api/streamapp/service/streamTask/deleteTask"

        payload = "{\"id\":%s}" % data[_]['id']
        headers = {
          'Accept': '*/*',
          'Accept-Language': 'zh-CN,zh;q=0.9',
          'Cache-Control': 'no-cache',
          'Connection': 'keep-alive',
          'Content-Type': 'text/plain;charset=UTF-8',
          'Cookie': 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2022-07-28+09%3A47%3A56; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY1OTIzMjA3NiwiaWF0IjoxNjU4NzEzNjgxfQ.h4dwCwSlhJlJjQZC1q449H1ftenP0QfTc6KVgDGrVAs; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; dt_has_permission_datasource=true; JSESSIONID=DCF4C83EF3646C6CA3D56B72214C8A59; DT_SESSION_ID=37a656b3-defb-40c4-9393-ef205b73a656',
          # 'If-None-Match': '5.2.0-beta2-stream1657141497500',
          'Origin': 'http://172.16.101.201',
          'Pragma': 'no-cache',
          'Referer': 'http://172.16.101.201/stream/',
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
          'X-Project-ID': '11'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)

delete_5_1()
