# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/4/8 8:54 下午
# @Author : FanShu
# @Site :
# @File : batch_upload_file.py
# @Software: PyCharm
import requests

url = "http://uic.insightci.cc/api/rdos/upload/batch/batchPackage/uploadPackage"

payload={}
files=[
  ('packageFile',('package_import_function.zip',open('/Users/four/Downloads/自动化场景整理/package_import_function.zip','rb'),'application/zip'))
]
headers = {
  # 'Accept': '*/*',
  # 'Accept-Language': 'zh-CN,zh;q=0.9',
  # 'Cache-Control': 'no-cache',
  # 'Connection': 'keep-alive',
  # 'Cookie': 'dt_language=zh; dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; sysLoginType=%7B%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%22%2C%22sysType%22%3A0%7D; dt_cookie_time=2022-04-11+16%3A46%3A47; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MDUxMTYwNywiaWF0IjoxNjQ5NDA3NjE1fQ.hXrCSOxJREtg4nbKR2LVy0rTu03QYOhToopCekyJ_JY; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; DT_SESSION_ID=41cf0027-91af-429d-b6b7-530c9ba2372a; track_rdos=true; JSESSIONID=2C710B36940F2197B822CD93D01CD13C; JSESSIONID=47851935DEB592C5A244811CAC5CBF0A',
  'Cookie': 'dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY4MDUxMTYwNywiaWF0IjoxNjQ5NDA3NjE1fQ.hXrCSOxJREtg4nbKR2LVy0rTu03QYOhToopCekyJ_JY; ',
  # 'Origin': 'http://uic.insightci.cc',
  # 'Pragma': 'no-cache',
  # 'Referer': 'http://uic.insightci.cc/batch/',
  # 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36',
  # 'X-Project-ID': '35',
  # 'X-Requested-With': 'XMLHttpRequest'
}

# response = requests.request("POST", url, headers=headers, data=payload, files=files)
response = requests.post(url, headers=headers, data={}, files=files)

print(response.text)
