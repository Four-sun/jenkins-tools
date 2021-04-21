# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/4/21 17:55
# @Author : FanShu
# @Site : 
# @File : flinkxStreamReader.py
# @Software: PyCharm
import json
import random


class streamReader:
    def __init__(self, column, sliceRecordCount, channel_count):
        self.column = column
        self.channel_count = channel_count
        self.sliceRecordCount = sliceRecordCount
        self.column_dict = []
        self.tableFields_dict = []
        self.sliceRecordCount_dict = []

        self.column_id = {'name': 'id', 'type': 'id', 'key': 'id'}
        self.type_list = ["int", "byte", "char", "float", "double"]
        self.json_re = {'job': {'content': [{'reader': {'parameter': {'column': self.column_dict, 'sliceRecordCount': self.sliceRecordCount_dict},'name': 'streamreader'},
                                 'writer': {'parameter': {'tableFields': self.tableFields_dict, 'producerSettings': {'zookeeper.connect': '', 'bootstrap.servers': '172.16.101.196:9092,172.16.100.175:9092,]172.16.101.227:9092'}, 'topic': 'ss_test1'}, 'name': 'kafkawriter', 'type': 37}}],
                    'setting': {'restore': {'isRestore': True, 'isStream': True, 'restoreColumnName': 'sink_id','restoreColumnIndex': 0}, 'errorLimit': {}, 'speed': {'readerChannel': 1, 'writerChannel': 1, 'bytes': -1048576, 'channel': self.channel_count}}}}

    def column_function(self, times):
        try:
            self.tableFields_dict.append("id")
            self.column_dict.append(self.column_id)
            for T in range(times):
                name_value = "NAME_" + str(T)
                type_value = random.choice(self.type_list)
                lower_name_value = str.lower(name_value)
                column_base = {'name': name_value, 'type': type_value, 'key': lower_name_value}
                self.tableFields_dict.append(lower_name_value)
                self.column_dict.append(column_base)
        except Exception as Error:
            return Error

    def channel_function(self, channel):
        try:
            self.channel_count = channel
            return self.channel_count
        except Exception as Error:
            return Error

    def sliceRecordCount_function(self, count, channel):
        try:
            for T in range(channel):
                self.sliceRecordCount_dict.append(str(count))
        except Exception as Error:
            return Error

    def streamReader_function(self):
        self.column_function(self.column)
        self.sliceRecordCount_function(self.sliceRecordCount, self.channel_count)
        json_value = json.dumps(self.json_re)
        print(json_value)


if __name__ == "__main__":
    stream = streamReader(column=10, sliceRecordCount=100, channel_count=4)
    stream.streamReader_function()
