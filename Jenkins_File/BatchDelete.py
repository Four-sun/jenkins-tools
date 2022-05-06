# # !/usr/bin/env python
# # --- coding: utf-8 ---
# # @Time : 2022/2/23 2:26 下午
# # @Author : FanShu
# # @Site :
# # @File : BatchDelete.py
# # @Software: PyCharm
# import json
#
# import requests
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
#   'Cookie': 'dt_product_code=RDOS; dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-05-02+19%3A55%3A57; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MjMzNzM1NywiaWF0IjoxNjUxMjMzMzYyfQ.h69JTPbl2F5Bsa09RpPS6bK0nZm7l6n2RFLGt4GJXps; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=ddc2bb77-4876-4fdf-a115-ab16c43d0be1; track_rdos=true; JSESSIONID=A8912B36D3E40E523BDC3AFB81BB44F0',
#   'If-None-Match': '5.0.181650651705264',
#   'Origin': 'http://uic.insightci.cc',
#   'Pragma': 'no-cache',
#   'Referer': 'http://uic.insightci.cc/batch/',
#   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36',
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
#
# for _ in range(len(data)):
#
#
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
#         'Cookie': 'dt_product_code=RDOS; dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-05-02+19%3A55%3A57; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MjMzNzM1NywiaWF0IjoxNjUxMjMzMzYyfQ.h69JTPbl2F5Bsa09RpPS6bK0nZm7l6n2RFLGt4GJXps; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=ddc2bb77-4876-4fdf-a115-ab16c43d0be1; track_rdos=true; JSESSIONID=A8912B36D3E40E523BDC3AFB81BB44F0',
#         'If-None-Match': '5.0.181650651705264',
#         'Origin': 'http://uic.insightci.cc',
#         'Pragma': 'no-cache',
#         'Referer': 'http://uic.insightci.cc/batch/',
#         'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36',
#         'X-Project-ID': '109'
#     }
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)
#
# #
# # import requests
# #
# # url = "http://172.16.82.132/api/rdos/batch/batchCatalogue/getCatalogue"
# #
# # payload = "{\"isGetFile\":true,\"nodePid\":499,\"catalogueType\":\"TaskDevelop\"}"
# # headers = {
# #   'Accept': '*/*',
# #   'Accept-Language': 'zh-CN,zh;q=0.9',
# #   'Cache-Control': 'no-cache',
# #   'Connection': 'keep-alive',
# #   'Content-Type': 'text/plain;charset=UTF-8',
# #   'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-04-18+15%3A48%3A59; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MTExMjkzOSwiaWF0IjoxNjUwMDA4OTQ0fQ.Wxsdh6bFBp9UNSBMhJ7GAeeaaeUuh5yRdTaHWJGbmJ0; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=2df62015-f5d7-4816-9df9-8797149ae3a8; JSESSIONID=8D61F1950CBD65EBFB190850C4DDFA4F; track_rdos=true',
# #   'If-None-Match': '5.1.0-beta61649794015926',
# #   'Origin': 'http://172.16.82.132',
# #   'Pragma': 'no-cache',
# #   'Referer': 'http://172.16.82.132/batch/',
# #   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36',
# #   'X-Project-ID': '25'
# # }
# #
# # response = requests.request("POST", url, headers=headers, data=payload)
# #
# # print(response.text)
# #
# # response_text = json.loads(response.text)
# #
# # data = response_text['data']['children']
# # print(data)
# #
# #
# # for _ in range(len(data)):
# #
# #     url = "http://172.16.82.132/api/rdos/batch/batchTask/deleteTask"
# #     payload = "{\"taskId\":%s}" % data[_]['id']
# #     headers = {
# #         'Accept': '*/*',
# #         'Accept-Language': 'zh-CN,zh;q=0.9',
# #         'Cache-Control': 'no-cache',
# #         'Connection': 'keep-alive',
# #         'Content-Type': 'text/plain;charset=UTF-8',
# #         'Cookie': 'dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-04-18+15%3A48%3A59; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MTExMjkzOSwiaWF0IjoxNjUwMDA4OTQ0fQ.Wxsdh6bFBp9UNSBMhJ7GAeeaaeUuh5yRdTaHWJGbmJ0; dt_is_tenant_admin=true; dt_is_tenant_creator=false; DT_SESSION_ID=2df62015-f5d7-4816-9df9-8797149ae3a8; JSESSIONID=8D61F1950CBD65EBFB190850C4DDFA4F; track_rdos=true',
# #         'If-None-Match': '5.1.0-beta61649794015926',
# #         'Origin': 'http://172.16.82.132',
# #         'Pragma': 'no-cache',
# #         'Referer': 'http://172.16.82.132/batch/',
# #         'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36',
# #         'X-Project-ID': '25'
# #     }
# #
# #     response = requests.request("POST", url, headers=headers, data=payload)
# #
# #     print(response.text)
#
#

