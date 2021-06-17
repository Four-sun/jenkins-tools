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

send_time = time.strftime("%Y-%m-%d-%H_%M_%S", time.localtime(time.time()))  # 获取当前时间


def send_requests(s, data, cookie=None, ):
    """封装requests请求"""
    method = data["method"]
    description = data["description"]
    url = data["url"]
    # url后面的params参数d
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
    type = data["type"]

    test_nub = data['caseid']

    print("-------------正在执行用例：%s 描述：%s  -------------" % (test_nub, description))
    print("%s\n 请求头部：%s \n 请求方式：%s\n 请求url:%s \n 请求参数：%s" % (send_time, headers, method, url, params))

    # post请求body内容
    try:
        bodydata = eval(data["body"])
    except:
        bodydata = {}

    # post上传files内容
    try:
        files = eval(data["files"])
    except:
        files = {}

    # 判断传data数据还是json
    if type == "data":
        body = bodydata
    elif type == "json":
        body = json.dumps(bodydata)
    else:
        body = bodydata

    if method == "post":

        if type == "files":
            print("%s\n post请求body类型为：%s \tfiles内容为：%s" % (send_time, type, files))
        else:
            print("%s\n post请求body类型为：%s \tbody内容为：%s" % (send_time, type, body))

    verify = False  # 是否检验
    res = {}  # 接受返回数据

    try:
        r = s.request(method=method,
                      cookies=cookie,
                      url=url,
                      params=params,
                      headers=headers,
                      data=body,
                      verify=verify)
        print("页面返回信息：%s" % r.content.decode("utf-8"))
        res["statuscode"] = str(r.status_code)  # 状态码转成str
        res["text"] = r.content.decode("utf-8")
        res["times"] = str(r.elapsed.total_seconds())  # 接口请求时间转str
        if res["statuscode"] != "200":
            res["error"] = res["text"]
            return False
        else:
            res["error"] = ""
        res["msg"] = ""
        if data["checkpoint"] in res["text"]:
            res["result"] = "pass"
            res["text"] = r.content.decode("utf-8")
            print("%s \t接口请求时间：%ss \t用例测试结果:%s---->%s " % (send_time, res["times"], test_nub, res["result"]))
            return True
        else:
            res["result"] = "fail"
            print("%s \t 接口请求时间：%ss \t用例测试结果:%s---->%s  %s Not in %s" % (
                send_time, res["times"], test_nub, res["result"], data["checkpoint"], res["text"]))
            return False

    except Exception as msg:
        res["msg"] = str(msg)
        return res


# if __name__ == "__main__":
# s = requests.session()
# r = s.request(method='GET',
#               cookies=None,
#               url='https://httpbin.org/get',
#               params=None,
#               headers=None,
#               data=None,
#               verify=None)
# print(r)
# req = requests.request('GET', 'https://httpbin.org/get')
# print(req)


data = {'writer_name': 'mysqlwriter', 'username': 'test', 'password': 'Abc123456',
        'host': '172.16.100.186',
        'port': '3306', 'db_name': 'test', 'jdbcUrl': 'jdbc:mysql://172.16.100.186:3306/test',
        'table': 'streamFactorOne', 'writeMode': 'insert', 'reader_count': 100,
        'field_count': 100}

print(data["writer_name"])



