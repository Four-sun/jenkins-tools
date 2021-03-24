# -*- coding: utf-8 -*-
# @Time : 2020/7/2 17:58
# @Author : four
# @Site :
# @File : com/getDataTest.py

import re
import time
import threading
from queue import Queue
from faker import Factory


class Data(object):
    def getData(self):
        # 获取文件中的行数和元素
        st = time.time()
        with open("/Users/four/Desktop/Filebeat/sqldata/bacher_test.txt", "rb") as f:
            data = []
            for line in f:
                line = re.sub("\n", "", str(line, encoding="utf-8"))
                line = tuple(line.split(","))
                # line = tuple(line[1:-1].split("\"\""))
                line = tuple(line)
                print(line)
                data.append(line)
        n = 1   # 按每10万行数据为最小单位拆分成嵌套列表
        result = [data[i:i + n] for i in range(0, len(data), n)]
        print(result)
        print("共获取{}组数据,每组{}个元素.==>> 耗时:{}'s".format(len(result), n, round(time.time() - st, 3)))
        return result

    def insertData(self):

        # 使用faker函数制造测试数据
        fake = Factory.create('zh_CN')
        name = fake.name()
        password = fake.password()
        phone = fake.phone_number()
        datetime = fake.date_time_between(start_date='-500d', end_date='now')
        print(name)
        print(password)
        print(phone)
        print(datetime)
        with open("/Users/four/Desktop/Filebeat/sqldata/bacher_test.txt", "a") as f:
            f.write(name+"," + password + "," + phone + "," + "%s" % datetime + "\n")  # 这句话自带文件关闭功能，不需要再写f.close()

    def insertData1(self, ID):

        # 使用faker函数制造测试数据
        fake = Factory.create('zh_CN')
        name = fake.name()
        password = fake.password()
        phone = fake.phone_number()
        datetime = fake.date_time_between(start_date='-500d', end_date='now')
        age = fake.random_number(2)
        print("%s" % ID+"," + name + "," + "%s" % age + "\n")
        with open("/Users/four/Desktop/Filebeat/sqldata/bacher_test.txt", "a") as f:
            f.write("%s" % ID+"," + name + "," + "%s" % age + "\n")  # 这句话自带文件关闭功能，不需要再写f.close()

    def task(self):
        # 循环插入测试数据
        q = Queue(maxsize=10)  # 设定最大队列数和线程数
        st = time.time()
        for i in range(1000):
            t = threading.Thread(target=self.insertData1(ID=i))
            q.put(t)
            if (q.full() == True) == 0:
                thread_list = []
                while q.empty() == False:
                    t = q.get()
                    thread_list.append(t)
                    t.start()
                for t in thread_list:
                    t.join()
        print("数据插入完成.==>> 耗时:{}'s".format(round(time.time() - st, 3)))


if __name__ == '__main__':
    # for i in range(10):
    #     Data().insertData()
    # Data().getData()
    # Data().insertData()
    Data().task()
