# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/5/28 1:42 下午
# @Author : FanShu
# @Site : 
# @File : json_file.py
# @Software: PyCharm
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


writer_name = 'mysqlwriter'
column = columnJson(reader_name, reader_type)
username = 'test'
password = 'Abc123456'
jdbcUrl = 'jdbc:mysql://172.16.100.186:3306/StreamData'
table = ['datafactory_Result']
writeMode = 'insert'

# writer_value = writerTableJson(writer_name, column, username, password, jdbcUrl, table, writeMode)
# reader_value = streamReaderJson(rows=columnJson(reader_name, reader_type), count='100')
# setting_value = settingJson()
#
# commonJson(reader_value, writer_value, setting_value)

case = ['int', 'varchar', 'decimal']
new_case = case[:]
case.pop(0)
case.insert(0, 'id')
print(case)
print(new_case)

