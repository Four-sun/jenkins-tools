# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2020/9/19 14:35
# @Author : FanShu
# @Site :
# @File : PythonList.py
# @Software: PyCharm
import sys
import os

name1 = '10.3.9.12'

def func1(name):

    list1 = name.split('.')
    print(list1)

    li = [bin(int(i)) for i in list1]

    print(li)

    li2 = [i.replace('0b',((10-len(i))*'0')) for i in li]
    print(li2)

    return str(' '.join(li2))
func1 = func1(name1)
print(func1)