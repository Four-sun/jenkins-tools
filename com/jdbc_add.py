#!/usr/bin/env python3
# encoding=utf-8
from pymysql import connect
from faker import Factory
import random
import time
import re

# --------------------------------------    # 建立数据库连接，配置数据库连接信息，打开数据库连接    #---#
connection = connect("172.16.101.206", "root", "abc123", "dps_source", use_unicode=True, charset="utf8")
# 使用connection()方法获取操作游标
cursor = connection.cursor()
fake = Factory.create('zh_CN')


def is_table_exists(cursor, table_name):
    sql = "show tables;"
    cursor.execute(sql)
    tables = [cursor.fetchall()]
    table_list = re.findall('(\'.*?\')', str(tables))
    table_list = [re.sub("'", '', each).lower() for each in table_list]
    if table_name.lower() in table_list:
        return 1
    else:
        return 0



def make_data(data_num, time_delay):

    # # --------------------------------------    # 建表(先删表，再建表)    # --------------------------------------  
    # # --------------------------------------建表开始--------------------------------------
    # # 如果表存在则先删除该表
    # if is_table_exists(cursor, 'ycdemo1'):
    #     sql = 'drop table if exists ycdemo1'
    #     cursor.execute(sql)
    # sql = '''
    #             create table ycdemo1(id int not null auto_increment primary key ,name varchar(255),address varchar(255),phone varchar(255))'''
    # cursor.execute(sql)
    # --------------------------------------建表结束--------------------------------------#
    # 插入数据（使用多线程，可同时往多张表中插入数据)#
    # --------------------------------------往表中插入数据开始-------------------------------------- #
    for i in range(data_num):
        # 每一秒插入一条数据
        time.sleep(time_delay)
        name = fake.name()
        address = random.choice(['中国', '台湾', '香港', '澳门'])
        phone = fake.phone_number()
        # 配置SQL 插入语句
        sql = "INSERT INTO ycdemo1(name ,address ,phone ) VALUES ('%s','%s','%s')" %(name ,address ,phone );
        # sql = "INSERT INTO test_simple(name) VALUES ('%s')" %(name);
        try:
            # 执行sql语句
            print(sql)
            cursor.execute(sql)
            # 提交到数据库执行
            connection.commit()
            print("mysql第" + str(i + 1) + "条数据插入成功")
        except:
            #  如果发生错误则回滚
            print("插入数据失败，回滚")
            connection.rollback()
    # --------------------------------------往表中插入数据结束--------------------------------------
    # --------------------------------------    # 查询数据    # --------------------------------------
    sql = 'select count(1) from test_simple'
    cursor.execute(sql)
    rs = cursor.fetchall()
    print("mysql:" + str(rs) + "插入数据完成")
    # 关闭数据库连接
    connection.close()

# 执行入口
if __name__ == '__main__':
    make_data(3, 0)
