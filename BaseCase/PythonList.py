# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2020/9/19 14:35
# @Author : FanShu
# @Site :
# @File : PythonList.py
# @Software: PyCharm
import sys
import os
import time

name1 = '10.3.9.12'

def func1(name):

    list1 = name.split('.')
    print(list1)

    li = [bin(int(i)) for i in list1]

    print(li)

    li2 = [i.replace('0b',((10-len(i))*'0')) for i in li]
    print(li2)

    return str(' '.join(li2))
# func1 = func1(name1)
# print(func1)

class BatchTaskStatus:
    UNSUBMIT = 0
    CREATE = 1
    SCHEDULED = 2
    DEPLOYING = 3
    RUNNING = 4
    FINISHED = 5
    CANCELING = 6
    CANCELED = 7
    FAILED = 8
    SUBMITFAILD = 9
    SUBMITTING = 10
    RESTARTING = 11
    MANUALSUCCESS = 12
    KILLED = 13
    SUBMITTED = 14
    NOTFOUND = 15
    WAITENGINE = 16
    WAITCOMPUTE = 17
    FROZEN = 18
    ENGINEACCEPTED = 19
    ENGINEDISTRIBUTE = 20
    PARENTFAILED = 21
    FAILING = 22
    COMPUTING = 23
    EXPIRE = 24
    LACKING = 25
    AUTOCANCELED = 26

continue_status = [BatchTaskStatus.RUNNING, BatchTaskStatus.WAITENGINE]
fail_status = [BatchTaskStatus.FAILED]
success_status = [BatchTaskStatus.FINISHED]
task_status = True
count = 0
while count < 3:
    time.sleep(1)
    count += 1
    status = 8
    if status in continue_status:
        continue
    if task_status:
        if status in success_status:
            print(status)
            print("任务运行成功")
        else:
            print(status)
            print("失败")
    else:
        if status in fail_status:
            print("任务运行成功")
            print(status)
        else:
            print(status)
            print("失败")
    break
