# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/6/2 9:48 上午
# @Author : FanShu
# @Site : 
# @File : urlCode.py
# @Software: PyCharm

import urllib.parse

urlUnquote = "%7B%22job%22%3A%7B%22content%22%3A%5B%7B%22reader%22%3A%7B%22parameter%22%3A%7B%22column%22%3A%5B%7B%22name%22%3A%22id%22%2C%22type%22%3A%22id%22%7D%2C%7B%22name%22%3A%22name%22%2C%22type%22%3A%22string%22%7D%2C%7B%22name%22%3A%22age%22%2C%22type%22%3A%22int%22%7D%5D%2C%22sliceRecordCount%22%3A%5B%22100000%22%5D%7D%2C%22name%22%3A%22streamreader%22%7D%2C%22writer%22%3A%7B%22parameter%22%3A%7B%22postSql%22%3A%5B%5D%2C%22password%22%3A%22Abc123456%22%2C%22column%22%3A%5B%7B%22name%22%3A%22id%22%2C%22type%22%3A%22INT%22%2C%22key%22%3A%22id%22%7D%2C%7B%22name%22%3A%22name%22%2C%22type%22%3A%22VARCHAR%22%2C%22key%22%3A%22name%22%7D%2C%7B%22name%22%3A%22age%22%2C%22type%22%3A%22INT%22%2C%22key%22%3A%22age%22%7D%5D%2C%22connection%22%3A%5B%7B%22jdbcUrl%22%3A%22jdbc%3Amysql%3A%2F%2F172.16.100.186%3A3306%2Ftest%22%2C%22table%22%3A%5B%22datafactory_Result%22%5D%7D%5D%2C%22writeMode%22%3A%22insert%22%2C%22batchSize%22%3A1024%2C%22username%22%3A%22test%22%2C%22preSql%22%3A%5B%5D%7D%2C%22name%22%3A%22mysqlwriter%22%7D%7D%5D%2C%22setting%22%3A%7B%22restore%22%3A%7B%22maxRowNumForCheckpoint%22%3A0%2C%22isRestore%22%3Afalse%2C%22restoreColumnName%22%3A%22%22%2C%22restoreColumnIndex%22%3A0%7D%2C%22log%22%3A%7B%22path%22%3A%22%22%2C%22level%22%3A%22debug%22%2C%22pattern%22%3A%22%22%2C%22isLogger%22%3Afalse%7D%2C%22errorLimit%22%3A%7B%22record%22%3A100%7D%2C%22speed%22%3A%7B%22bytes%22%3A0%2C%22channel%22%3A1%7D%7D%7D%7D"

print(urllib.parse.unquote(urlUnquote))

urlQuote = '{"job":{"content":[{"reader":{"parameter":{"column":[{"name":"id","type":"id"},{"name":"name","type":"string"},{"name":"age","type":"int"}],"sliceRecordCount":["100000"]},"name":"streamreader"},"writer":{"parameter":{"postSql":[],"password":"Abc123456","column":[{"name":"id","type":"INT","key":"id"},{"name":"name","type":"VARCHAR","key":"name"},{"name":"age","type":"INT","key":"age"}],"connection":[{"jdbcUrl":"jdbc:mysql://172.16.100.186:3306/test","table":["datafactory_Result"]}],"writeMode":"insert","batchSize":1024,"username":"test","preSql":[]},"name":"mysqlwriter"}}],"setting":{"restore":{"maxRowNumForCheckpoint":0,"isRestore":false,"restoreColumnName":"","restoreColumnIndex":0},"log":{"path":"","level":"debug","pattern":"","isLogger":false},"errorLimit":{"record":100},"speed":{"bytes":0,"channel":1}}}}'

print(urllib.parse.quote(urlQuote))