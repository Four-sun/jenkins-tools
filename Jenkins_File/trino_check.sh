#!/bin/bash
source /etc/profile

project_name="/home/admin/trino_gc_log.txt"
insert_log="/home/admin/trino_insert_log.txt"
select_log="/home/admin/trino_select_log.txt"
delete_log="/home/admin/trino_delete_log.txt"
current_time=`date "+%Y-%m-%d %H:%M:%S"`

function  trino_sample() {

     echo "服务时间："$current_time >> $project_name

    /opt/dtstack/java/bin/jstat -gcutil `ps -ef | grep TrinoServer | grep -v "grep" | awk '{print $2}'` 1000 5 >>  $project_name

}


trino_sample

#!/bin/bash
source /etc/profile
insert_log="/home/admin/trino_insert.txt"
delete_log="/home/admin/trino_delete.txt"
current_time=`date "+%Y-%m-%d %H:%M:%S"`

function trino_insert() {

     echo "服务时间："$current_time >> $insert_log

    /opt/dtstack/Trino/trino_pkg/bin/trino-cli --server 172.16.91.53:8281 --catalog hive -f /home/admin/insert.sql >> $insert_log

}


function trino_delete() {

     echo "服务时间："$current_time >> $delete_log

    /opt/dtstack/Trino/trino_pkg/bin/trino-cli --server 172.16.91.53:8281 --catalog hive -f /home/admin/delete.sql >> $delete_log

}

trino_insert
trino_delete

#!/bin/bash
source /etc/profile
select_log="/home/admin/trino_select_log.txt"
current_time=`date "+%Y-%m-%d %H:%M:%S"`

function trino_select() {

     echo "服务时间："$current_time >> $select_log

    /opt/dtstack/Trino/trino_pkg/bin/trino-cli --server 172.16.88.236:8281 --catalog hive -f /home/admin/select.sql >> $select_log

}
