#!/bin/bash
MYSQL="$MYSQL_BIN/mysql -S /data/my3306/run/mysql.sock -h$1 -u$2 -p$3"
MYSQL_DUMP="$MYSQL_BIN/mysqldump -S /data/my3306/run/mysql.sock -h$1 -u$2 -p$3"
MYSQL_SERVER="$1"
MYSQL_BASE="$4"
PROJECT="$5"
increment_sql="$6"
Illegal_verification="$7"
increment_path="/home/admin/temp/increment/$PROJECT/$increment_sql"
implement_log="/home/admin/temp/implement.log"
implement_success_history_log="/home/admin/temp/implement_success_history.log"
backupPath="/data/backupSql"
current_time=`date +%Y-%m-%d_%H:%m:%s`
echo "$MYSQL_BASE $PROJECT $incremen_sql"

import_check_sql(){

if [ `grep -c -E "DELETE" $increment_path` -gt 0 ]; then
  echo 'ERROR(1002) 存在delete非法操作' >> $implement_log
  exit 1
else
  echo '检查文件未存在非法操作' >> $implement_log
fi

}

import_implement_success_history_log(){

if [ `grep -c -E "ERROR" implement_log` -gt 0 ]; then
  echo 'ERROR(1003) 存在ERROR插入失败' >> $implement_log
  exit 1
else
  echo "增量数据插入地址: $MYSQL_SERVER 项目: $PROJECT 增量SQL: $incremen_sql 插入时间: $current_time" >> $implement_success_history_log
fi

}

import_sql(){

echo "" > $implement_log

if [ "$Illegal_verification" = "true" ]; then
        import_check_sql
fi

cd '/home/admin/temp/'
$MYSQL -e "select SCHEMA_NAME from information_schema.SCHEMATA where SCHEMA_NAME = '$MYSQL_BASE'" >> $implement_log
database=`grep -wq "$MYSQL_BASE" implement.log && echo "yes" || echo "no"`
if [ "$database" = "yes" ]; then
        echo "备份数据"
        `mkdir -p $backupPath/$PROJECT`
        `$MYSQL_DUMP --databases $MYSQL_BASE | gzip > $backupPath/$PROJECT/$MYSQL_SERVER.gz`
        echo "init $MYSQL_BASE " >> $implement_log
        ./post_expect.sh $increment_path $MYSQL_BASE $MYSQL_SERVER
        echo "增量SQL执行结束" >> $implement_log
        import_implement_success_history_log
        `sh history.sh`
else
        echo "ERROR(1001) 请检查MYSQL_DATABASE是否填写正确" >> $implement_log
        exit 1
fi

}


import_sql



./mysqldump -S /data/my3306/run/mysql.sock -h172.16.101.200 -udrpeco -pDT@Stack#123 --databases streamapp | gzip > /data/backupSql/stream.sql.gz
