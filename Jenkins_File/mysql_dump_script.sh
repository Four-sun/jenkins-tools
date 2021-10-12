#!/bin/bash

#保存备份个数，备份31天数据
number=31
#备份保存路径
backup_dir=/data/mysqlBackFile
#日期
dd=`date +%Y-%m-%d-%H-%M-%S`
#备份工具
tool=$MYSQL_BIN/mysqldump
#备份库host
host="172.16.10.107,172.16.23.253"
#用户名
username=drpeco
#密码
password=DT@Stack#123
#将要备份的数据库
database_name="streamapp,api,assets,dagschedulex,dtuic,ide,model,science,tagapp,valid,"

host_list=${host//,/ };
arr_host=($host_list);

for each_host in ${arr_host[*]}; do
  echo ${each_host}
  project=${database_name//,/ };
  arr_project=($project);

  for each_project in ${arr_project[*]}; do
    echo ${each_project}

    #如果文件夹不存在则创建
    if [ ! -d $backup_dir/${each_project}/${each_host} ];
    then
        mkdir -p $backup_dir/${each_project}/${each_host};
    fi
        $tool -S /data/my3306/run/mysql.sock -h${each_host} -u$username -p$password ${each_project} > $backup_dir/${each_project}/${each_host}/${each_project}-$dd.sql

    #写创建备份日志
    echo "$dd create $backup_dir/${each_project}/${each_project}-$dd.dupm" >> $backup_dir/log.txt

    #找出需要删除的备份
    delfile=`ls -l -crt  $backup_dir/${each_project}/${each_host}/*.sql | awk '{print $9 }' | head -1`

    #判断现在的备份数量是否大于$number
    count=`ls -l -crt  $backup_dir/${each_project}/${each_host}/*.sql | awk '{print $9 }' | wc -l`

    if [ $count -gt $number ]
    then
      #删除最早生成的备份，只保留number数量的备份
      echo "删除最早的备份$delfile"
      ls $delfile
      #写删除文件日志
      echo "$dd delete $delfile" >> $backup_dir/log.txt
    fi

  done
done



