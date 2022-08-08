# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/7/21 5:45 下午
# @Author : FanShu
# @Site :
# @File : jsonDump.py
# @Software: PyCharm

import json
import sys


def jsonLoad():
    """
    :param jsonFile: 读取Json文件路径
    :return: 编码Json数据读取Json文件
    """
    try:
        jsonFile = '/Users/four/Downloads/four_git/jenkins-tools/jenkins-tools/DtBatchApp/package.json'
        with open(jsonFile, 'r') as jsonLoads:
            dict_str = json.load(jsonLoads)
        return dict_str
    except Exception as Error:
        return Error

# insert_sql = json.loads('{"vertex": true, "edge": false, "data": {"id": 10107, "name": "flow162867841651447", "type": "file", "taskType": 0, "parentId": 17215, "catalogueType": "TaskDevelop", "nodePid": 17215, "submitStatus": 0, "version": 0, "readWriteLockVO": {"result": 0, "gmtModified": 1628678412246, "getLock": true, "isDeleted": 0, "lastKeepLockUserName": "admin@dtstack.com", "modifyUserId": 5, "relationId": 10107, "id": 10183, "type": "BATCH_TASK", "lockName": "10107_857_BATCH_TASK", "version": 1}}, "x": 1000, "y": 100, "value": "null", "id": 10107}')
#
# nodePid = 40779
# taskValues = jsonLoad()
# data = taskValues
# x_path = 800
# y_path = 0
# dependency_id = insert_sql['id'] + 1
#
# case = {'vertex': False, 'edge': True, 'x': 0, 'y': 0, 'value': None, 'id': f'{dependency_id}', 'source': data[-1], 'target': insert_sql}


# json_values = {'vertex': True, 'edge': False, 'data':
#     {'id': data['id'], 'name': data['name'], 'type': data['type'], 'taskType': data['taskType'],
#      'parentId': data['parentId'], 'catalogueType': data['catalogueType'], 'nodePid': nodePid,
#      'submitStatus': data['submitStatus'], 'version': data['version'],
#      'readWriteLockVO': data['readWriteLockVO']}, 'x': x_path, 'y': y_path, 'value': 'null', 'id': data['id']}
# value_dumps = json.dumps(json_values)
#
# value_double_dumps = json.dumps(value_dumps)
# print(value_double_dumps)


# height = 5
# width = 2
# total = int(height * width)
# c = 0
# x = 0
# list_null = []
# for w in range(width):
#     list_null.append([])
#     for h in range(height):
#         list_null[w].append(h)



import requests

# url = "http://rdos.dtstack.insightci.top/api/streamapp/service/streamTask/deleteTask"
#
# payload = "{\"id\":7047}"
#

# response = requests.request("POST", url, headers=headers, data=payload)
#
# print(response.text)



# import requests
#
# url = "http://rdos.dtstack.insightci.top/api/streamapp/service/streamCatalogue/getCatalogue"
#
# payload = "{\"nodePid\":5727,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
# headers = {
#   'Connection': 'keep-alive',
#   'Pragma': 'no-cache',
#   'Cache-Control': 'no-cache',
#   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36',
#   'X-Project-ID': '837',
#   'Content-Type': 'text/plain;charset=UTF-8',
#   'Accept': '*/*',
#   'Origin': 'http://rdos.dtstack.insightci.top',
#   'Referer': 'http://rdos.dtstack.insightci.top/stream/',
#   'Accept-Language': 'zh-CN,zh;q=0.9',
#   'Cookie': 'dt_product_code=RDOS; dt_can_redirect=true; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%7D; dt_user_id=1; dt_username=admin%40dtstack.com; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY0NDQwMDU4NCwiaWF0IjoxNjI4ODQ4NTg0fQ.9_h09CjhanD6AMrpqRyWj3GYyV6nKSWviUbj2HS2Obs; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_is_tenant_admin=true; dt_is_tenant_creator=true; dt_cookie_time=2021-08-16+17%3A56%3A24; track_rdos=true; science_project_id=1149; JSESSIONID=6922F442B4F66ABCDFA3A565F113F199; DT_SESSION_ID=f05ce859-f0c9-4047-acc9-ecec8d50ff2d'
# }
#
# response = requests.request("POST", url, headers=headers, data=payload)
#
# json_load = json.loads(response.text)['data']['children']
#
# print(len(json_load))
# for _ in json_load:
#     print(_['id'])
#     url = "http://rdos.dtstack.insightci.top/api/streamapp/service/streamTask/deleteTask"
#
#     payload = "{\"id\":%s}" % _['id']
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)
#
#

# import requests
#
# url = "http://uic.dtinsight.com/api/streamapp/service/streamCatalogue/getCatalogue"
#
# payload = "{\"nodePid\":317,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}"
# headers = {
#   'Connection': 'keep-alive',
#   'Pragma': 'no-cache',
#   'Cache-Control': 'no-cache',
#   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36',
#   'X-Project-ID': '35',
#   'Content-Type': 'text/plain;charset=UTF-8',
#   'Accept': '*/*',
#   'Origin': 'http://uic.dtinsight.com',
#   'Referer': 'http://uic.dtinsight.com/stream/',
#   'Accept-Language': 'zh-CN,zh;q=0.9',
#   'Cookie': 'dt_language=zh; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2021-09-12+14%3A42%3A48; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY2MjI3Mzc2OCwiaWF0IjoxNjMxMTY5NzcyfQ.TToie3ZByhD5HXZ5ybmXXdm9wtjR1Gj_MEyqpgF73SA; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; JSESSIONID=B85946DE993CE3B7C636C60E6AC8B804; DT_SESSION_ID=e6ccee04-57b6-4881-89a2-4e7cefc25572'
# }
#
# response = requests.request("POST", url, headers=headers, data=payload)
#
# print(response)
# json_load = json.loads(response.text)['data']['children']
# print(response.text)
#
# print(len(json_load))
# for _ in json_load:
#     print(_['id'])
#     url = "http://uic.dtinsight.com/api/streamapp/service/streamTask/deleteTask"
#
#     payload = "{\"id\":%s}" % _['id']
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)


# import requests
#
# url = "http://rdos.dtstack.insightci.top/api/dq/service/monitorStream/add"
#
# payload = "{\"dataSourceId\":2537,\"tableName\":\"wangchuan_41\",\"charset\":\"utf-8\",\"mappingColumns\":\"id int\\nname varchar\\nage int\",\"isSubscribe\":1,\"scheduleConf\":\"{\\\"beginDate\\\":\\\"2021-09-17\\\",\\\"endDate\\\":\\\"2121-09-17\\\",\\\"periodType\\\":0,\\\"hour\\\":0,\\\"min\\\":0,\\\"beginHour\\\":0,\\\"beginMin\\\":0,\\\"endHour\\\":\\\"1\\\",\\\"endMin\\\":0,\\\"gapMin\\\":\\\"5\\\"}\",\"sendTypes\":[],\"webhook\":\"\",\"notifyUser\":[],\"rules\":[{\"isNew\":false,\"isEdit\":false,\"filter\":\"\",\"verifyType\":1,\"operator\":\"<\",\"threshold\":\"1\",\"isCustomizeSql\":0,\"level\":0,\"type\":1,\"columnName\":[\"name\"],\"functionId\":3,\"isPercentage\":0,\"ruleStrength\":1}],\"associatedTasks\":[],\"upperLimit\":9999}"
# headers = {
#   'Proxy-Connection': 'keep-alive',
#   'Pragma': 'no-cache',
#   'Cache-Control': 'no-cache',
#   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
#   'Content-Type': 'text/plain;charset=UTF-8',
#   'Accept': '*/*',
#   'Origin': 'http://rdos.dtstack.insightci.top',
#   'Referer': 'http://rdos.dtstack.insightci.top/valid/',
#   'Accept-Language': 'zh-CN,zh;q=0.9',
#   'Cookie': 'dt_product_code=RDOS; dt_language=zh; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2021-09-19+16%3A05%3A20; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DTStack%E7%A7%9F%E6%88%B7; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY2Mjg4MzUyMCwiaWF0IjoxNjMxNzc5NTMyfQ.3cmn1kv7aem-NFoD0_u77bIxxKJRgvQmkjWn4A0vTcQ; dt_is_tenant_admin=true; dt_is_tenant_creator=false; JSESSIONID=D42F9FDE07705F9CF44B7401914DC076; DT_SESSION_ID=adbeeb39-4748-4cd9-bf63-2b30fdd4a3c4; dq_project_id=43'
# }
#
# response = requests.request("POST", url, headers=headers, data=payload)
#
# print(response.text)


# print(json.dumps(json.dumps({"monitorId":12937})))
#
#
# print(json.loads('{\"isNew\":false,\"isEdit\":false,\"filter\":\"\",\"verifyType\":1,\"operator\":\"<\",\"threshold\":\"1\",\"isCustomizeSql\":0,\"level\":0,\"type\":1,\"columnName\":[\"name\"],\"functionId\":3,\"isPercentage\":0,\"ruleStrength\":1}'))
#

rule = '{"isNew":false,"isEdit":false,"filter":"","verifyType":1,"operator":"<","threshold":"1","isCustomizeSql":0,"level":0,"type":1,"columnName":["name"],"functionId":3,"isPercentage":0,"ruleStrength":1}'

def rules_cycle(times, rule):
    rules_list = []
    if rule.isdigit:
        for _ in range(times):
            print(rule.replace('"threshold":"1"', '"threshold":"%s"' % _))
            rules_list.append(rule)
        rules = ','.join(rules_list)
        print(json.dumps(rules))
        return rules

# rules_cycle(2, rule)



taskVariables = [{'paramName': 'name', 'fatherTaskId': '', 'fatherParamName': '', 'annotation': '', 'type': 5, 'id': -1, 'key': 1, 'fatherParamNameList': '', 'paramCommand': ''}]

upstream_param = {'data': [{'annotation': '', 'id': 74495, 'paramName': 'out_name', 'taskId': 37125, 'paramCommand': '1314'}]}

c_list = []
for i in range(len(taskVariables)):
    task_i = taskVariables[i]
    print(upstream_param['data'])
    if upstream_param['data'] is not None:
        up_param = upstream_param['data'][i]
        for _ in up_param:
            task_i['fatherTaskId'] = up_param['taskId']
            task_i['fatherParamName'] = up_param['paramName']
            task_i['fatherParamNameList'] = [up_param]
            task_i['paramCommand'] = up_param['paramCommand']
    print(task_i)
    c_list.append(task_i)
print(c_list)
