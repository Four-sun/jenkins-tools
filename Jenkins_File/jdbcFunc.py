# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/1 2:03 下午
# @Author : FanShu
# @Site : 处理数据源创建数据表模块
# @File : jdbcFunc.py
# @Software: PyCharm

column = {'COLUMN_NAME': ['id', 'name', 'age'], 'DATA_TYPE': ['int', 'varchar', 'decimal']}

create_sql = "create table if not exists  streamFactor " + "( id int(11) not null AUTO_INCREMENT PRIMARY KEY, factor_1 varchar(100), factor_2 varchar(100), factor_3 varchar(100), factor_4 varchar(100), factor_5 varchar(100), factor_6 varchar(100), factor_7 varchar(100), factor_8 varchar(100), factor_9 varchar(100), factor_10 varchar(100)); "

count = 10
tableName = 'streamFactor'
field_name = 'factor_'
field_type = 'varchar(100)'


def create_sql(table, count, name, type):

    sql_list = ["id int(11) not null AUTO_INCREMENT PRIMARY KEY"]

    for i in range(1, count):
        str_word2 = '{a}{b} {c}'.format(a=name, b=i, c=type)
        sql_list.append(str_word2)

    letters = ", ".join(c for c in sql_list)
    create_sql_title = "create table if not exists %s (%s)" % (table, letters)

    print(create_sql_title)
    print(letters)


create_sql(tableName, count, field_name, field_type)
