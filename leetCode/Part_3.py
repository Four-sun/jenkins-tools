# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/16 15:45
# @Author : FanShu
# @Site :  插入排序
# @File : Part_3.py
# @Software: PyCharm

import random


def randomList(n):
    """返回一个长度为n的整数列表，数据范围[0，1000）"""

    iList = []
    for i in range(n):
        iList.append(random.randrange(1000))
    print(iList)
    return iList


def insertionSort(iList):
    if len(iList) <= 1:
        return iList

    for right in range(1, len(iList)):
        target = iList[right]
        for left in range(0, right):
            if target <= iList[left]:
                iList[left+1: right+1] = iList[left: right]
                iList[left] = target
                break
        # print(iList)
    return iList


if __name__ == "__main__":
    iList = randomList(10)
    insertionSort = insertionSort(iList)
    print(insertionSort)
