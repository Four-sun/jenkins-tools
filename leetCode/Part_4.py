# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/16 15:12
# @Author : FanShu
# @Site : 归并排序
# @File : Part_4.py
# @Software: PyCharm

import random


def randomList(n):
    """返回一个长度为n的整数列表，数据范围[0，1000）"""

    iList = []
    for i in range(n):
        iList.append(random.randrange(1000))

    print(iList)
    return iList


def mergeSort(iList):
    if len(iList) <= 1:
        return iList

    middle = len(iList)//2
    left, right = iList[0:middle], iList[middle:]
    return mergeList(mergeSort(left), mergeSort(right))


def mergeList(left, right):
    mList = []
    while left and right:
        if left[0] >= right[0]:
            mList.append(right.pop(0))
        else:
            mList.append(left.pop(0))
    while left:
        mList.append(left.pop(0))
    while right:
        mList.append(right.pop(0))
    return mList


if __name__ == "__main__":
    iList = randomList(5)
    mergerSort = mergeSort(iList)
    print(mergerSort)
