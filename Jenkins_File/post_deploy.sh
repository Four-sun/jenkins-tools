#!/bin/bash
MYSQL="$MYSQL_BIN/mysql -S /data/my3306/run/mysql.sock -h$1 -u$2 -p$3"
MYSQL_BASE="$4"
PROJECT="$5"
increment_sql="$6"
increment_path="/home/admin/temp/increment/$PROJECT/$increment_sql"
implement_log="/home/admin/temp/implement.log"

echo "$MYSQL_BASE $PROJECT $incremen_sql"
import_sql(){
$MYSQL -e "select SCHEMA_NAME from information_schema.SCHEMATA where SCHEMA_NAME = '$MYSQL_BASE'" > $implement_log
database=`grep -wq "$MYSQL_BASE" implement.log && echo "yes" || echo "no"`
if [ "$database" = "yes" ]; then
        echo "init $MYSQL_BASE " >> $implement_log
        $MYSQL $MYSQL_BASE < $increment_path >> $implement_log
        echo "增量SQL执行结束" >> $implement_log
else
        echo "ERROR(1001) 请检查MYSQL_DATABASE是否填写正确" >> $implement_log
        exit 1
fi

}


import_sql

#!/bin/bash
MYSQL="$MYSQL_BIN/mysql -S /data/my3306/run/mysql.sock -h$1 -u$2 -p$3"
MYSQL_BASE="$4"
PROJECT="$5"
increment_sql="$6"
increment_path="/home/admin/temp/increment/$PROJECT/$increment_sql"
implement_log="/home/admin/temp/implement.log"

echo "$MYSQL_BASE $PROJECT $incremen_sql"
import_sql(){
cd '/home/admin/temp/'
$MYSQL -e "tee $implement_log; select SCHEMA_NAME from information_schema.SCHEMATA where SCHEMA_NAME = '$MYSQL_BASE'" >> $implement_log
database=`grep -wq "$MYSQL_BASE" implement.log && echo "yes" || echo "no"`
if [ "$database" = "yes" ]; then
        echo "init $MYSQL_BASE " >> $implement_log
        ./post_expect.sh $increment_path $MYSQL_BASE
        echo "增量SQL执行结束" >> $implement_log
else
        echo "ERROR(1001) 请检查MYSQL_DATABASE是否填写正确" >> $implement_log
        exit 1
fi

}

import_sql