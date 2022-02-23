# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/2/23 2:26 下午
# @Author : FanShu
# @Site :
# @File : BatchDelete.py
# @Software: PyCharm
import json

import requests

url = "http://uic.insightci.cc/api/rdos/batch/batchCatalogue/getCatalogue"

payload = "{\"isGetFile\":true,\"nodePid\":1579,\"catalogueType\":\"TaskDevelop\"}"
headers = {
  'Connection': 'keep-alive',
  'Pragma': 'no-cache',
  'Cache-Control': 'no-cache',
  'If-None-Match': '5.0.0-beta31640898004255',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36',
  'X-Project-ID': '109',
  'Content-Type': 'text/plain;charset=UTF-8',
  'Accept': '*/*',
  'Origin': 'http://uic.insightci.cc',
  'Referer': 'http://uic.insightci.cc/batch/',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Cookie': 'dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-02-26+13%3A47%3A03; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3NjY5OTIyMywiaWF0IjoxNjQ1NTk1MjI4fQ.7d5n4Fgzs9374FrQ6eTe4xGYP6HoJ1Qe_Y2pDiIdYJs; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; track_rdos=true; JSESSIONID=68F06DC2BB0B7352B0DF1B8D7B92C95D; DT_SESSION_ID=db358da5-5afb-4b8b-a35e-921c73d4a043'
}

response = requests.request("POST", url, headers=headers, data=payload)

response_text = json.loads(response.text)

data = response_text['data']['children']
print(data)


for _ in range(len(data)):

    url = "http://uic.insightci.cc/api/rdos/batch/batchTask/deleteTask"

    payload = "{\"taskId\":%s}" % data[_]['id']
    headers = {
      'Connection': 'keep-alive',
      'Pragma': 'no-cache',
      'Cache-Control': 'no-cache',
      'If-None-Match': '5.0.0-beta31640898004255',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36',
      'X-Project-ID': '109',
      'Content-Type': 'text/plain;charset=UTF-8',
      'Accept': '*/*',
      'Origin': 'http://uic.insightci.cc',
      'Referer': 'http://uic.insightci.cc/batch/',
      'Accept-Language': 'zh-CN,zh;q=0.9',
      'Cookie': 'dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-02-26+13%3A47%3A03; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY3NjY5OTIyMywiaWF0IjoxNjQ1NTk1MjI4fQ.7d5n4Fgzs9374FrQ6eTe4xGYP6HoJ1Qe_Y2pDiIdYJs; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; track_rdos=true; JSESSIONID=68F06DC2BB0B7352B0DF1B8D7B92C95D; DT_SESSION_ID=db358da5-5afb-4b8b-a35e-921c73d4a043'
    }

    response1 = requests.request("POST", url, headers=headers, data=payload)

    print(response1.text)
