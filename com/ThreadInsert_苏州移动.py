# -*- coding: utf-8 -*-
# @Time : 2020/10/2 10:58
# @Author : four
# @Site : 循环插入数据
# @File : com/ThreadInsert.py
import re
import time
import pymysql
import threading
from queue import Queue
from DBUtils.PooledDB import PooledDB


class ThreadInsert(object):
    # 多线程并发MySQL插入数据
    def __init__(self):
        start_time = time.time()
        # self.pool = self.mysql_connection_193()
        self.pool = self.mysql_connection_pingan()
        self.data = self.getData
        self.task()
        print("========= 数据插入,共耗时:{}'s =========".format(round(time.time() - start_time, 3)))

    def mysql_connection_193(self):
        maxconnections = 20  # 最大连接数
        pool = PooledDB(
            pymysql,
            maxconnections,
            host='172.16.8.193',
            user='root',
            port=3306,
            passwd='123456',
            db='ci_5.3',
            charset="utf8",
            use_unicode=True)
        return pool

    def mysql_connection_pingan(self):
        maxconnections = 20  # 最大连接数
        pool = PooledDB(
            pymysql,
            maxconnections,
            host='172.16.101.7',
            user='root',
            port=3306,
            passwd='123456',
            db='pinganTest',
            charset="utf8",
            use_unicode=True)
        return pool
    @property
    def getData(self):
        st = time.time()
        with open("/Users/four/Desktop/Filebeat/sqldata/Stream_PingAn_1.txt", "rb") as f:
            data = []
            for line in f:
                line = re.sub("\n", "", str(line, encoding="utf-8"))
                line = tuple(line.split(","))
                line = tuple(line)
                data.append(line)
        n = 100000    # 按每10万行数据为最小单位拆分成嵌套列表
        result = [data[i:i + n] for i in range(0, len(data), n)]
        print(result)
        print("共获取{}组数据,每组{}个元素.==>> 耗时:{}'s".format(len(result), n, round(time.time() - st, 3)))
        return result

    def mysql_insert(self, *args):
        con = self.pool.connection()
        cur = con.cursor()
        # sex, slave
        sql = "INSERT INTO fanshu_3(user_name, password, qq, email, phone, remark," \
              " login_num, status, is_deleted, create_by, create_time, gender ) " \
              "VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        try:
            cur.executemany(sql, *args)
            con.commit()
        except Exception as e:
            con.rollback()  # 事务回滚
            print('SQL执行有误,原因:', e)
        finally:
            cur.close()
            con.close()

    def mysql_insert_pingAn(self, *args):
        con = self.pool.connection()
        cur = con.cursor()
        sql = "INSERT INTO TestDemoOne(id, name, birth ) VALUES(%s, %s, %s)"
        try:
            cur.executemany(sql, *args)
            con.commit()
        except Exception as e:
            con.rollback()  # 事务回滚
            print('SQL执行有误,原因:', e)
        finally:
            cur.close()
            con.close()

    def task(self):
        q = Queue(maxsize=15) # 设定最大队列数和线程数
        st = time.time()
        while self.data:
            content = self.data.pop()
            t = threading.Thread(target=self.mysql_insert_pingAn, args=(content,))
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
    ThreadInsert().task()


