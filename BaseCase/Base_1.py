# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/11/10 10:18 上午
# @Author : FanShu
# @Site :
# @File : StreamDelete.py
# @Software: PyCharm
import json
#
# list1 = [
#         {
#             "name": "MySQL",
#             "value": 1,
#             "groupTag": "MySQL"
#         },
#         {
#             "name": "PolarDB for MySQL8",
#             "value": 28,
#             "groupTag": "PolarDB for MySQL8"
#         },
#         {
#             "name": "Oracle",
#             "value": 2,
#             "groupTag": "Oracle"
#         },
#         {
#             "name": "SQLServer",
#             "value": 3,
#             "groupTag": "SQLServer"
#         },
#         {
#             "name": "SQLServer JDBC",
#             "value": 32,
#             "groupTag": "SQLServer JDBC"
#         },
#         {
#             "name": "PostgreSQL",
#             "value": 4,
#             "groupTag": "PostgreSQL"
#         },
#         {
#             "name": "DB2",
#             "value": 19,
#             "groupTag": "DB2"
#         },
#         {
#             "name": "Greenplum",
#             "value": 36,
#             "groupTag": "Greenplum"
#         },
#         {
#             "name": "Kafka2.x",
#             "value": 37,
#             "groupTag": "Kafka"
#         },
#         {
#             "name": "Kafka",
#             "value": 26,
#             "groupTag": "Kafka"
#         },
#         {
#             "name": "Kafka_0.11",
#             "value": 14,
#             "groupTag": "Kafka"
#         },
#         {
#             "name": "Kafka_0.10",
#             "value": 17,
#             "groupTag": "Kafka"
#         },
#         {
#             "name": "EMQ",
#             "value": 34,
#             "groupTag": "EMQ"
#         },
#         {
#             "name": "WebSocket",
#             "value": 42,
#             "groupTag": "WebSocket"
#         },
#         {
#             "name": "Socket",
#             "value": 44,
#             "groupTag": "Socket"
#         },
#         {
#             "name": "Restful",
#             "value": 47,
#             "groupTag": "Restful"
#         },
#         {
#             "name": "TBDS_KAFKA",
#             "value": 62,
#             "groupTag": "TBDS_KAFKA"
#         },
#         {
#             "name": "HUAWEI_KAFKA",
#             "value": 70,
#             "groupTag": "HUAWEI_KAFKA"
#         },
#         {
#             "name": "UPDRDB",
#             "value": 73,
#             "groupTag": "UPDRDB"
#         }
#     ]
# # print(list1)
# #
# sourceType = "mysql_automation2"
# # case = [x['value'] for x in list1 if sourceType == x['name']][-1]
# # print(case)
#
# list2 = [{"id": 309, "gmtCreate": "2022-10-08T09:43:57.000+00:00", "gmtModified": "2022-10-08T09:43:57.000+00:00",
#           "tenantId": 1, "projectId": 43, "dataName": "mysql_automation", "dataDesc": "", "type": 1, "active": 1,
#           "linkState": 1, "modifyUserId": 1, "createUserId": 1, "modifyUser": None,
#           "dataJsonStr": "{\"jdbcUrl\":\"jdbc:mysql://172.16.100.186:3306/automation\",\"username\":\"drpeco\"}",
#           "dataJsonString": None, "localKerberosConf": None},{"id": 309, "gmtCreate": "2022-10-08T09:43:57.000+00:00", "gmtModified": "2022-10-08T09:43:57.000+00:00",
#           "tenantId": 1, "projectId": 43, "dataName": "mysql_automation1", "dataDesc": "", "type": 1, "active": 1,
#           "linkState": 1, "modifyUserId": 1, "createUserId": 1, "modifyUser": None,
#           "dataJsonStr": "{\"jdbcUrl\":\"jdbc:mysql://172.16.100.186:3306/automation\",\"username\":\"drpeco\"}",
#           "dataJsonString": None, "localKerberosConf": None}]


# case = [x for x in list2 if sourceType == x['dataName']]
# if len(case) < 1:
#     raise KeyError
# print(case)

# # source_map_str = '{\"batch\":false,\"componentVersion\":\"1.12\",\"computeType\":0,\"createModel\":0,\"createUserId\":1,\"createUserName\":\"admin@dtstack.com\",\"engineType\":0,\"forceUpdate\":false,\"gmtCreate\":1669701291000,\"gmtModified\":1669709376000,\"id\":38077,\"isDeleted\":0,\"isDirtyDataManage\":false,\"mainClass\":\"\",\"modifyUserName\":\"admin@dtstack.com\",\"name\":\"kafka_mongodb\",\"nodePid\":355,\"projectId\":13,\"readWriteLockVO\":{\"channel\":\"Others\",\"getLock\":true,\"gmtCreate\":1669701291000,\"gmtModified\":1669701291000,\"id\":38077,\"isDeleted\":0,\"lastKeepLockUserName\":\"admin@dtstack.com\",\"lockName\":\"38077_13_STREAM_TASK\",\"modifyUserId\":1,\"projectId\":13,\"relationId\":38077,\"result\":0,\"sdkVersion\":\"v1.0\",\"signType\":\"DEFAULT\",\"timestamp\":1669712567095,\"type\":\"STREAM_TASK\",\"version\":1},\"resourceGroupVO\":{\"resourceId\":1,\"resourceName\":\"default\"},\"side\":[],\"sideParams\":\"\",\"sideStr\":\"[]\",\"sink\":[{\"sourceId\":\"483\",\"columnsText\":\"id int\\ngender int\",\"bulkFlushMaxActions\":100,\"updateMode\":\"append\",\"allReplace\":\"false\",\"columns\":[{\"column\":\"id\",\"type\":\"int\"},{\"column\":\"gender\",\"type\":\"int\"}],\"parallelism\":1,\"createType\":0,\"sourceName\":\"mongodb_auto_test\",\"type\":13,\"table\":\"test\",\"tableName\":\"MyResult\"}],\"sinkParams\":\"CREATE TABLE MyResult(\\n    id int,\\n    gender int\\n )WITH(\\n    'database'='test',\\n    'connector'='mongodb-x',\\n    'collection'='test',\\n    'sink.parallelism'='1',\\n    'uri'='mongodb://172.16.101.246:27017'\\n );\",\"sinkStr\":\"[{"sourceId":"483","columnsText":"id int\ngender int","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","columns":[{"column":"id","type":"int"},{"column":"gender","type":"int"}],"parallelism":1,"createType":0,"sourceName":"mongodb_auto_test","type":13,"table":"test","tableName":"MyResult"}]\",\"source\":[{\"sourceId\":\"35\",\"columnsText\":\"id int\\n    name varchar\\n    gender int\\n    birthday VARCHAR \\n    idcard varchar\",\"charset\":\"utf-8\",\"_panelKey\":\"1669701187309343241\",\"sourceDataType\":\"dt_nest\",\"timeTypeArr\":[1],\"offset\":0,\"columns\":[{\"column\":\"id\",\"type\":\"int\"},{\"column\":\"name\",\"type\":\"varchar\"},{\"column\":\"gender\",\"type\":\"int\"},{\"column\":\"birthday\",\"type\":\"VARCHAR\"},{\"column\":\"idcard\",\"type\":\"varchar\"}],\"parallelism\":1,\"timeType\":1,\"timeZone\":\"Asia/Shanghai\",\"createType\":0,\"type\":37,\"offsetReset\":\"latest\",\"offsetUnit\":\"SECOND\",\"topic\":\"test_topic_name_gcwfybte\",\"sourceName\":\"kafka2x_auto_test\",\"table\":\"MyTable\"}],\"sourceParams\":\"CREATE TABLE MyTable(\\n    id int,\\n    name varchar,\\n    gender int,\\n    birthday VARCHAR,\\n    idcard varchar\\n )WITH(\\n    'properties.bootstrap.servers'='172.16.100.109:9092',\\n    'connector'='kafka-x',\\n    'scan.parallelism'='1',\\n    'format'='json',\\n    'topic'='test_topic_name_gcwfybte',\\n    'scan.startup.mode'='latest-offset'\\n );\",\"sourceStr\":\"[{"sourceId":"35","columnsText":"id int\n    name varchar\n    gender int\n    birthday VARCHAR \n    idcard varchar","charset":"utf-8","_panelKey":"1669701187309343241","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"gender","type":"int"},{"column":"birthday","type":"VARCHAR"},{"column":"idcard","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"test_topic_name_gcwfybte","sourceName":"kafka2x_auto_test","table":"MyTable"}]\",\"sqlText\":\"-- name kafka_mongodb\\n-- type FlinkSQL\\n-- author admin@dtstack.com\\n-- create time 2022-11-29 13:55:29\\n-- desc \\nINSERT \\nINTO\\n    MyResult\\n    SELECT\\n        t.id,t.gender\\n    FROM\\n        MyTable t\\n    \",\"status\":0,\"strategyId\":0,\"submitState\":1,\"taskId\":\"4k9ieaghpkd0\",\"taskParams\":\"## 资源相关\\nparallelism.default=1\\ntaskmanager.numberOfTaskSlots=1\\njobmanager.memory.process.size=1g\\ntaskmanager.memory.process.size=2g\\n\\n## 时间相关\\n## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选\\n## 非脚本模式会根据Kafka自动设置。脚本模式默认为ProcessingTime\\n# pipeline.time-characteristic=EventTime\\n\\n## Checkpoint相关\\n## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成\\nexecution.checkpointing.interval=5min\\n## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE\\n# execution.checkpointing.mode=EXACTLY_ONCE\\n##任务取消后保留hdfs上的checkpoint文件\\nexecution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION\\n\\n# Flink SQL独有，状态过期时间\\ntable.exec.state.ttl=1d\\n\\nlog.level=INFO\\n\\n## 使用Iceberg和Hive维表开启\\n# table.dynamic-table-options.enabled=true\\n\\n## Kerberos相关\\n# security.kerberos.login.contexts=Client,KafkaClient\\n\\n\\n## 高阶参数\\n## 窗口提前触发时间\\n# table.exec.emit.early-fire.enabled=true\\n# table.exec.emit.early-fire.delay=1s\\n\\n## 当一个源在超时时间内没有收到任何元素时，它将被标记为临时空闲\\n# table.exec.source.idle-timeout=10ms\\n\\n## 是否开启minibatch\\n## 可以减少状态开销。这可能会增加一些延迟，因为它会缓冲一些记录而不是立即处理它们。这是吞吐量和延迟之间的权衡\\n# table.exec.mini-batch.enabled=true\\n## 状态缓存时间\\n# table.exec.mini-batch.allow-latency=5s\\n## 状态最大缓存条数\\n# table.exec.mini-batch.size=5000\\n\\n## 是否开启Local-Global 聚合。前提需要开启minibatch\\n## 聚合是为解决数据倾斜问题提出的，类似于 MapReduce 中的 Combine + Reduce 模式\\n# table.optimizer.agg-phase-strategy=TWO_PHASE\\n\\n## 是否开启拆分 distinct 聚合\\n## Local-Global 可以解决数据倾斜，但是在处理 distinct 聚合时，其性能并不令人满意。\\n## 如：SELECT day, COUNT(DISTINCT user_id) FROM T GROUP BY day 如果 distinct key （即 user_id）的值分布稀疏，建议开启\\n# table.optimizer.distinct-agg.split.enabled=true\\n\\n\\n## Flink算子chaining开关。默认为true。排查性能问题时会暂时设置成false，但降低性能。\\n# pipeline.operator-chaining=true\\n\\n\\n## 提交端的python环境配置。\\npython.executable=python3\\n##python worker端 python 环境\\npython.client.executable=python3\",\"taskType\":0,\"taskVersion\":1,\"taskVersions\":[{\"sqlText\":\"-- name kafka_mongodb\\n-- type FlinkSQL\\n-- author admin@dtstack.com\\n-- create time 2022-11-29 13:55:29\\n-- desc \\nINSERT \\nINTO\\n    MyResult\\n    SELECT\\n        t.id,t.gender\\n    FROM\\n        MyTable t\\n    \",\"createUserId\":1,\"gmtModified\":1669709376000,\"sinkParams\":\"CREATE TABLE MyResult(\\n    id int,\\n    gender int\\n )WITH(\\n    'database'='test',\\n    'connector'='mongodb-x',\\n    'collection'='test',\\n    'sink.parallelism'='1',\\n    'uri'='mongodb://172.16.101.246:27017'\\n );\",\"side\":[],\"sink\":[{\"sourceId\":\"483\",\"columnsText\":\"id int\\ngender int\",\"bulkFlushMaxActions\":100,\"updateMode\":\"append\",\"allReplace\":\"false\",\"columns\":[{\"column\":\"id\",\"type\":\"int\"},{\"column\":\"gender\",\"type\":\"int\"}],\"parallelism\":1,\"createType\":0,\"sourceName\":\"mongodb_auto_test\",\"type\":13,\"table\":\"test\",\"tableName\":\"MyResult\"}],\"modifyUserId\":1,\"source\":[{\"sourceId\":\"35\",\"columnsText\":\"id int\\n    name varchar\\n    gender int\\n    birthday VARCHAR \\n    idcard varchar\",\"charset\":\"utf-8\",\"_panelKey\":\"1669701187309343241\",\"sourceDataType\":\"dt_nest\",\"timeTypeArr\":[1],\"offset\":0,\"columns\":[{\"column\":\"id\",\"type\":\"int\"},{\"column\":\"name\",\"type\":\"varchar\"},{\"column\":\"gender\",\"type\":\"int\"},{\"column\":\"birthday\",\"type\":\"VARCHAR\"},{\"column\":\"idcard\",\"type\":\"varchar\"}],\"parallelism\":1,\"timeType\":1,\"timeZone\":\"Asia/Shanghai\",\"createType\":0,\"type\":37,\"offsetReset\":\"latest\",\"offsetUnit\":\"SECOND\",\"topic\":\"test_topic_name_gcwfybte\",\"sourceName\":\"kafka2x_auto_test\",\"table\":\"MyTable\"}],\"gmtCreate\":1669709376000,\"userName\":\"admin@dtstack.com\",\"taskParams\":\"## 资源相关\\nparallelism.default=1\\ntaskmanager.numberOfTaskSlots=1\\njobmanager.memory.process.size=1g\\ntaskmanager.memory.process.size=2g\\n\\n## 时间相关\\n## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选\\n## 非脚本模式会根据Kafka自动设置。脚本模式默认为ProcessingTime\\n# pipeline.time-characteristic=EventTime\\n\\n## Checkpoint相关\\n## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成\\nexecution.checkpointing.interval=5min\\n## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE\\n# execution.checkpointing.mode=EXACTLY_ONCE\\n##任务取消后保留hdfs上的checkpoint文件\\nexecution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION\\n\\n# Flink SQL独有，状态过期时间\\ntable.exec.state.ttl=1d\\n\\nlog.level=INFO\\n\\n## 使用Iceberg和Hive维表开启\\n# table.dynamic-table-options.enabled=true\\n\\n## Kerberos相关\\n# security.kerberos.login.contexts=Client,KafkaClient\\n\\n\\n## 高阶参数\\n## 窗口提前触发时间\\n# table.exec.emit.early-fire.enabled=true\\n# table.exec.emit.early-fire.delay=1s\\n\\n## 当一个源在超时时间内没有收到任何元素时，它将被标记为临时空闲\\n# table.exec.source.idle-timeout=10ms\\n\\n## 是否开启minibatch\\n## 可以减少状态开销。这可能会增加一些延迟，因为它会缓冲一些记录而不是立即处理它们。这是吞吐量和延迟之间的权衡\\n# table.exec.mini-batch.enabled=true\\n## 状态缓存时间\\n# table.exec.mini-batch.allow-latency=5s\\n## 状态最大缓存条数\\n# table.exec.mini-batch.size=5000\\n\\n## 是否开启Local-Global 聚合。前提需要开启minibatch\\n## 聚合是为解决数据倾斜问题提出的，类似于 MapReduce 中的 Combine + Reduce 模式\\n# table.optimizer.agg-phase-strategy=TWO_PHASE\\n\\n## 是否开启拆分 distinct 聚合\\n## Local-Global 可以解决数据倾斜，但是在处理 distinct 聚合时，其性能并不令人满意。\\n## 如：SELECT day, COUNT(DISTINCT user_id) FROM T GROUP BY day 如果 distinct key （即 user_id）的值分布稀疏，建议开启\\n# table.optimizer.distinct-agg.split.enabled=true\\n\\n\\n## Flink算子chaining开关。默认为true。排查性能问题时会暂时设置成false，但降低性能。\\n# pipeline.operator-chaining=true\\n\\n\\n## 提交端的python环境配置。\\npython.executable=python3\\n##python worker端 python 环境\\npython.client.executable=python3\",\"version\":1,\"component_version\":\"1.12\",\"publishDesc\":\"多得多\",\"sideParams\":\"\",\"createModel\":0,\"sourceParams\":\"CREATE TABLE MyTable(\\n    id int,\\n    name varchar,\\n    gender int,\\n    birthday VARCHAR,\\n    idcard varchar\\n )WITH(\\n    'properties.bootstrap.servers'='172.16.100.109:9092',\\n    'connector'='kafka-x',\\n    'scan.parallelism'='1',\\n    'format'='json',\\n    'topic'='test_topic_name_gcwfybte',\\n    'scan.startup.mode'='latest-offset'\\n );\",\"taskId\":38077}],\"taskVersionsStr\":\"[{"sqlText":"-- name kafka_mongodb\n-- type FlinkSQL\n-- author admin@dtstack.com\n-- create time 2022-11-29 13:55:29\n-- desc \nINSERT \nINTO\n    MyResult\n    SELECT\n        t.id,t.gender\n    FROM\n        MyTable t\n    ","createUserId":1,"gmtModified":1669709376000,"sinkParams":"CREATE TABLE MyResult(\n    id int,\n    gender int\n )WITH(\n    'database'='test',\n    'connector'='mongodb-x',\n    'collection'='test',\n    'sink.parallelism'='1',\n    'uri'='mongodb://172.16.101.246:27017'\n );","side":[],"sink":[{"sourceId":"483","columnsText":"id int\ngender int","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","columns":[{"column":"id","type":"int"},{"column":"gender","type":"int"}],"parallelism":1,"createType":0,"sourceName":"mongodb_auto_test","type":13,"table":"test","tableName":"MyResult"}],"modifyUserId":1,"source":[{"sourceId":"35","columnsText":"id int\n    name varchar\n    gender int\n    birthday VARCHAR \n    idcard varchar","charset":"utf-8","_panelKey":"1669701187309343241","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"gender","type":"int"},{"column":"birthday","type":"VARCHAR"},{"column":"idcard","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"test_topic_name_gcwfybte","sourceName":"kafka2x_auto_test","table":"MyTable"}],"gmtCreate":1669709376000,"userName":"admin@dtstack.com","taskParams":"## 资源相关\nparallelism.default=1\ntaskmanager.numberOfTaskSlots=1\njobmanager.memory.process.size=1g\ntaskmanager.memory.process.size=2g\n\n## 时间相关\n## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选\n## 非脚本模式会根据Kafka自动设置。脚本模式默认为ProcessingTime\n# pipeline.time-characteristic=EventTime\n\n## Checkpoint相关\n## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成\nexecution.checkpointing.interval=5min\n## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE\n# execution.checkpointing.mode=EXACTLY_ONCE\n##任务取消后保留hdfs上的checkpoint文件\nexecution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION\n\n# Flink SQL独有，状态过期时间\ntable.exec.state.ttl=1d\n\nlog.level=INFO\n\n## 使用Iceberg和Hive维表开启\n# table.dynamic-table-options.enabled=true\n\n## Kerberos相关\n# security.kerberos.login.contexts=Client,KafkaClient\n\n\n## 高阶参数\n## 窗口提前触发时间\n# table.exec.emit.early-fire.enabled=true\n# table.exec.emit.early-fire.delay=1s\n\n## 当一个源在超时时间内没有收到任何元素时，它将被标记为临时空闲\n# table.exec.source.idle-timeout=10ms\n\n## 是否开启minibatch\n## 可以减少状态开销。这可能会增加一些延迟，因为它会缓冲一些记录而不是立即处理它们。这是吞吐量和延迟之间的权衡\n# table.exec.mini-batch.enabled=true\n## 状态缓存时间\n# table.exec.mini-batch.allow-latency=5s\n## 状态最大缓存条数\n# table.exec.mini-batch.size=5000\n\n## 是否开启Local-Global 聚合。前提需要开启minibatch\n## 聚合是为解决数据倾斜问题提出的，类似于 MapReduce 中的 Combine + Reduce 模式\n# table.optimizer.agg-phase-strategy=TWO_PHASE\n\n## 是否开启拆分 distinct 聚合\n## Local-Global 可以解决数据倾斜，但是在处理 distinct 聚合时，其性能并不令人满意。\n## 如：SELECT day, COUNT(DISTINCT user_id) FROM T GROUP BY day 如果 distinct key （即 user_id）的值分布稀疏，建议开启\n# table.optimizer.distinct-agg.split.enabled=true\n\n\n## Flink算子chaining开关。默认为true。排查性能问题时会暂时设置成false，但降低性能。\n# pipeline.operator-chaining=true\n\n\n## 提交端的python环境配置。\npython.executable=python3\n##python worker端 python 环境\npython.client.executable=python3","version":1,"component_version":"1.12","publishDesc":"多得多","sideParams":"","createModel":0,"sourceParams":"CREATE TABLE MyTable(\n    id int,\n    name varchar,\n    gender int,\n    birthday VARCHAR,\n    idcard varchar\n )WITH(\n    'properties.bootstrap.servers'='172.16.100.109:9092',\n    'connector'='kafka-x',\n    'scan.parallelism'='1',\n    'format'='json',\n    'topic'='test_topic_name_gcwfybte',\n    'scan.startup.mode'='latest-offset'\n );","taskId":38077}]\",\"tenantId\":1,\"updateSource\":true,\"userId\":1,\"version\":1,\"whereToEnter\":0}'
# source_map_str = {"sourceId":"483","columnsText":"id int\ngender int","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","columns":[{"column":"id","type":"int"},{"column":"gender","type":"int"}],"parallelism":1,"createType":0,"sourceName":"mongodb_auto_test","type":13,"table":"test","tableName":"MyResult"}
# source_json_dump = json.dumps(source_map_str)
# # source_json_dump = json.dumps(source_map_str)
# # source_json_dump.update({"type": 2}
# print(source_json_dump)
# print(type(source_json_dump))
#
# target_map_str = '{\"sourceId\":309,\"isCleanSession\":true,\"ddlExecuteType\":1,\"ddlLogStoreSourceId\":309,' \
#                  '\"receiveUsers\":\"1\",\"senderTypes\":[\"default_MAIL_2\"],\"qos\":2,\"type\":1,' \
#                  '\"analyticalRules\":\"stream_${schemaName}_${tableName}\",\"writeTableType\":\"0\",\"alarmUser\":[' \
#                  '1],\"tableMappingList\":[{\"source\":\"4tablejoin_resulttable\",\"sink\":null}],\"myTrigger\":12} '
#
# target_json_dump = json.dumps(json.loads(target_map_str))
# print(target_json_dump)
# print(type(target_json_dump))
#
# setting_map_dir = '{\"speed\":\"-1\",\"readerChannel\":\"1\",\"writerChannel\":1}'
#
# setting_json_dump = json.dumps(json.loads(setting_map_dir))
# print(setting_map_dir)
# print(type(setting_map_dir))
#
# task_detail = {'resourceList': None, 'modifyUserName': 'admin@dtstack.com', 'createUserName': 'admin@dtstack.com',
#                'status': 0, 'readWriteLockVO': {'channel': 'Others', 'sdkVersion': 'v1.0', 'timestamp': 1665400771320,
#                                                 'signType': 'DEFAULT', 'token': None,
#                                                 'lastKeepLockUserName': 'admin@dtstack.com', 'result': 0,
#                                                 'getLock': True, 'lockName': '649_43_STREAM_TASK', 'modifyUserId': 1,
#                                                 'version': 1, 'projectId': 43, 'relationId': 649, 'type': 'STREAM_TASK',
#                                                 'id': 649, 'gmtCreate': '2022-10-10T11:19:31.000+00:00',
#                                                 'gmtModified': '2022-10-10T11:19:31.000+00:00', 'isDeleted': 0},
#                'userId': 1, 'lockVersion': 0, 'taskVersions': [], 'source': None, 'sink': None, 'side': None,
#                'taskVersionsStr': '[]', 'sourceStr': 'null', 'sinkStr': 'null', 'sideStr': 'null', 'strategyId': 0,
#                'updateSource': True, 'originSourceType': None, 'isDirty': None, 'taskId': '4jtba59qcdd0',
#                'name': 'mysql_to_mysql_cdc_test_dcxuteqi', 'taskType': 11, 'mainClass': '', 'sqlText': '',
#                'taskParams': '## 资源相关\nparallelism.default=1\ntaskmanager.numberOfTaskSlots=1\njobmanager.memory.process.size=1g\ntaskmanager.memory.process.size=2g\n\n## 时间相关\n## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选\n## 默认为ProcessingTime\n# pipeline.time-characteristic=EventTime\n\n## Checkpoint相关\n## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成\nexecution.checkpointing.interval=5min\n## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE\n# execution.checkpointing.mode=EXACTLY_ONCE\n##任务取消后保留hdfs上的checkpoint文件\nexecution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION\n\n## Kerberos相关参数\n# security.kerberos.login.contexts=Client,KafkaClient',
#                'exeArgs': None, 'createUserId': 1, 'version': 0, 'nodePid': 373, 'taskDesc': None, 'createModel': 0,
#                'sourceParams': None, 'sinkParams': None, 'sideParams': None, 'tenantId': 1, 'projectId': 43, 'id': 649,
#                'gmtCreate': '2022-10-10T11:19:31.000+00:00', 'gmtModified': '2022-10-10T11:19:31.000+00:00',
#                'isDeleted': 0, 'streamTaskRetry': None, 'computeType': 0, 'whereToEnter': 0, 'forceUpdate': False,
#                'engineType': 0, 'componentVersion': '1.12', 'additionalResourceList': None,
#                'additionalDependencyList': None, 'streamTaskDirtyDataManageVO': None, 'isDirtyDataManage': False,
#                'sourceList': None, 'submitState': 0,
#                'resourceGroupVO': {'resourceId': 1, 'resourceName': 'test_resource_group'}, 'pyOperatorType': None,
#                'pyEnvironmentId': None, 'pyExec': None, 'batch': None, 'batchParamVO': None, 'configFileId': None,
#                'configFileName': None, 'configTemplate': None, 'loggerEffective': None, 'alarmResultVO': None,
#                'preSave': True}
# detail_json_dump = json.dumps(task_detail, ensure_ascii=False)
# print(detail_json_dump)
# # print(type(detail_json_dump))


# case = [
#     (
#         i,
#         'fanshu',
#         1,
#         'fanshu2'
#     ) for i in range(1, 5 + 1)
# ]
#
#
# # print(slice_1)
# # print(str(case[-1]))
# print(str(''.join(map(str, case[-1]))))
# print((str, case[-1].))
# table = 'STREAM_ORACLE_CDC'
# slice_1 = ""
# for i in case[-1]:
#     slice_1 = slice_1 + f"'{i}',"
#
# slice_2=slice_1.strip(',')
#
# insert_sql = f" insert all into {table} into {table} values {f' into {table} values '.join(map(str, case[:-1]))} select {slice_2} from dual;".upper()
# print(insert_sql)

import cx_Oracle


class MyOracle:
    """ oracle db operator """
    def __init__(self, userName, password, host, port, sid):
        self.dsn = cx_Oracle.makedsn(host=host, port=port, sid=sid)
        print("dsn:" + self.dsn)
        connect_string = "%s/%s@%s" % (userName, password, self.dsn)
        self._conn = cx_Oracle.connect(connect_string, encoding="UTF-8", nencoding="UTF-8")
        self.cursor = self._conn.cursor()

    def exec_sql(self, sql, value={}):
        print("exec sql:{}".format(sql))
        if (value is not None and len(value)):
            res = self.cursor.execute(sql, value)
        else:
            res = self.cursor.execute(sql)
        # 提交到数据库执行
        print(res)
        self.commit()
        print(res.fetchall())

    def commit(self):
        self._conn.commit()

    def close(self):
        if hasattr(self, 'cursor'):
            self.cursor.close()
        if hasattr(self, '_conn'):
            self._conn.close()

if __name__ == '__main__':
    cx_Oracle.init_oracle_client('/Users/four/Downloads/four_git/instantclient_19_8')
    myoracle = MyOracle('shixiao', 'abc123', '172.16.100.243', 1521, 'orcl')
    c = myoracle.exec_sql("select * from STREAM_ORACLE_CDC")
    # myoracle.exec_sql("insert into STREAM_ORACLE_CDC values (?)",insert_values[::])
    myoracle.close()
# # connection = cx_Oracle.connect("shixiao", "abc123", "172.16.100.243:1521:orcl", encoding="UTF-8")
# # cursor = connection.cursor()
# sql = "SELECT * FROM students"
# result = self.cursor.execute(sql)
# print(result.fetchall())
