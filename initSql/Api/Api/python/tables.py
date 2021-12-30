#!/usr/local/bin/python
# -*- coding: utf-8 -*-

import sys, os, MySQLdb

from mapper import Mapper

#模块名称
modules_name = 'da-service'
#包名
package_name = 'com.dtstack.da.service'
package_path = package_name.replace('.','/')
mapper = Mapper(package_name)
domain_path = '../../' + modules_name + '/src/main/java/' + package_path +'/domain/'
mapper_path = '../../' + modules_name + '/src/main/resources/sqlmap/'
#过滤的表
excludes_tables = []
special_tables = ['da_statistics_trigger']

def auto():
    if not os.path.exists(domain_path):
        print 'check path:(' + domain_path + ') is exist.'
        return
    if not os.path.exists(mapper_path):
        print 'check path:(' + mapper_path + ') is exist.'
        return

    try:
        conn = MySQLdb.connect(host='172.16.8.104', port=3306, user='dtstack', passwd='abc123', db='dapi', charset='utf8')
        cursor = conn.cursor()

        tables = []
        if len(special_tables) == 0:
            sql = '''SHOW TABLES'''
            cursor.execute(sql)
            result = cursor.fetchall()
            for i in range(len(result)):
                tables.append(str(result[i][0]))
        else:
            tables = special_tables

        for table_name in tables:
            if table_name in excludes_tables:
                continue
            count = cursor.execute('SELECT * FROM ' + table_name)
            (field_info) = cursor.description
            dealFieldInfo(table_name,field_info)

    except:
        import traceback
        traceback.print_exc()
    finally:
        # 关闭游标连接
        cursor.close()
        # 关闭数据库连接
        conn.close()

def dealFieldInfo(table_name,field_info):
    fields = []
    class_info = ''
    for item in field_info:
        # temp_dict = {'name':item[0],
        #              'display_size':item[2],
        #              'internal_size':item[3],
        #              'precision':item[4],
        #              'scale':item[5],
        #              'null_ok':item[6],
        #              'type_code':item[1]
        #              }
        fields.append(item[0])
        type = 'Integer'
        if item[1] == 3:
            type = 'Long'
        elif item[1] == 12:
            type = 'Timestamp'
        elif item[1] == 253:
            type = 'String'
        p = 'private ' + type + ' ' + uperColumn(item[0]) + ';\n'
        class_info += p
    domain_name = className(table_name);
    sql = mapper.contact(table_name, className(table_name), fields)
    createClassFile(domain_name, class_info)
    createSqlMap(domain_name, sql)

def uperColumn(column):
    string_list = str(column).split('_')  # 将字符串转化为list
    first = string_list[0].lower()
    others = string_list[1:]
    others_capital = [word.capitalize() for word in others]
    others_capital[0:0] = [first]
    name = ''.join(others_capital)
    return name

def className(tableName):
    string_list = str(tableName).split('_')  # 将字符串转化为list
    others = string_list[1:]
    others_capital = [word.capitalize() for word in others]
    name = ''.join(others_capital)
    return name


def createClassFile(domain_name, content):
    file = domain_path + domain_name + '.java'
    fo = open(file, "w")
    fo.write('package ' + package_name + '.domain;\n\n\nimport java.sql.Timestamp; \n\npublic class ' + domain_name + ' {\n' +content + '\n}')

    # os.system('echo \'package ' + package_name + '.domain;\n\n\nimport java.sql.Timestamp; \n\npublic class ' + domain_name + ' {\n'
    #           +content + '\n}\' > ../../' + modules_name + '/src/main/java/' + package_path +'/domain/' + domain_name + '.java')

def createSqlMap(domain_name, content):
    file = mapper_path + domain_name[0].lower() + domain_name[1:] + '-mapper.xml'
    fo = open(file, "w")
    fo.write(content)

    # os.system('echo \'' + content + '\' > ../../' + modules_name + '/src/main/resources/sqlmap/' + domain_name[0].lower() + domain_name[1:] + '-mapper.xml')


if __name__ == '__main__':
    auto()

