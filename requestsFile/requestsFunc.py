# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/3 7:29 下午
# @Author : FanShu
# @Site : 
# @File : requestsFunc.py
# @Software: PyCharm
import json
import time
import requests
from faker import Faker

fake = Faker()
send_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))  # 获取当前时间
timeArray = time.strptime(send_time, "%Y-%m-%d %H:%M:%S")
timeStamp = int(time.mktime(timeArray))

print(timeStamp)
task_id = '%s%s'.format(fake.safe_color_name(), fake.ean(length=8))


def send_requests(session, data=None, cookie=None):
    """
    :param session: 请求Session值
    :param data: 传入请求数据
    :param cookie: cookie值
    :return:
    """
    method = data["method"].lower()
    url = data["url"]

    # url后面的params参数
    try:
        params = eval(data["params"])
    except:
        params = None

    # 请求头部headers
    try:
        headers = eval(data["headers"])
    except:
        headers = None

    # post请求body类型
    try:
        type = data["type"].lower()
    except:
        type = None

    # post请求body内容
    try:
        bodydata = data["body"]
    except:
        bodydata = {}

    # 判断传data数据还是json
    if type == "data":
        body = bodydata
    elif type == "json":
        body = json.dumps(bodydata)
    else:
        body = bodydata

    verify = False  # 是否检验
    res = {}  # 接受返回数据
    print(" %s\n 请求头部：%s \n 请求方式：%s\n 请求url:%s \n 请求参数：%s" % (send_time, headers, method, url, bodydata))

    try:
        r = session.request(method=method,
                            cookies=cookie,
                            url=url,
                            params=params,
                            headers=headers,
                            data=body,
                            verify=verify)
        res["code"] = str(r.status_code)  # 状态码转成str
        res["text"] = r.content
        res["times"] = str(r.elapsed.total_seconds())  # 接口请求时间转str
        res["cookies"] = r.cookies
        if res["code"] != "200":
            res["error"] = res["text"]
            raise False
        else:
            res["error"] = ""
        return res
    except Exception as msg:
        res["msg"] = msg
        raise res


# if __name__ == "__main__":
# s = requests.session()

# url = 'http://172.16.23.228:8090'
# headers = '{"Content-Type": "application/json"}'
# start_url = url + '/node/action/start'
# stop_url = url + '/node/action/stop'
#
# create_data = {
#     'taskId': '%s' % task_id, 'name': 'runJob_rsun_sync_task_streamOracleOne_1623971062653_20210618070422',
#     'taskType': 2, 'engineType': 'flink', 'computeType': 1, 'sqlText': '', 'taskParams': 'mr.job.parallelism = 1',
#     'exeArgs': '-jobid runJob_run_sync_task_streamOracleOne_1623971062653_20210618070422 -job %7B%22job%22%3A%7B%22content%22%3A%5B%7B%22reader%22%3A%7B%22parameter%22%3A%7B%22column%22%3A%5B%7B%22name%22%3A%22ID%22%2C%22type%22%3A%22id%22%7D%2C%7B%22name%22%3A%22FACTOR_1%22%2C%22type%22%3A%22float%22%7D%2C%7B%22name%22%3A%22FACTOR_2%22%2C%22type%22%3A%22float%22%7D%2C%7B%22name%22%3A%22FACTOR_3%22%2C%22type%22%3A%22string%22%7D%2C%7B%22name%22%3A%22FACTOR_4%22%2C%22type%22%3A%22timestamp%22%7D%2C%7B%22name%22%3A%22FACTOR_5%22%2C%22type%22%3A%22timestamp%22%7D%2C%7B%22name%22%3A%22FACTOR_6%22%2C%22type%22%3A%22timestamp%22%7D%2C%7B%22name%22%3A%22FACTOR_7%22%2C%22type%22%3A%22timestamp%22%7D%2C%7B%22name%22%3A%22FACTOR_8%22%2C%22type%22%3A%22string%22%7D%2C%7B%22name%22%3A%22FACTOR_9%22%2C%22type%22%3A%22date%22%7D%5D%2C%22sliceRecordCount%22%3A%5B100%5D%7D%2C%22name%22%3A%22streamreader%22%7D%2C%22writer%22%3A%7B%22parameter%22%3A%7B%22postSql%22%3A%5B%5D%2C%22password%22%3A%22oracle%22%2C%22column%22%3A%5B%7B%22name%22%3A%22ID%22%2C%22type%22%3A%22NUMBER%22%7D%2C%7B%22name%22%3A%22FACTOR_1%22%2C%22type%22%3A%22FLOAT%22%7D%2C%7B%22name%22%3A%22FACTOR_2%22%2C%22type%22%3A%22FLOAT%22%7D%2C%7B%22name%22%3A%22FACTOR_3%22%2C%22type%22%3A%22VARCHAR2%22%7D%2C%7B%22name%22%3A%22FACTOR_4%22%2C%22type%22%3A%22TIMESTAMP%286%29%22%7D%2C%7B%22name%22%3A%22FACTOR_5%22%2C%22type%22%3A%22TIMESTAMP%286%29%22%7D%2C%7B%22name%22%3A%22FACTOR_6%22%2C%22type%22%3A%22TIMESTAMP%286%29%22%7D%2C%7B%22name%22%3A%22FACTOR_7%22%2C%22type%22%3A%22TIMESTAMP%286%29%22%7D%2C%7B%22name%22%3A%22FACTOR_8%22%2C%22type%22%3A%22VARCHAR2%22%7D%2C%7B%22name%22%3A%22FACTOR_9%22%2C%22type%22%3A%22DATE%22%7D%5D%2C%22connection%22%3A%5B%7B%22schema%22%3A%22ORACLE%22%2C%22jdbcUrl%22%3A%22jdbc%3Aoracle%3Athin%3A%40172.16.100.243%3A1521%3Aorcl%22%2C%22table%22%3A%5B%22SIDETESTONE%22%5D%7D%5D%2C%22writeMode%22%3A%22insert%22%2C%22batchSize%22%3A1024%2C%22username%22%3A%22oracle%22%2C%22preSql%22%3A%5B%5D%7D%2C%22name%22%3A%22oraclewriter%22%7D%7D%5D%2C%22setting%22%3A%7B%22restore%22%3A%7B%22maxRowNumForCheckpoint%22%3A0%2C%22isRestore%22%3Afalse%2C%22restoreColumnName%22%3A%22%22%2C%22restoreColumnIndex%22%3A0%7D%2C%22log%22%3A%7B%22path%22%3A%22%22%2C%22level%22%3A%22debug%22%2C%22pattern%22%3A%22%22%2C%22isLogger%22%3Afalse%7D%2C%22errorLimit%22%3A%7B%22record%22%3A100%7D%2C%22speed%22%3A%7B%22bytes%22%3A0%2C%22channel%22%3A1%7D%7D%7D%7D',
#     'requestStart': 0, 'sourceType': 2, 'priority': 0, 'generateTime': 1623971062668, 'maxRetryNum': 0, 'stopJobId': 0,
#     'lackingCount': 0, 'tenantId': 1101, 'dtuicTenantId': 0, 'deployMode': '2', 'appType': 1, 'submitExpiredTime': 0,
#     'componentVersion': '1.10', 'taskSourceId': 5805, 'businessDate': '20210617070422', 'cycTime': '20210618070422',
#     'isFailRetry': False
# }
#
# stop_data = {
#     'jobIds': ['%s' % task_id]
# }

# startTask = s.request(method="post",
#                       url=start_url,
#                       headers={"Content-Type": "application/json"},
#                       data=json.dumps(create_data))

# stopTask = s.request(method="post",
#                      url=stop_url,
#                      headers={"Content-Type": "application/json"},
#                      data=json.dumps(stop_data))

# print(startTask.content.decode("utf-8"))
# time.sleep(5)
# print(stopTask.content.decode("utf-8"))


# data = {'method': 'post', 'url': start_url, 'type': 'json', 'body': create_data, 'headers': headers}
#
# req = send_requests(s, data=data)
# print(req)

session = requests.session()


def login():
    url = 'http://172.16.23.228:8006/uic/api/v2/account/login'
    headers = "{'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'}"
    body = "username=admin%40dtstack.com&password=iSTKGjbPmoDjzxPWbaQD3sZczty%2FunqLuT%2F9Y%2Fnd8b9zv2hqjf8hzYlHMtPiqfhjW1ZTKUQjZ7kpb24D8HQVN7aEQqzcw6vW5gwLBESR%2FN5PniDEkEhgf8NHyXLC80egrR9O7KiXAXyhwnsWoV3EVyu0iONwmF1Q9A2kaym6JQw%3D&verify_code=123"
    bodyData = {'method': 'post', 'url': url, 'body': body, 'headers': headers}
    req = send_requests(session, data=bodyData)
    req_text = json.loads(req['text'])
    if req_text['success']:
        req_cookies = dict(dt_token=req['cookies']['dt_token'])
    else:
        req_cookies = dict(dt_token=req['cookies'])
        raise req_cookies
    print(req_text, "\n", req_cookies)
    return req_cookies


def get_uic_tenantId():
    url = 'http://172.16.23.228:8006/uic/api/v2/account/user/get-full-tenants-by-name?'
    params = "{'tenantName': 'DTStream'}"
    bodyData = {'method': 'get', 'url': url.strip(), 'params': params}
    req = send_requests(session, data=bodyData, cookie=login_cookies)
    req_text = json.loads(req['text'])
    if len(req_text['data']):
        result = dict(tenantId=req_text['data'][-1]['tenantId'])
    else:
        result = req_text
        raise result
    return result

login_cookies = login()


get_uic_tenantId()





