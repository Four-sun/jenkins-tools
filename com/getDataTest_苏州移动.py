# -*- coding: utf-8 -*-
# @Time : 2020/10/2 17:58
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
        with open("/Users/four/Desktop/Filebeat/sqldata/Stream_insert4.txt", "rb") as f:
            data = []
            for line in f:
                line = re.sub("\n", "", str(line, encoding="utf-8"))
                line = tuple(line.split(","))
                # line = tuple(line[1:-1].split("\"\""))
                line = tuple(line)
                print(line)
                data.append(line)
        n = 1
        result = [data[i:i + n] for i in range(0, len(data), n)]
        print(result)
        print("共获取{}组数据,每组{}个元素.==>> 耗时:{}'s".format(len(result), n, round(time.time() - st, 3)))
        return result

    def insertData(self):
        # 使用faker函数制造测试数据
        fake = Factory.create('zh_CN')
        user_name = fake.first_name() + fake.last_name()
        password = fake.password()
        qq = fake.random_number(9)
        email = fake.email()
        phone = fake.phone_number()
        remark = fake.sentence()
        login_num = fake.random_int()
        status = fake.random_int(min=0, max=1)
        is_deleted = fake.random_int(min=0, max=1)
        create_by = fake.first_name() + fake.last_name()
        create_time = fake.date_time_between(start_date='-500d', end_date='now')
        gender = fake.postcode()
        sex = fake.random_int(min=0, max=1)
        slave = fake.random_int(min=0, max=1)
        print(user_name, password, qq, email, phone, remark, login_num, status, is_deleted, create_by, create_time, gender, sex, slave)

        with open("/Users/four/Desktop/Filebeat/sqldata/Stream_insert4.txt", "a") as f:
            f.write(
                user_name + "," + password + "," + "%s" % qq + "," + email + "," + phone + "," + remark + "," +
                "%s" % login_num + "," + "%s" % status + "," + "%s" % is_deleted + "," + create_by + "," +
                "%s" % create_time + "," + "%s" % gender + "," + "%s" % sex + "," + "%s" % slave + "\n")

    def insertData_PingAn(self, user_id):
        # 使用faker函数制造测试数据
        fake = Factory.create('zh_CN')
        user_name = fake.first_name() + fake.last_name()
        birth = fake.date_time_between(start_date='-500d', end_date='now')
        print(user_id, user_name, birth)
        with open("/Users/four/Desktop/Filebeat/sqldata/Stream_PingAn_1.txt", "a") as f:
            f.write(
                "%s" % user_id + "," + "%s" % user_name + "," + "%s" % birth + "\n")

    def task(self):
        # 循环插入测试数据
        q = Queue(maxsize=15)  # 设定最大队列数和线程数
        st = time.time()
        range_int = 1
        for i in range(100000):
            range_int += 1
            t = threading.Thread(target=self.insertData_PingAn(user_id=range_int))
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
    Data().task()
