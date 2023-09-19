# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/8/15 17:54
# @Author : FanShu
# @Site :
# @File : __init__.py.py
# @Software: PyCharm
import os

new_list = [{'id': 165, 'name': '线上问题', 'parentId': 143}, {'id': 1223, 'name': '第三层2', 'parentId': 165},
            {'id': 1227, 'name': '第四层1', 'parentId': 1223}, {'id': 1225, 'name': '第四层', 'parentId': 1223},
            {'id': 1221, 'name': '第三层1', 'parentId': 165}, {'id': 1233, 'name': '第四层2', 'parentId': 1221},
            {'id': 1231, 'name': '第四层1', 'parentId': 1221}, {'id': 1219, 'name': '第三层', 'parentId': 165},
            {'id': 1229, 'name': '第四层1', 'parentId': 1219}]
nodePid = 143
current_path = "/streamOutput/test_5.3/实时迭代530/"
new_body = []
for _ in new_list:
    if _['parentId'] == nodePid:
        print("this is first leven")
        path = os.path.join(current_path, _['name'])
        print(path)
        new_body.append(dict(id=_['id'], name=_['name'], parentId=_['parentId'], path=path))
    else:
        # c = [x['name'] for x in new_body if x['id'] == _['parentId']]
        c_path = [x['path'] for x in new_body if x['id'] == _['parentId']]
        print("this is second leven")
        path = os.path.join(c_path[0], _['name'])
        print('path', path)
        print(c_path)
        new_body.append(dict(id=_['id'], name=_['name'], parentId=_['parentId'], path=path))


