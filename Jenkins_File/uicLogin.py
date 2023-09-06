# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/4/14 11:57
# @Author : FanShu
# @Site :
# @File : uicLogin.py
# @Software: PyCharm


def uic_user_create():
    import requests

    url = "http://172.16.101.181/api/publicService/userCenter/tenant/7246/add-user"
    headers = {
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json;charset=UTF-8',
        'Cookie': 'JSESSIONID=E54C75BC5B546543E7878C33C459307C; dt_expire_cycle=0; dt_user_id=6380; dt_username=admin%40dtstack.com; dt_jump_path=%2F%23%2Fproducts; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2023-04-17+14%3A55%3A14; dt_tenant_id=7246; dt_tenant_name=%E6%95%B0%E6%A0%88%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiI3MjQ2IiwidXNlcl9pZCI6IjYzODAiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MTQ1NjAzNCwiaWF0IjoxNjgxNDU1MzQyfQ.BowHp0bxK2GwuLoBxcQzod3rEZxm6uw6sEJ-tEZcwJI; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; DT_SESSION_ID=5ab56f43-00ed-4f47-97dd-c7cf048667c6',
        'Origin': 'http://172.16.101.181',
        'Pragma': 'no-cache',
        'Referer': 'http://172.16.101.181/publicService/',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
        'X-Custom-Header': 'dtuic'
    }

    base = 164
    for _ in range(37):
        payload = "{\"username\":\"dtstream%s\",\"fullName\":\"dtstream%s\",\"password\":\"admin123\",\"ldapUserName\":\"\",\"userTime\":\"2025-04-14\",\"productCodeList\":[\"RDOS\"],\"subProductCodeList\":[1,2,4,5,7,19,21,23],\"expand\":{}}" % (
        base, base)
        response = requests.request("POST", url, headers=headers, data=payload)
        base = base + 1
        import time
        time.sleep(1)
        print(response.text)


def open_txt():

    user_name = "dtstream"
    password = "0460056b01944ff1bcb35ef02791bc2fb973396af43a48242831ea9e2d9438516fe5c7471ddf1e363d2a7f08a6a493497a9ee889af0ddb673dd79eab40324b6fd6f6adb9b43cf917d755439ae0792664c30906de46572e492ec41b1c12b1fbae2e4104a7cb157729b4"

    filename = "/Users/four/Downloads/性能场景整理/loginUic1.txt"

    with open(filename, 'w+') as out:
        for _ in range(1, 201):
            out.write(f"{user_name+str(_)},{password}," + '\n')
        out.close()

open_txt()
