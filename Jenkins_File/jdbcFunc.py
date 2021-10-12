# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/1 2:03 下午
# @Author : FanShu
# @Site : 处理数据源创建数据表模块
# @File : jdbcFunc.py
# @Software: PyCharm
import os
import random

column = {'COLUMN_NAME': ['id', 'name', 'age'], 'DATA_TYPE': ['int', 'varchar', 'decimal']}

count = 10
tableName = 'streamFactor'


def mysqlCreateSql(table, count):
    field_name = 'factor_'
    field_type = ['int(11)', 'varchar(100)', 'timestamp', 'date', 'float', 'double']
    sql_list = ["id int(11) not null AUTO_INCREMENT PRIMARY KEY"]

    for i in range(1, count):
        sql_type = random.choice(field_type)
        str_word2 = '{a}{b} {c}'.format(a=field_name, b=i, c=sql_type)
        sql_list.append(str_word2)

    letters = ", ".join(c for c in sql_list)
    create_sql_title = "create table if not exists %s (%s)" % (table, letters)

    return create_sql_title


# mysqlCreateSql(tableName, count)
#
# case = [('id', 'int', ''), ('name', 'string', ''), ('idcard', 'string', ''), ('birthday', 'date', ''),
#         ('mobile', 'string', ''), ('email', 'string', ''), ('gender', 'int', ''), ('create_time', 'timestamp', ''),
#         ('pt', 'string', ''), ('', None, None), ('# Partition Information', None, None),
#         ('# col_name            ', 'data_type           ', 'comment             '), ('', None, None),
#         ('pt', 'string', '')]
#
# for i in case:
#     print(i[0])
#     if i[0] == 'pt':
#         break
#
# L = [123, 2, 3, 4, 5]
#
# list_k = list(("index", k) for k in range(len(L)))



# dir_path = os.path.dirname(os.path.abspath(__file__))
# print('当前目录绝对路径:',dir_path)
#
# kwargs = {
#     "name": "id",
#     "type": "INT",
#     "key": "id"
# }
# kwasync = {}
# if 'name' in kwargs:
#     kwasync['name'] = kwargs.pop('name')
# if 'type' in kwargs:
#     kwasync['type'] = kwargs.pop('type')
#
# print(kwasync)

import random


def rand_values(length, kind):
    if kind == "INT":
        base_str = '1234567890'
    elif kind == "VARCHAR":
        base_str = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPLKJHGFDSAZXVCBNM'
    else:
        base_str = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPLKJHGFDSAZXVCBNM1234567890'

    return ''.join(random.choice(base_str) for i in range(length))


index_list = list(("value", rand_values(50, "INT")) for k in range(5))
print(index_list)
