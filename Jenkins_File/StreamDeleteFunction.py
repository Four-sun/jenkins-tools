# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/2/27 14:15
# @Author : FanShu
# @Site :
# @File : StreamDeleteFunction.py.py
# @Software: PyCharm
import json

import requests


def stream_5_1_x_function():

    url = "http://172.16.82.132/api/streamapp/service/streamCatalogue/getCatalogue"

    payload = "{\"nodePid\":101,\"catalogueType\":\"CustomFunction\",\"isGetFile\":true}"
    headers = {
      'Accept': '*/*',
      'Accept-Language': 'zh-CN,zh;q=0.9',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'text/plain;charset=UTF-8',
      'Cookie': 'track_rdos=true; tag_is_iframe=0; tag_project_id=221; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2023-03-02+14%3A09%3A51; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3Nzk5NjU5MSwiaWF0IjoxNjc3NDc4MTk1fQ.97mdwCuHWCvjVB59q8Vr8-1aR_5k_ysGQRKRdWi-vrQ; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=3F3850A437889B197A490D0CE2B4AC45; DT_SESSION_ID=88cd2088-fb27-4af7-aadd-5a0fa9f0eb96',
      'Origin': 'http://172.16.82.132',
      'Pragma': 'no-cache',
      'Referer': 'http://172.16.82.132/stream/',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
      'X-Project-ID': '13'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)

    data = response_text['data']['children']
    print(type(data))

    for _ in data:
        url = "http://172.16.82.132/api/streamapp/service/streamFunction/deleteFunction"

        payload = '{\"funcId\":%s}' % _['id']
        headers = {
            'Accept': '*/*',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
            'Content-Type': 'text/plain;charset=UTF-8',
            'Cookie': 'track_rdos=true; tag_is_iframe=0; tag_project_id=221; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2023-03-02+14%3A09%3A51; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3Nzk5NjU5MSwiaWF0IjoxNjc3NDc4MTk1fQ.97mdwCuHWCvjVB59q8Vr8-1aR_5k_ysGQRKRdWi-vrQ; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=3F3850A437889B197A490D0CE2B4AC45; DT_SESSION_ID=88cd2088-fb27-4af7-aadd-5a0fa9f0eb96',
            'Origin': 'http://172.16.82.132',
            'Pragma': 'no-cache',
            'Referer': 'http://172.16.82.132/stream/',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
            'X-Project-ID': '13'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)


def stream_5_1_x_resource():

    url = "http://172.16.82.132/api/streamapp/service/streamCatalogue/getCatalogue"

    payload = "{\"nodePid\":97,\"catalogueType\":\"ResourceManager\",\"isGetFile\":true}"
    headers = {
        'Accept': '*/*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'text/plain;charset=UTF-8',
        'Cookie': 'track_rdos=true; tag_is_iframe=0; tag_project_id=221; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2023-03-02+14%3A09%3A51; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3Nzk5NjU5MSwiaWF0IjoxNjc3NDc4MTk1fQ.97mdwCuHWCvjVB59q8Vr8-1aR_5k_ysGQRKRdWi-vrQ; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=3F3850A437889B197A490D0CE2B4AC45; DT_SESSION_ID=88cd2088-fb27-4af7-aadd-5a0fa9f0eb96',
        'Origin': 'http://172.16.82.132',
        'Pragma': 'no-cache',
        'Referer': 'http://172.16.82.132/stream/',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
        'X-Project-ID': '13'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)

    data = response_text['data']['children']
    print(type(data))

    for _ in data:

        url = "http://172.16.82.132/api/streamapp/service/streamResource/deleteResource"

        payload = "{\"resourceId\":%s}" % _['id']
        headers = {
            'Accept': '*/*',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
            'Content-Type': 'text/plain;charset=UTF-8',
            'Cookie': 'track_rdos=true; tag_is_iframe=0; tag_project_id=221; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2023-03-02+14%3A09%3A51; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3Nzk5NjU5MSwiaWF0IjoxNjc3NDc4MTk1fQ.97mdwCuHWCvjVB59q8Vr8-1aR_5k_ysGQRKRdWi-vrQ; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=3F3850A437889B197A490D0CE2B4AC45; DT_SESSION_ID=88cd2088-fb27-4af7-aadd-5a0fa9f0eb96',
            'Origin': 'http://172.16.82.132',
            'Pragma': 'no-cache',
            'Referer': 'http://172.16.82.132/stream/',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
            'X-Project-ID': '13'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)

# stream_5_1_x_resource()
