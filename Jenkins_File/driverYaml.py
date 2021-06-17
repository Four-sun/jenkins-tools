# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/2 4:41 下午
# @Author : FanShu
# @Site : yaml文件操作
# @File : driverYaml.py
# @Software: PyCharm
import yaml
import json
import os

# writer_name = 'mysqlwriter'
# username = 'test'
# password = 'Abc123456'
# host = '172.16.100.186'
# port = '3306'
# db_name = 'test'
# jdbcUrl = 'jdbc:mysql://172.16.100.186:3306/test'
# table = 'streamFactorOne'
# writeMode = 'insert'
# reader_count = 100
# field_count = 100

yamlPath = 'mysqldb.yaml'
# fw = open(yamlPath, 'w', encoding='utf-8')
#
# mysql_env = {'writer_name': 'mysqlwriter', 'username': 'test', 'password': 'Abc123456',
#                                'host': '172.16.100.186',
#                                'port': '3306', 'db_name': 'test', 'jdbcUrl': 'jdbc:mysql://172.16.100.186:3306/test',
#                                'table': 'streamFactorOne', 'writeMode': 'insert', 'reader_count': 100,
#                                'field_count': 100}
#
# print(mysql_env)
# #
# yaml.dump(mysql_env, fw)

# f = open(yamlPath, 'r', encoding='utf-8')
#
# cont = f.read()
# x = yaml.full_load(cont)
#
# print(x['db_name'])

