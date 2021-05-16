# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/15 20:20
# @Author : FanShu
# @Site :  选择排序
# @File : Part_2.py
# @Software: PyCharm

import timeit
from leetCode.Part_1 import randomList


iList = randomList(10)


def selectionSort(iList):

    if len(iList) <= 1:
        return iList

    for i in range(0, len(iList) - 1):
        if iList[i] != min(iList[i:]):
            minIndex = iList.index(min(iList[i:]))
            iList[i], iList[minIndex] = iList[minIndex], iList[i]
    return iList


if __name__ == "__main__":

    randomListTime = timeit.timeit(stmt="selectionSort(randomList(10))",
                                   setup="from __main__ import selectionSort;from leetCode.Part_1 import randomList",
                                   number=10)
    print(randomListTime)
