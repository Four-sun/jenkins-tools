# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/8/24 14:33
# @Author : FanShu
# @Site : 3.8新特征
# @File : new_action.py
# @Software: PyCharm

# from pprint import pprint, pp
#
# # d = dict(source="fanshu", id = '1', name='four')
# # pprint(d, width=20)
# x = 100
# a = [var for var in range(10) if x != 100]
# print(a)
#
# a = [{'_c0': 100}]
#
# print(a[0]['_c0'])


def greeting(name: str) -> str:
    return 'hello' + name

c = [f"[{'schema'}]."]
print(type(c))
c[0].join('1')
c[0] = c[0]+ f'[{1}]'
L = "fanshu"

print(c)
