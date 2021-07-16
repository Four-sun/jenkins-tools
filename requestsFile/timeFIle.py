# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/18 12:01 下午
# @Author : FanShu
# @Site : 
# @File : timeFIle.py
# @Software: PyCharm
import json
import time
import requests
from faker import Faker

# send_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))  # 获取当前时间
# localTime = time.strftime("%Y%m%d%H%M%S", time.localtime(time.time()))  # 获取当前时间
# timeArray = time.strptime(send_time, "%Y-%m-%d %H:%M:%S")
# timeStamp = int(time.mktime(timeArray))

# print(send_time, timeStamp, localTime)


def current_time():
    """
    :return: 毫秒级时间戳
    """
    currentTime = int(round(time.time() * 1000))
    return currentTime


def current_datetime():
    """
    :return: 获取当前时间
    """
    dateTime = time.strftime("%Y%m%d%H%M%S", time.localtime(time.time()))
    return dateTime


def current_timestamp():
    """
    :return: 获取当前时间
    """
    timeStamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))
    return timeStamp


# print(current_time(), current_datetime(), current_timestamp())
print('[test].[fanshuTestOne]'.replace('[', '').replace(']', ''))
