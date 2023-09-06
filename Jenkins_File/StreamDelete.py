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
      # 'If-None-Match': '5.1.0-stream1655749127174',
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
            # 'If-None-Match': '5.1.0-stream1655749127174',
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
    cookie = "dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-08-21+15%3A16%3A24; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5Mjg2MTM4NCwiaWF0IjoxNjkyMzQyOTkwfQ.i6MV9z9gCOdgIxT8Z1hPuLr-LFMNluG4eOSLrtOJykI; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; JSESSIONID=8D38931F0D4E4DF26E1E08A58819BABB; DT_SESSION_ID=eb54e50b-430b-47bc-8feb-0fe4c31723f3"
    payload = "{\"nodePid\":79,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
    headers = {
      'Accept': '*/*',
      'Accept-Language': 'zh-CN,zh;q=0.9',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'text/plain;charset=UTF-8',
      'Cookie': cookie,
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
          'Cookie': cookie,
          # 'If-None-Match': '5.2.0-beta2-stream1657141497500',
          'Origin': 'http://172.16.101.201',
          'Pragma': 'no-cache',
          'Referer': 'http://172.16.101.201/stream/',
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
          'X-Project-ID': '11'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)

def delete_5_3():

    url = "http://172.16.82.4/api/streamapp/service/streamCatalogue/getCatalogue"
    cookie = 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-09-08+10%3A37%3A05; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5NDM5OTgyNSwiaWF0IjoxNjkzODgxNDM1fQ.AhjEwy2X47gc0vYdtRTsHIVKi5-7nORl7jUYcxLA9g4; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; JSESSIONID=AA0B7EC444F23FD88943EF899BF71047; DT_SESSION_ID=cec5bd8d-d9c8-4e73-bacd-9f68ed13b739'

    payload = "{\"nodePid\":79,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
    headers = {
        'Accept': '*/*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'text/plain;charset=UTF-8',
        'Cookie': cookie,
        # 'If-None-Match': '5.2.0-stream1665429061881',
        'Origin': 'http://172.16.82.4',
        'Pragma': 'no-cache',
        'Referer': 'http://172.16.82.4/stream/',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36',
        'X-Project-ID': '11'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)

    data = response_text['data']['children']
    print(data)


    for _ in range(len(data)):
        url = "http://172.16.82.4/api/streamapp/service/streamTask/deleteTask"

        payload = "{\"id\":%s}" % data[_]['id']
        headers = {
          'Accept': '*/*',
          'Accept-Language': 'zh-CN,zh;q=0.9',
          'Cache-Control': 'no-cache',
          'Connection': 'keep-alive',
          'Content-Type': 'text/plain;charset=UTF-8',
          'Cookie': cookie,
          # 'If-None-Match': '5.2.0-stream1665429061881',
          'Origin': 'http://172.16.82.4',
          'Pragma': 'no-cache',
          'Referer': 'http://172.16.82.4/stream/',
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36',
          'X-Project-ID': '11'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)


def delete_6_0():
    import requests

    Cookie = 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-07-28+14%3A29%3A25; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; JSESSIONID=9E1626DEB08518FAB503D66ECB7CDA86; dt_tenant_id=10449; dt_tenant_name=DT_demo_hadoop2; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxMDQ0OSIsInVzZXJfaWQiOiIxIiwidXNlcl9uYW1lIjoiYWRtaW5AZHRzdGFjay5jb20iLCJleHAiOjE2OTEwNDQxNjUsImlhdCI6MTY5MDQ0MTczN30.FXFv6XmqHhz1qytpl9cR9emvEDdRFF626D2uN5SV_YE; dt_is_tenant_admin=true; dt_is_tenant_creator=true; DT_SESSION_ID=21e79ed0-ac94-460b-b1b7-f19b418cdee8'

    url = "http://172.16.100.108/api/streamapp/service/streamCatalogue/getCatalogue"

    payload = "{\"nodePid\":241,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
    headers = {
        'Accept': '*/*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'text/plain;charset=UTF-8',
        # 'If-None-Match': '6.0.5-stream1684354720182',
        'Cookie' : Cookie,
        'Origin': 'http://172.16.100.108',
        'Pragma': 'no-cache',
        'Referer': 'http://172.16.100.108/stream/',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
        'X-Project-ID': '31'
    }


    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)
    print(response_text)
    data = response_text['data']['children']

    for _ in range(len(data)):
        import requests

        url = "http://172.16.100.108/api/streamapp/service/streamTask/deleteTask"

        payload = "{\"id\":%s}" % data[_]['id']
        headers = {
            'Accept': '*/*',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
            'Content-Type': 'text/plain;charset=UTF-8',
            'Cookie': Cookie,
            # 'Cookie': 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-06-05+16%3A28%3A59; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=10449; dt_tenant_name=DT_demo_hadoop2; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxMDQ0OSIsInVzZXJfaWQiOiIxIiwidXNlcl9uYW1lIjoiYWRtaW5AZHRzdGFjay5jb20iLCJleHAiOjE2ODYyMTI5MzksImlhdCI6MTY4NTY5NDU0Nn0.TTmF_fpiIze9jFciMrelIZCb20bZIMF7jP1mQIm2Xo4; dt_is_tenant_admin=true; dt_is_tenant_creator=true; JSESSIONID=B4EB995A85353C0C88FF09F17EF651B9; DT_SESSION_ID=b4053e17-986d-49ea-b8f9-a0a13a286d54',
            # 'If-None-Match': '6.0.5-stream1684354720182',
            'Origin': 'http://172.16.100.108',
            'Pragma': 'no-cache',
            'Referer': 'http://172.16.100.108/stream/',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36',
            # 'X-Project-ID': '31'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)


def delete_6_1():
    import requests

    url = "http://172.16.101.247/api/streamapp/service/streamCatalogue/getCatalogue"
    cookie = "dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2023-07-28+19%3A57%3A44; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5MDgwNDY2NCwiaWF0IjoxNjkwMjg2MjY4fQ.Tz6s7QNobg7iqvIktBDo8a1_WJXm7caOeFOS5-lJdRE; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=78BAE18F46C8A4B81B6B8D20C88B575D; DT_SESSION_ID=d7b0b8e8-4b03-49a5-b101-e31bb6cbda77"
    payload = "{\"nodePid\":155,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
    headers = {
        'Accept': '*/*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'text/plain;charset=UTF-8',
        'Cookie': cookie,
        'If-None-Match': '6.1.0-beta2-stream1684204558398',
        'Origin': 'http://172.16.101.247',
        'Pragma': 'no-cache',
        'Referer': 'http://172.16.101.247/stream/',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
        'X-Project-ID': '19'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    response_text = json.loads(response.text)
    print(response_text)
    data = response_text['data']['children']

    for _ in range(len(data)):

        url = "http://172.16.101.247/api/streamapp/service/streamTask/deleteTask"
        payload = "{\"id\":%s}" % data[_]['id']
        headers = {
          'Accept': '*/*',
          'Accept-Language': 'zh-CN,zh;q=0.9',
          'Cache-Control': 'no-cache',
          'Connection': 'keep-alive',
          'Content-Type': 'text/plain;charset=UTF-8',
            'Cookie': cookie,
            'If-None-Match': '6.1.0-beta2-stream1684204558398',
          'Origin': 'http://172.16.101.247',
          'Pragma': 'no-cache',
          'Referer': 'http://172.16.101.247/stream/',
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
          'X-Project-ID': '19'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)


if __name__ == '__main__':

    delete_5_3()
