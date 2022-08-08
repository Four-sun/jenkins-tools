# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/6/10 2:25 下午
# @Author : FanShu
# @Site :
# @File : baseline.py
# @Software: PyCharm
import time

timeList = ['2022-06-10 14:26:46', '2022-06-10 14:26:46', '2022-06-10 14:26:36', '2022-06-10 14:26:28',
            '2022-06-10 14:26:23', '2022-06-10 14:26:10', '2022-06-10 14:26:10', '2022-06-10 14:26:03',
            '2022-06-10 14:25:53', '2022-06-10 14:24:31''2022-06-10 14:24:27', '2022-06-10 14:24:18',
            '2022-06-10 14:22:37', '2022-06-10 14:22:11', '2022-06-10 14:12:15',
            ]


def unix_time(dt):
    # 转换成时间数组
    timeArray = time.strptime(dt, "%Y-%m-%d %H:%M:%S")
    # 转换成时间戳
    timestamp = int(time.mktime(timeArray))
    return timestamp


def custom_time(timestamp):
    # 转换成localtime
    time_local = time.localtime(timestamp)
    # 转换成新的时间格式(2016-05-05 20:28:54)
    dt = time.strftime("%Y-%m-%d %H:%M:%S", time_local)
    return dt


def for_time(time_list):
    # 计算所有值最后除时间的个数
    result = 0
    for _ in time_list:
        unix_t = unix_time(_)
        result += int(unix_t)
    cut_results = custom_time(int(result / len(timeList)))
    return cut_results


times = for_time(timeList)
print(times)
