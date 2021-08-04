# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/7/21 5:45 下午
# @Author : FanShu
# @Site : 
# @File : jsonDump.py
# @Software: PyCharm

import json

json_file = {'taskValues': [{'task_id': 9407, 'task_name': 'SparkSQL_20210730111823_45755934'}, {'task_id': 9409, 'task_name': 'SparkSQL_20210730111826_66435464'}, {'task_id': 9411, 'task_name': 'SparkSQL_20210730111828_29205936'}]}


task_id = json_file['taskValues']

case = task_id.sort()

print(case)