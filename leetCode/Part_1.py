# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/11 19:05
# @Author : FanShu
# @Site : 冒泡排序
# @File : Part_1.py
# @Software: PyCharm

import random
import timeit

# 冒泡排序


def randomList(n):
    """返回一个长度为n的整数列表，数据范围[0，1000）"""

    iList = []
    for i in range(n):
        iList.append(random.randrange(1000))
    #
    # print(iList)
    return iList


def bubbleSort(iList):
    """冒泡排序"""
    if len(iList) <= 1:
        return iList

    for i in range(1, len(iList)):
        for j in range(0, len(iList) - i):
            if iList[j] >= iList[j+1]: # 比较相邻两个数的大小
                iList[j], iList[j+1] = iList[j+1], iList[j]     # 将大数交换到靠后的位置
            print("this is %d percent" % i, end="")
            print(iList)
    return iList


if __name__ == "__main__":

    randomListTime = timeit.timeit(stmt="bubbleSort(randomList(10))",
                                   setup="from __main__ import bubbleSort,randomList",
                                   number=10)
    # print(randomListTime)




