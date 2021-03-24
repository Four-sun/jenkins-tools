# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2020/9/22 23:36
# @Author : FanShu
# @Site : 
# @File : kafkaConsumer.py
# @Software: PyCharm


# 172.16.100.241:2181/kafka
import json
from kafka import KafkaConsumer, KafkaProducer
from kafka.errors import KafkaError
from pip._vendor import msgpack

producer = KafkaProducer(bootstrap_servers=['172.16.100.241:9092'])

# Asynchronous by default
msg_dict = {
    "sleep_time": 10,
    "db_config": {
        "database": "test_1",
        "host": "xxxx",
        "user": "root",
        "password": "root"
    },
    "table": "msg",
    "msg": "Hello World"
}
msg = json.dumps(msg_dict).encode()
print(msg)
future = producer.send('fanshu5', msg)

# Block for 'synchronous' sends
try:
    record_metadata = future.get(timeout=10)
except KafkaError:
    # Decide what to do if produce request failed...
    KafkaError.exception()
    pass


# consumer = KafkaConsumer( 'fanshu2', bootstrap_servers=['172.16.100.241:9092'])
# for message in consumer:
#     # message value and key are raw bytes -- decode if necessary!
#     # e.g., for unicode: `message.value.decode('utf-8')`
#     print ("%s:%d:%d: key=%s value=%s" % (message.topic, message.partition,
#                                           message.offset, message.key,
#                                           message.value))
#
# # consume earliest available messages, don't commit offsets
# KafkaConsumer(auto_offset_reset='earliest', enable_auto_commit=False)

# # consume json messages
# KafkaConsumer(value_deserializer=lambda m: json.loads(m.decode('ascii')))
#
# # consume msgpack
# KafkaConsumer(value_deserializer=msgpack.unpackb)
#
# # StopIteration if no message after 1sec
# KafkaConsumer(consumer_timeout_ms=4000)
#
# # Subscribe to a regex topic pattern
# consumer = KafkaConsumer()
# consumer.subscribe(pattern='^awesome.*')

# Use multiple consumers in parallel w/ 0.9 kafka brokers
# typically you would run each on a different server / process / CPU
# consumer1 = KafkaConsumer('my-topic',
#                           group_id='my-group',
#                           bootstrap_servers='my.server.com')
# consumer2 = KafkaConsumer('my-topic',
#                           group_id='my-group',
#                           bootstrap_servers='my.server.com')
# TopicPartition(topic='fanshu3', partition=0),

# from kafka import KafkaConsumer
# from kafka.structs import TopicPartition
#
# consumer = KafkaConsumer(group_id='kafka', bootstrap_servers=['172.16.100.241:9092'])
# consumer.assign([ TopicPartition(topic='fanshu3', partition=1)])
# print (consumer.partitions_for_topic("fanshu3")) # 获取test主题的分区信息
# print (consumer.assignment())
# # print (consumer.beginning_offsets(consumer.assignment()))
# # consumer.seek(TopicPartition(topic='fanshu3', partition=0), 0)
# for msg in consumer:
#     recv = "%s:%d:%d: key=%s value=%s" % (msg.topic, msg.partition, msg.offset, msg.key, msg.value)
#     print (recv)