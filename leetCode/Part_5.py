# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/16 21:39
# @Author : FanShu
# @Site : 快速排序
# @File : Part_5.py
# @Software: PyCharm

import random


def randomList(n):
    """返回一个长度为n的整数列表，数据范围[0，1000）"""

    iList = []
    for i in range(n):
        iList.append(random.randrange(1000))
    print(iList)
    return iList


def quickSort(iList):
    if len(iList) <= 1:
        return iList

    left = []
    right = []
    for i in iList[1:]:
        if i <= iList[0]:
            left.append(i)
        else:
            right.append(i)
    return quickSort(left) + [iList[0]] + quickSort(right)


if __name__ == "__main__":

    quickSort = quickSort(iList=randomList(5))
    print(quickSort)
