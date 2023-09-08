#!/usr/local/bin/python
# -*- coding: utf-8 -*-

import sys, os

sql = ''
table_name = ''
domain_name = ''

# Const
class Mapper(object):
    def __init__(self, package_name):
        self.__package_name = package_name

    def result_map(self):
        global sql
        sql += '<?xml version="1.0" encoding="UTF-8" ?>\n'
        sql += '<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">\n'
        sql += '<mapper namespace="' + self.__package_name + '.dao.' + domain_name + 'Dao">\n'
        sql += '\n'
        sql += '<resultMap type="' + domain_name + '" id="' + domain_name + 'Map">\n'
        sql += '</resultMap>\n'
        return sql

    def select_content_fragment(self, names):
        global sql
        sql += '<sql id="select_content_fragment">\n'
        sql += '  ' + ','.join(names)
        sql += '\n'
        sql += '</sql>\n'
        return sql


    def select_where_fragment(self,names):
        global sql
        sql += '<sql id="select_where_fragment">\n'
        sql += '<trim prefix="WHERE" prefixOverrides="AND |OR ">\n'
        for name in names:
            sql += '<if ci_5.3="model.{name} != null">'.format(name=self.convertColumn(name)) +'\n'
            sql += '   AND ' + name + ' = #{model.' + self.convertColumn(name) + '}' +'\n'
            sql += '</if>\n'
        sql += '</trim>\n'
        sql += '</sql>\n'
        return sql


    def update_fragment(self, names):
        global sql
        sql += '<sql id="update_fragment">\n'
        sql += '<set>\n'
        for name in names:
            sql += '   <if ci_5.3="{name} != null">'.format(name=self.convertColumn(name)) + '\n'
            sql += '   ' + name + ' = #{' + self.convertColumn(name) + '},\n'
            sql += '</if>\n'
        sql += '</set>\n'
        sql += '</sql>'
        return sql


    def insert(self,names):
        global sql
        sql += '<insert id="insert" parameterType="'+domain_name+'" useGeneratedKeys="true" keyProperty="id">\n'
        sql += 'INSERT INTO ' + table_name
        sql += '  (' + ','.join(names) + ')'
        sql += 'VALUES'
        columns = []
        for i in range(len(names)):
            if i == (len(names) - 1):
                columns.append(self.convertColumn(names[i]))
            else:
                columns.append(self.convertColumn(names[i]) + '},#{')
        sql += '  (#{' + ''.join(columns) + '})\n'
        sql += '</insert>'
        return sql

    def batch_insert(self,names):
        global sql
        sql += '<insert id="batchInsert" parameterType="java.util.List">\n'
        sql += 'INSERT INTO '+ table_name
        sql += '  (' + ','.join(names) + ')\n'
        sql += 'VALUES\n'
        sql += '<foreach item="item" index="index" collection="list" separator="," >\n'
        columns = []
        for i in range(len(names)):
            if i == (len(names) - 1):
                columns.append(self.convertColumn(names[i]))
            else:
                columns.append(self.convertColumn(names[i]) + '},#{item.')
        sql += ('  (#{item.' + ''.join(columns)) + '})\n'
        sql += '</foreach>\n'
        sql += '</insert>'
        return sql

    def update(self):
        global sql
        sql += '<update id="update" parameterType="'+domain_name+'">\n'
        sql += 'UPDATE\n'
        sql += table_name +'\n'
        sql += '<include refid="update_fragment"/>\n'
        sql += 'WHERE\n'
        sql += 'id = #{id} AND is_deleted = 0\n'
        sql += '</update>'
        return sql

    def delete(self):
        global sql
        sql += '<delete id="deleteByIds">\n'
        sql += 'UPDATE ' + table_name + ' SET is_deleted = 1, gmt_modified = #{gmtModified}\n'
        sql += 'WHERE id in\n'
        sql += '<foreach item="id" index="index" collection="ids" open="(" separator="," close=")">\n'
        sql += '#{id}\n'
        sql += '</foreach> AND is_deleted = 0\n'
        sql += '</delete>'
        return sql


    def batch_query(self):
        global sql
        sql += '''<select id="generalQuery" resultType="'''+domain_name+'''">
        SELECT
        <include refid="select_content_fragment"/>
        FROM ''' + table_name + '''
        <include refid="select_where_fragment"/>
        <if ci_5.3="orderBy != null and sort != null">
            order by ${orderBy} ${sort}
        </if>
        <if ci_5.3="orderBy != null and sort == null">
            order by ${orderBy} desc
        </if>
        <if ci_5.3="start != null and pageSize != null">
            limit #{start} , #{pageSize}
        </if>
        <if ci_5.3="start == null and pageSize != null">
            limit #{pageSize}
        </if>
        <if ci_5.3="start == null and pageSize == null">
            limit 1000
        </if>
        </select>
    
        <select id="generalCount" resultType="java.lang.Integer">
            SELECT COUNT(1)
            FROM ''' + table_name + '''
            <include refid="select_where_fragment"/>
            limit 1
        </select>
    
        <select id="getOne" resultType="''' + domain_name + '''">
            SELECT
            <include refid="select_content_fragment"/>
            FROM ''' + table_name + '''
            WHERE id = #{id} AND is_deleted = 0
        </select>'''
        return sql


    def convertColumn(self, column):
        string_list = str(column).split('_')  # 将字符串转化为list
        first = string_list[0].lower()
        others = string_list[1:]
        others_capital = [word.capitalize() for word in others]
        others_capital[0:0] = [first]
        return ''.join(others_capital)  # 将list组合成为字符串，中间无连接符。


    def contact(self, tableName, domainName, fields):
        global domain_name
        global table_name
        global sql
        sql = ''
        table_name = tableName
        domain_name = domainName
        argv = fields
        self.result_map()
        sql += "\n"
        sql += "\n"
        self.select_content_fragment(argv)
        sql += "\n"
        sql += "\n"
        self.select_where_fragment(argv)
        sql += "\n"
        sql += "\n"
        self.update_fragment(argv)
        sql += "\n"
        sql += "\n"
        self.batch_query()
        sql += "\n"
        sql += "\n"
        self.insert(argv)
        sql += "\n"
        sql += "\n"
        self.batch_insert(argv)
        sql += "\n"
        sql += "\n"
        self.update()
        sql += "\n"
        sql += "\n"
        self.delete()
        sql += "\n"
        sql += "\n"
        sql += "</mapper>\n"
        return sql

# if __name__ == '__main__':
#     bart = Mapper('sdad')
#     bart.contact('dq_user', 'DQ_USER', 'id', 'name')
