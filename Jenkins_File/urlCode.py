# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/2 9:48 上午
# @Author : FanShu
# @Site : 
# @File : urlCode.py
# @Software: PyCharm

from urllib import parse

urlUnquote = 'iSTKGjbPmoDjzxPWbaQD3sZczty/unqLuT/9Y/nd8b9zv2hqjf8hzYlHMtPiqfhjW1ZTKUQjZ7kpb24D8HQVN7aEQqzcw6vW5gwLBESR /N5PniDEkEhgf8NHyXLC80egrR9O7KiXAXyhwnsWoV3EVyu0iONwmF1Q9A2kaym6JQw='
Unquote = "iSTKGjbPmoDjzxPWbaQD3sZczty%2FunqLuT%2F9Y%2Fnd8b9zv2hqjf8hzYlHMtPiqfhjW1ZTKUQjZ7kpb24D8HQVN7aEQqzcw6vW5gwLBESR%2FN5PniDEkEhgf8NHyXLC80egrR9O7KiXAXyhwnsWoV3EVyu0iONwmF1Q9A2kaym6JQw%3D"
# if parse.quote(urlUnquote, safe="") == Unquote:
#     print(True)

print(parse.quote(urlUnquote, safe=""))

# urlQuote = '{"job":{"content":[{"reader":{"parameter":{"column":[{"name":"id","type":"id"},{"name":"name","type":"string"},{"name":"age","type":"int"}],"sliceRecordCount":["100000"]},"name":"streamreader"},"writer":{"parameter":{"postSql":[],"password":"Abc123456","column":[{"name":"id","type":"INT","key":"id"},{"name":"name","type":"VARCHAR","key":"name"},{"name":"age","type":"INT","key":"age"}],"connection":[{"jdbcUrl":"jdbc:mysql://172.16.100.186:3306/test","table":["datafactory_Result"]}],"writeMode":"insert","batchSize":1024,"username":"test","preSql":[]},"name":"mysqlwriter"}}],"setting":{"restore":{"maxRowNumForCheckpoint":0,"isRestore":false,"restoreColumnName":"","restoreColumnIndex":0},"log":{"path":"","level":"debug","pattern":"","isLogger":false},"errorLimit":{"record":100},"speed":{"bytes":0,"channel":1}}}}'
#
# print(urllib.parse.quote(urlQuote))


