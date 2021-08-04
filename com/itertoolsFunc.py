# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/7/30 5:22 下午
# @Author : FanShu
# @Site : python内置库itertools
# @File : itertoolsFunc.py
# @Software: PyCharm


# 列表中指定数目不重复
# import itertools
# x = itertools.combinations(range(1,10), 3)
# print(list(x))


from enum import Enum


class TaskStatus(Enum):
    """
    :return 周期实例运行状态码
    """
    UNSUBMIT = 0
    CREATED = 1
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


class BatchTaskType(Enum):
    """
    :return 离线任务类型
    """
    虚节点 = -1
    SparkSQL = 0
    Spark = 1
    数据同步 = 2
    PySpark = 3
    Python = 6
    Shell = 7
    HadoopMR = 9
    工作流 = 10
    HiveSQL = 17
    InceptorSQL = 28
    ShellonAgent = 29


task_type = BatchTaskType
print(task_type(1).name)

