# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/6/13 10:43 下午
# @Author : FanShu
# @Site :
# @File : Part_6.py
# @Software: PyCharm
#
# def heightChecker(heights):
#     # sorted_heights = sorted(heights)
#     # heights_error = 0
#     # for i in range(len(heights)):
#     #     if heights[i] != sorted_heights[i]:
#     #         heights_error += 1
#     #         print(heights_error)
#     # return heights_error
#     print(zip(heights, sorted(heights)))
#     case = sum(1 for x, y in zip(heights, sorted(heights)) if x != y)
#     print(case)
#     return case
import re

h = [1, 5, 3, 4, 4, 8, 10]

# heightChecker(h)
#
# import datetime
# import time
#
# class TimeUtils:
#     def __init__(self):
#         self._today = datetime.date.today()
#         self._yesterday = self._today - datetime.timedelta(days=1)
#         self._tomorrow = self._today + datetime.timedelta(days=1)
#         self._acquire = self._today + datetime.timedelta(days=2, seconds=60)
#         self._current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
#         self._three_mins_later = (datetime.datetime.now()+datetime.timedelta(minutes=5)).strftime("%H:%M")
#         self._now = time.strftime("%H:%M:%S", time.localtime(time.time()))
#         self._MM = datetime.datetime.now().strftime("%M")
#         self._HH = datetime.datetime.now().strftime("%H")
#
#
# if __name__ == '__main__':
#     _min_later = (datetime.datetime.now()+datetime.timedelta(minutes=5)).strftime("%H:%M")
#     print(datetime.datetime.now().strftime("%Y-%m-%d 00:00:00"))


# sum = 0
# for i in range(100):
#     if (i%10):   # 为true才进行瞎买呢sum自增0，10，20这些都是为true的。1-9的都是有余数的为false直接continue继续for循环了
#         continue
#     print(i)
#     sum =sum+i
#
# print(sum)  # 这里是sum自增0，10，20到90的总数和

c = [{'alertGateType': 3, 'alertGateSource': 'default_DINGDING_3', 'alertGateName': '钉钉'},
     {'alertGateType': 2, 'alertGateSource': 'default_MAIL_2', 'alertGateName': '邮箱'},
     {'alertGateType': 1, 'alertGateSource': 'default_SMS_1', 'alertGateName': '短信'},
     {'alertGateType': 4, 'alertGateSource': 'test_bug', 'alertGateName': 'test_bug'},
     {'alertGateType': 4, 'alertGateSource': 'daji_zdy', 'alertGateName': 'daji_zdy'}]
sender_types = (x['alertGateSource'] for x in c if
                x['alertGateName'] == "邮箱")
# print('sender_types', str(list(sender_types)[-1]))

# rex = "-- name BUGFIX_42277\n-- type Spark SQL\n-- author admin@dtstack.com\n-- create time 2022-02-07 16:26:08\n-- desc Lateral view explodey用法\n\nDROP TABLE if EXISTS sparksql_BUGFIX_42277;\n\nCREATE TABLE if NOT EXISTS sparksql_BUGFIX_42277\nAS SELECT\n cast(fo AS bigint) AS fo,\n bar \nFROM\n (SELECT\n '1,2,3,4,5' AS foo,\n 'bar' AS bar ) table1 LATERAL VIEW explode(split(foo,\n ',')) table2 AS `fo`;\n\nSELECT * FROM sparksql_BUGFIX_42277;"
#
# matchobj = re.sub(r'--.*\n', "", rex)
# print(matchobj)
#
# match_search = re.search(r'--', rex)
#
# if match_search:
#     print(match_search)

n = int(input("输入人数n："))
m = int(input("输入报数m："))

j = n
k, p = 1, 0
a = [0] * 100
for i in range(n - 1):
    a[i] = i + 1
    a[n - 1] = 0

print("依次出圈的人编号为：")

while p < n - 1:
    while k < m:
        j = a[j]
        k += 1
    print(a[j], end="")
    p += 1
    a[j] = a[a[j]]
    k = 1
