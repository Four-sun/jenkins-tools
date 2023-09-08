# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/2 9:48 上午
# @Author : FanShu
# @Site :
# @File : urlCode.py
# @Software: PyCharm

# from urllib import parse
#
# urlUnquote = 'iSTKGjbPmoDjzxPWbaQD3sZczty/unqLuT/9Y/nd8b9zv2hqjf8hzYlHMtPiqfhjW1ZTKUQjZ7kpb24D8HQVN7aEQqzcw6vW5gwLBESR /N5PniDEkEhgf8NHyXLC80egrR9O7KiXAXyhwnsWoV3EVyu0iONwmF1Q9A2kaym6JQw='
# Unquote = "iSTKGjbPmoDjzxPWbaQD3sZczty%2FunqLuT%2F9Y%2Fnd8b9zv2hqjf8hzYlHMtPiqfhjW1ZTKUQjZ7kpb24D8HQVN7aEQqzcw6vW5gwLBESR%2FN5PniDEkEhgf8NHyXLC80egrR9O7KiXAXyhwnsWoV3EVyu0iONwmF1Q9A2kaym6JQw%3D"
# # if parse.quote(urlUnquote, safe="") == Unquote:
# #     print(True)
#
# print(parse.quote(urlUnquote, safe=""))
#
# # urlQuote = '{"job":{"content":[{"reader":{"parameter":{"column":[{"name":"id","type":"id"},{"name":"name","type":"string"},{"name":"age","type":"int"}],"sliceRecordCount":["100000"]},"name":"streamreader"},"writer":{"parameter":{"postSql":[],"password":"Abc123456","column":[{"name":"id","type":"INT","key":"id"},{"name":"name","type":"VARCHAR","key":"name"},{"name":"age","type":"INT","key":"age"}],"connection":[{"jdbcUrl":"jdbc:mysql://172.16.100.186:3306/ci_5.3","table":["datafactory_Result"]}],"writeMode":"insert","batchSize":1024,"username":"ci_5.3","preSql":[]},"name":"mysqlwriter"}}],"setting":{"restore":{"maxRowNumForCheckpoint":0,"isRestore":false,"restoreColumnName":"","restoreColumnIndex":0},"log":{"path":"","level":"debug","pattern":"","isLogger":false},"errorLimit":{"record":100},"speed":{"bytes":0,"channel":1}}}}'
# #
# # print(urllib.parse.quote(urlQuote))


# import json
# jsonFile = 'ca.json'
#
# def jsonLoad(jsonFile):
#     try:
#         with open(jsonFile, 'r') as jsonLoads:
#             dict_str = json.load(jsonLoads)
#             print(dict_str)
#         return dict_str
#     except Exception as Error:
#         return Error
#
# case = jsonLoad(jsonFile)
#
# list_count = case['data']['data']

# print(len(list_count))
import json
from os import path


class DTbatch():
    def __init__(self):
        pass

    def get_table_info(self):
        """
        数据地图-数据表管理-表级血缘上下游表信息
        """
        inputs = {
            "tableName": 123,
            "pageIndex": 1,
            "pageSize": 6,
            "belongProjectId": 2,
            "dataSourceId": 2,
            "tableId": 1
        }
        setattr(self, "inputs", inputs)

    def get_tree(self):

        inputs_get = getattr(self, "inputs")

        print(inputs_get)

        # inputs.pop("pageIndex")
        # inputs.pop("pageSize")
        # print(inputs)

    def json_load(self, files_path, files):
        try:
            file_path = path.join(files_path, files)
            print(file_path)
            with open(file_path, 'r') as jsonLoads:
                return_str = json.load(jsonLoads)
            return return_str
        except Exception as Error:
            return Error


# files_path = path.join( "testdata", "scenariotest", "batch", "datamap", "datasheetmanagement",
#                        "sql", )
#
# files = ["验证血缘解析关系层级深度两层.sql"]
#
# DTbatch().json_load(files_path, files)

name = [{
		"name": "client_id",
		"columnType": "bigint",
		"comment": ""
	}, {
		"name": "fund_code",
		"columnType": "bigint",
		"comment": ""
	}, {
		"name": "holding_cost",
		"columnType": "decimal(24,8)",
		"comment": ""
	}, {
		"name": "holding_income",
		"columnType": "decimal(24,8)",
		"comment": ""
	}, {
		"name": "contno",
		"columnType": "string",
		"comment": "解释"
	}, {
		"name": "sys",
		"columnType": "string",
		"comment": "系统"
	}]
# p = map(lambda d: d['name'], name)
# print(list(p))


