# -*- coding: utf-8 -*-
# @Time : 2020/7/1 10:58
# @Author : four
# @Site :
# @File : com/ThreadInsert.py

import pymysql
import threading
import re
import time
from queue import Queue
from DBUtils.PooledDB import PooledDB


class ThreadInsert(object):
    # 多线程并发MySQL插入数据
    def __init__(self):
        start_time = time.time()
        self.pool = self.mysql_connection()
        self.data = self.getData()
        # self.mysql_delete()
        self.task()
        print("========= 数据插入,共耗时:{}'s =========".format(round(time.time() - start_time, 3)))

    def mysql_connection(self):
        maxconnections = 20  # 最大连接数
        pool = PooledDB(
            pymysql,
            maxconnections,
            host='172.16.101.206',
            user='root',
            port=3306,
            passwd='abc123',
            db='dps_source',
            charset="utf8",
            use_unicode=True)
        return pool

    def getData(self):
        st = time.time()
        with open("/Users/four/Desktop/Filebeat/sqldata/5.txt", "rb") as f:
            data = []
            for line in f:
                # line = re.sub("\s", "", str(line, encoding="utf-8"))
                line = re.sub("\n", "", str(line, encoding="utf-8"))
                line = tuple(line.split(","))
                # line = tuple(line[1:-1].split("\"\""))
                line = tuple(line)
                data.append(line)
        n = 1000    # 按每10万行数据为最小单位拆分成嵌套列表
        result = [data[i:i + n] for i in range(0, len(data), n)]
        print(result)
        print("共获取{}组数据,每组{}个元素.==>> 耗时:{}'s".format(len(result), n, round(time.time() - st, 3)))
        return result

    def mysql_delete(self):
        st = time.time()
        con = self.pool.connection()
        cur = con.cursor()
        sql = "TRUNCATE TABLE ci_5.3"
        cur.execute(sql)
        con.commit()
        cur.close()
        con.close()
        print("清空原数据.==>> 耗时:{}'s".format(round(time.time() - st, 3)))

    def mysql_insert(self, *args):
        con = self.pool.connection()
        cur = con.cursor()
        sql = "INSERT INTO four5(name, gender, email, time ) VALUES(%s, %s, %s, %s)"
        # sql1 = "INSERT INTO four2(name, gender, email) VALUES(%s, %s, %s)"
        # sql2 = "INSERT INTO fanshu11(name, gender, email) VALUES(%s, %s, %s)"
        # sql = "INSERT INTO test_simple(name) VALUES(%s)"
        try:
            cur.executemany(sql, *args)
            # cur.executemany(sql1, *args)
            # cur.executemany(sql2, *args)
            con.commit()
        except Exception as e:
            con.rollback()  # 事务回滚
            print('SQL执行有误,原因:', e)
        finally:
            cur.close()
            con.close()

    def task(self):
        q = Queue(maxsize=15)  # 设定最大队列数和线程数
        st = time.time()
        while self.data:
            content = self.data.pop()
            t = threading.Thread(target=self.mysql_insert, args=(content,))
            q.put(t)
            if (q.full() == True) or (len(self.data)) == 0:
                thread_list = []
                while q.empty() == False:
                    t = q.get()
                    thread_list.append(t)
                    t.start()
                for t in thread_list:
                    t.join()
        print("数据插入完成.==>> 耗时:{}'s".format(round(time.time() - st, 3)))


if __name__ == '__main__':
    ThreadInsert()
