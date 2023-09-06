# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/28 1:42 下午
# @Author : FanShu
# @Site :
# @File : json_file.py
# @Software: PyCharm
import datetime
import json


class FError(Exception):
    pass


def jsonLoad(jsonFile):
    try:
        with open(jsonFile, 'r') as jsonLoads:
            dict_str = json.load(jsonLoads)
        return dict_str
    except Exception as Error:
        return Error


# print(jsonLoad("../model/base.json"))

# res = [item[key] for item in tmp for key in item]
# print(res)

reader_name = ['id', 'name', 'age']
reader_type = ['int', 'int', 'varchar']


def columnJson(reader_name, reader_type):
    """
       处理Json中column字段信息
       """
    appendList = []
    nameDict = list(("name", k) for k in reader_name)
    typeDict = list(("type", k) for k in reader_type)

    for i in range(len(nameDict)):
        commonList = [nameDict[i], typeDict[i]]
        appendList.append(dict(commonList))
    return appendList


def settingJson(channel=1):
    """
    处理环境配置setting部分
    1. 修改 setting.speed.channel 插入的速率默认为1
    """
    setting_reader_value = {'speed': {'channel': channel, 'bytes': 0}, 'errorLimit': {'record': 100},
                            'restore': {'maxRowNumForCheckpoint': 0, 'isRestore': False, 'restoreColumnName': '',
                                        'restoreColumnIndex': 0},
                            'log': {'isLogger': False, 'level': 'debug', 'path': '', 'pattern': ''}}
    try:
        if not all([channel]):
            raise FError
        setting_dumps = json.dumps(setting_reader_value, indent=2)
        print(setting_dumps)
        return setting_reader_value
    except Exception as Error:
        raise Error


def streamReaderJson(rows, count):
    """
    处理读取streamReader部分
    1. 修改 reader.parameter.column 标记字段的名称和类型
    2. 修改 reader.parameter.sliceRecordCount 标记插入的条数
    """
    steam_reader_value = {'name': 'streamreader', 'parameter': {'column': rows, 'sliceRecordCount': [count]}}
    try:
        if not all([rows, count]):
            raise FError
        stream_reader_dumps = json.dumps(steam_reader_value, indent=2)
        print(stream_reader_dumps)
        return steam_reader_value
    except Exception as Error:
        raise Error


def writerTableJson(writer_name, column, username, password, jdbcUrl, table, writeMode):
    """
    先判断是否存在空值,为空则报错
    处理写入Sink端部分
    1. 修改 writer.name 为Sink端的数据源名称
    2. 修改 writer.parameter 包含数据源连接信息
    3. 修改 writer.column 标记字段的名称和类型
    """
    mysql_writer_value = {'name': writer_name,
                          'parameter': {
                              'username': username, 'password': password,
                              'connection': [{'jdbcUrl': jdbcUrl, 'table': table}],
                              'preSql': [], 'postSql': [], 'writeMode': writeMode,
                              'column': column, 'batchSize': 1024
                          }
                          }
    try:

        if not all([writer_name, column, username, password, jdbcUrl, table, writeMode]):
            raise FError
        mysql_writer_dumps = json.dumps(mysql_writer_value, indent=2)
        print(mysql_writer_dumps)
        return mysql_writer_value

    except Exception as Error:
        raise Error


def commonJson(reader, writer, setting):
    """
    commonJson将streamReader、writer、setting部分组合成Json
    """
    common_Json = {'job': {'content': [{'reader': reader, 'writer': writer}], 'setting': setting}}
    try:
        if not all([reader, writer, setting]):
            raise FError
        common_dump = json.dumps(common_Json)
        print(common_dump)
        return common_dump
    except Exception as Error:
        raise Error


# writer_name = 'mysqlwriter'
# column = columnJson(reader_name, reader_type)
# username = 'test'
# password = 'Abc123456'
# jdbcUrl = 'jdbc:mysql://172.16.100.186:3306/StreamData'
# table = ['datafactory_Result']
# writeMode = 'insert'

# writer_value = writerTableJson(writer_name, column, username, password, jdbcUrl, table, writeMode)
# reader_value = streamReaderJson(rows=columnJson(reader_name, reader_type), count='100')
# setting_value = settingJson()
#
# commonJson(reader_value, writer_value, setting_value)

# import re
#
# varchar = re.compile('^timestamp([0-9]{0,5})', re.IGNORECASE)
#
# search_re = re.search(varchar, 'TIMESTAMP(6)')
# if search_re:
#     print(search_re)
#
# # timestamp = re.compile('^TIMESTAMP([0-9])', re.IGNORECASE)
# #
# # search_re = re.search(timestamp, 'TIMESTAMP(6)')
# # if search_re:
# #     print(search_re)
#
#
# type_list = ['id', 'NUMBER', 'NUMBER', 'NUMBER', 'VARCHAR2']
#
# new_type = []
#
# varchar_file = re.compile('^VARCHAR[0-9]{0,5}', re.IGNORECASE)
# int_file = re.compile('^INT([0-9]{0,5})', re.IGNORECASE)
# number_file = re.compile('^NUMBER([0-9]{0,5})', re.IGNORECASE)
# timestamp_file = re.compile('^TIMESTAMP([0-9]{0,5})', re.IGNORECASE)
#
# for tl in type_list:
#     file_type = tl
#     if re.search(varchar_file, tl):
#         file_type = 'string'
#     elif re.search(int_file, tl):
#         file_type = 'int'
#     elif re.search(number_file, tl):
#         file_type = 'int'
#     elif re.search(timestamp_file, tl):
#         file_type = 'timestamp'
#     new_type.append(file_type)
#
# print(new_type)
#
ca = '{"code":1,"message":null,"data":[{"key":"id","type":"bigint","comment":"","part":false,"scale":null,"precision":null},{"key":"varchar_data","type":"string","comment":"","part":false,"scale":null,"precision":null}],"space":0,"version":null,"success":true}'
ca1 = "{\"sourceId\":41,\"isCleanSession\":true,\"receiveUsers\":[],\"senderTypes\":[],\"qos\":2,\"dataMapping\":{\"source\":[{\"name\":\"fanshu2\"}],\"target\":[{\"fieldMapping\":{\"sourceCol\":[{\"meta\":false,\"name\":\"id\",\"id\":1},{\"meta\":false,\"name\":\"varchar_data\",\"id\":2}],\"source\":[{\"meta\":false,\"name\":\"id\",\"id\":1},{\"meta\":false,\"name\":\"varchar_data\",\"id\":2}],\"target\":[{\"name\":\"id\",\"id\":\"id\",\"type\":\"bigint\"},{\"name\":\"varchar_data\",\"id\":\"varchar_data\",\"type\":\"string\"}]},\"name\":\"stream_mysql_ogg_one\",\"tableName\":\"automation.fanshu1\"}]},\"kafkaFormat\":\"OGG-JSON_ROW\",\"type\":1,\"tableName\":[\"stream_mysql_ogg_one\"]}"



# print(json.dumps(ca1, ensure_ascii=False))
# print(json.loads(ca1))
# print(json.dumps(json.loads(ca1)))

# mysql_column = json.loads(ca)
# source_columns = []
# target_columns = []
# c = 1
# for i in mysql_column['data']:
#     source_columns.append({'id': c, 'name': i['key'], 'meta': False})
#     target_columns.append({'id': i['key'], 'name': i['key'], 'type': i['type']})
#     c = c + 1
#
# print(source_columns)
# print(target_columns)



# with open('./ca.json', 'r') as jsonLoads:
#     dict_str = json.dumps(jsonLoads)
#     print(dict_str)
#     print(len([]))

#
# l_ca = json.dumps(ca, ensure_ascii=False)
# l_ca = json.dumps(ca)
# print(l_ca)h

#
# streamTaskDirtyDataManageVO = dict(linkInfo=dict(sourceId=57),
#                                    logPrintInterval=1, maxCollectFailedRows=100,
#                                    maxRows=100, taskId=11)
# ud = {}
# ud.update(a=streamTaskDirtyDataManageVO)
# print(ud)

# import datetime
# a=datetime.datetime(2018,9,11)
# b=datetime.datetime(2019,8,11)
# print(a-b)
#
#
# import time
#
# def demo(day1, day2):
#     time_array1 = time.strptime(day1, "%Y-%m-%d")
#     timestamp_day1 = int(time.mktime(time_array1))
#     time_array2 = time.strptime(day2, "%Y-%m-%d")
#     timestamp_day2 = int(time.mktime(time_array2))
#     result = (timestamp_day2 - timestamp_day1) // 60 // 60 // 24
#     return result
#
# day1 = "2019-08-11"
# day2 = "2018-09-11"
#
# day_diff = demo(day1, day2)
# print("两个日期的间隔天数：{} ".format(day_diff))

# from datetime import datetime
#
# date1_str = input("请输入第一个日期 (格式：YYYY-MM-DD):")
# date2_str = input("请输入第二个日期 (格式：YYYY-MM-DD):")
#
# date1 = datetime.strptime(
# date1_str,"%Y-%m-%d")
# date2 = datetime.strptime(
# date2_str,"%Y-%m-%d")
#
# delta = date2 - date1
# print("两个日期之间相隔的天数为：", delta.days)
# is_existing = False
# catalog_list = [['4', '5', '6'], ['1', '2', '3', '4']]
#
# for _ in catalog_list:
#     if is_existing is True:
#         print(f"StreamFlink: catalog already exists")
#         break
#     children_list = _
#     for b in children_list:
#         if b == '5':
#             is_existing = True
#             break
#
# print(is_existing)

from faker import Faker
fake = Faker("zh_CN")

random_faker = [
    (i, fake.random.randint(1, 1000), fake.name()) for i in range(1, 10)
]

print(random_faker)

list1 = [
    {
        "table": "automation.stream_mysql_ogg_one",
        "op_type": "I",
        "op_ts": "2022-11-05 18:45:36.000000",
        "current_ts": "2022-10-05 18:45:36.000000",
        "pos": "00000000000000002928",
        "after": {"id": i, "tinyint_data": 2, "int_data": 2, "bigint_data": 2, "decimal_data": 2, "float_data": 2,
                  "double_data": "2.2", "varchar_data": "varchar_data", "char_data": "c", "date_data": "2022-07-14",
                  "time_data": "10:52:34", "timestamp_data": "2022-07-16 09:09:56", "name": "name_1", "age": 181}
    } for i in range(1, 10)
]



