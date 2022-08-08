# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2022/6/29 3:56 下午
# @Author : FanShu
# @Site :
# @File : sql_insert_data.py
# @Software: PyCharm
# import random
# import time
# from faker import Faker
#
# fake = Faker()
# send_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))  # 获取当前时间
# timeArray = time.strptime(send_time, "%Y-%m-%d %H:%M:%S")
# print(time.localtime())
# timeStamp = int(time.mktime(timeArray))
#
# print(timeStamp)
# task_id = '%s%s'.format(fake.safe_color_name(), fake.ean(length=8))
#
# input_key = ['id', 'name', 'age', 'start_time']
# for_count = 100
#
# def for_count_list():
#
#     input_values = []
#     for _ in range(1, for_count):
#         input_values.append((_, f"name_{_}", random.randrange(1, 100), send_time))
#         print(input_values)
#
#     print('结果\n', input_values)
#
# for_count_list()


datas = [
    {
        "source_num": 100,
        "result_num": 100,
        "topic": ["join_time_window_one", "join_time_window_two"],
        "result_table_name": "joinTimeWindow_ResultTableOne",
        "kafka_times": 2,
        "kafka_interval":2
    }
]


try:
    if datas[0]["kafka_msg"]:
        kafka_msg = datas[0]["kafka_msg"]
    else:
        kafka_msg = None
    print('kafka_msg', kafka_msg)
    # kafka_msg = datas[0]["kafka_msg"]
    # print(kafka_msg)
    kafka_interval = datas[0]['kafka_interval']
    print(kafka_interval)
except KeyError:
    kafka_interval = 20
    kafka_msg = None



