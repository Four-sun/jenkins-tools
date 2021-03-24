# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/3/4 14:58
# @Author : FanShu
# @Site : 
# @File : JenkinsFileOne.py
# @Software: PyCharm

MYSQL_BASE = "$4"
PROJECT = "$5"
increment_sql = "$6"





# python3 jenkins_file.py dt-insight-engine DAGScheduleX test_4.1.x 172.16.101.200 dagschedulex 202102201100_v4.1.x.sql

# /data/anaconda3/bin/python3 jenkins_file.py dt-insight-engine DAGScheduleX test_4.1.x 172.16.101.200 dagschedulex 202102201100_v4.1.x.sql


MYSQL="$MYSQL_BIN/mysql -S /data/my3306/run/mysql.sock -h172.16.23.236 -udrpeco -pDT@Stack#123"


# sh post_deploy1.sh "172.16.23.236" "drpeco" "DT@Stack#123" "streamapp" "dt-center-streamapp" "202103051137_v4.2.x1.sql"

 # $MYSQL_BIN/mysql -S /data/my3306/run/mysql.sock -e "tee $implement_log; select SCHEMA_NAME from information_schema.SCHEMATA where SCHEMA_NAME = '$MYSQL_BASE'"