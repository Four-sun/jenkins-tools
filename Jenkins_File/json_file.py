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

# ca ={'batch': False, 'componentVersion': '1.12', 'computeType': 0, 'createModel': 0, 'createUserId': 1, 'createUserName': 'admin@dtstack.com', 'engineType': 0, 'forceUpdate': False, 'gmtCreate': 1657160963000, 'gmtModified': 1657160963000, 'id': 11529, 'isDeleted': 0, 'isDirtyDataManage': False, 'lockVersion': 0, 'mainClass': '', 'modifyUserName': 'admin@dtstack.com', 'name': 'stream_test_task_towlxcze', 'nodePid': 91, 'projectId': 13, 'readWriteLockVO': {'channel': 'Others', 'getLock': True, 'gmtCreate': 1657160963000, 'gmtModified': 1657160963000, 'id': 11529, 'isDeleted': 0, 'lastKeepLockUserName': 'admin@dtstack.com', 'lockName': '11529_13_STREAM_TASK', 'modifyUserId': 1, 'projectId': 13, 'relationId': 11529, 'result': 0, 'sdkVersion': 'v1.0', 'signType': 'DEFAULT', 'timestamp': 1657160963342, 'type': 'STREAM_TASK', 'version': 1}, 'resourceGroupVO': {'resourceId': 1, 'resourceName': 'default'}, 'side': [], 'sideParams': '', 'sideStr': '[]', 'sink': [], 'sinkParams': '', 'sinkStr': '[{"sourceId": 33, "columnsText": "id int \\nname varchar", "updateMode": "append", "allReplace": "false", "columns": [{"column": "id", "type": "int"}, {"column": "name", "type": "varchar"}], "sinkDataType": "dt_nest", "parallelism": 1, "topic": "test_result_table_name_zhcnvjia", "createType": 0, "sourceName": "kafka_auto_test", "type": 37, "tableName": "MyResult"}]', 'source': [], 'sourceParams': '', 'sourceStr': '[{"createType": 0, "type": 37, "columns": [{"column": "id", "type": "int"}, {"column": "name", "type": "varchar"}], "sourceId": "33", "topic": "test_topic_name_lnwqcrmo", "charset": "utf-8", "table": "MyTable", "timeType": 1, "timeZone": "Asia/Shanghai", "offset": 0, "offsetUnit": "SECOND", "columnsText": "id int\\nname varchar", "parallelism": 1, "offsetReset": "latest", "timestampOffset": null, "sourceDataType": "dt_nest"}]', 'sqlText': 'aW5zZXJ0IGludG8gTXlSZXN1bHQgc2VsZWN0IGlkLG5hbWUgZnJvbSBNeVRhYmxl', 'status': 0, 'strategyId': 0, 'submitState': 0, 'taskId': '4j5tt5fck7s0', 'taskParams': '## 资源相关\nparallelism.default=1\ntaskmanager.numberOfTaskSlots=1\njobmanager.memory.process.size=1g\ntaskmanager.memory.process.size=2g\n\n## 时间相关\n## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选\n## 非脚本模式会根据Kafka自动设置。脚本模式默认为ProcessingTime\n# pipeline.time-characteristic=EventTime\n\n## Checkpoint相关\n## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成\nexecution.checkpointing.interval=5min\n## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE\n# execution.checkpointing.mode=EXACTLY_ONCE\n##任务取消后保留hdfs上的checkpoint文件\nexecution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION\n\n# Flink SQL独有，状态过期时间\ntable.exec.state.ttl=1d\n\nlog.level=INFO\n\n## 使用Iceberg和Hive维表开启\n# table.dynamic-table-options.enabled=true\n\n## Kerberos相关\n# security.kerberos.login.contexts=Client,KafkaClient\n\n\n## 高阶参数\n## 窗口提前触发时间\n# table.exec.emit.early-fire.enabled=true\n# table.exec.emit.early-fire.delay=1s\n\n## 当一个源在超时时间内没有收到任何元素时，它将被标记为临时空闲\n# table.exec.source.idle-timeout=10ms\n\n## 是否开启minibatch\n## 可以减少状态开销。这可能会增加一些延迟，因为它会缓冲一些记录而不是立即处理它们。这是吞吐量和延迟之间的权衡\n# table.exec.mini-batch.enabled=true\n## 状态缓存时间\n# table.exec.mini-batch.allow-latency=5s\n## 状态最大缓存条数\n# table.exec.mini-batch.size=5000\n\n## 是否开启Local-Global 聚合。前提需要开启minibatch\n## 聚合是为解决数据倾斜问题提出的，类似于 MapReduce 中的 Combine + Reduce 模式\n# table.optimizer.agg-phase-strategy=TWO_PHASE\n\n## 是否开启拆分 distinct 聚合\n## Local-Global 可以解决数据倾斜，但是在处理 distinct 聚合时，其性能并不令人满意。\n## 如：SELECT day, COUNT(DISTINCT user_id) FROM T GROUP BY day 如果 distinct key （即 user_id）的值分布稀疏，建议开启\n# table.optimizer.distinct-agg.split.enabled=true\n\n\n## Flink算子chaining开关。默认为true。排查性能问题时会暂时设置成false，但降低性能。\n# pipeline.operator-chaining=true\n\n\n## 提交端的python环境配置。\npython.executable=python3\n##python worker端 python 环境\npython.client.executable=python3', 'taskType': 0, 'taskVersions': [], 'taskVersionsStr': '[]', 'tenantId': 1, 'updateSource': True, 'userId': 1, 'version': 0, 'whereToEnter': 0, 'preSave': True}

# print(json.dumps(ca,ensure_ascii=False))


# with open('./ca.json', 'r') as jsonLoads:
#     dict_str = json.dumps(jsonLoads)
#     print(dict_str)
#     print(len([]))

#
# l_ca = json.dumps(ca, ensure_ascii=False)
# l_ca = json.dumps(ca)
# print(l_ca)h

#
streamTaskDirtyDataManageVO = dict(linkInfo=dict(sourceId=57),
                                   logPrintInterval=1, maxCollectFailedRows=100,
                                   maxRows=100, taskId=11)
ud = {}
ud.update(a=streamTaskDirtyDataManageVO)
print(ud)
