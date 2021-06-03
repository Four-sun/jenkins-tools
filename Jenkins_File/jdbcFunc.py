# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/1 2:03 下午
# @Author : FanShu
# @Site : 处理数据源创建数据表模块
# @File : jdbcFunc.py
# @Software: PyCharm
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


mysqlCreateSql(tableName, count)
