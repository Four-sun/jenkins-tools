#!/bin/bash

source ~/.bash_profile

export basedir=$(cd `dirname $0`/; pwd)
#定义args
#mysql ip
mysql_host=$1
#mysql user
mysql_user=$2
#mysql password
mysql_pass=$3
#mysql port
mysql_port=$4
#mysql database
mysql_db=$5
#增量sql文件相对路径
#implement_route=$6
#增量sql执行文件
implement_file=$6
#star_implement_file=$7
#历史备份文件保留天数
storage_days=$7
#定义datetime变量
is_dump_public=$8
log_date_hms=$(date +"%Y-%m-%d-%H:%M:%S")
log_date=$(date +"%Y-%m-%d")
datetime=$(date +%Y%m%d_%H%M%S_%N | cut -b1-20)
date=$(date +%Y%m%d)
#日志目录
log_directory=/data/my3306/exec_log/${mysql_db}
#日志文件
log_file=${log_directory}/sql_upgrade_${log_date}.log
#备份文件路径
dump_directory=/data/my3306/dump/${mysql_db}
#记录自动化刷过的增量sql文件
already_update_sql=${log_directory}/upgeade_already_${mysql_db}.sql
#记录刷过的增量sql文件
already_implement_sql=${log_directory}/upgeade_exec_${mysql_db}.sql


#定义mysql_home
MYSQL_BIN=/opt/dtstack/DTBase/mysql/bin


#判断增量sql文件是否存在
if [ ! -f ${implement_file} ]; then

  logger "${implement_file} not existent！"
  printf "${implement_file} not existent！\n"
  exit 1

fi

#mysql_home/bin/mysql
if [ -d ${MYSQL_BIN} ]; then
	MYSQL="${MYSQL_BIN}/mysql -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port} -vvv --show-warnings"
else
	MYSQL="mysql -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port} -vvv --show-warnings"
fi



#mysql_home/bin/mysqldump
if [ -d ${MYSQL_BIN} ]; then
	MYSQLDUMP="sudo ${MYSQL_BIN}/mysqldump -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port} --add-drop-table  --single-transaction --max_allowed_packet=2G  "
else
	MYSQLDUMP="mysqldump -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port} --add-drop-table  --single-transaction --max_allowed_packet=2G  "
fi



#创建log目录
mkdir -p $log_directory
if [ $? != 0 ]; then
  logger "${log_directory} create faild"
  printf "${log_directory} create faild\n"
fi
#创建备份目录
mkdir -p $dump_directory
if [ $? != 0 ]; then
  logger "${dump_directory} create faild"
  printf "${dump_directory} create faild\n"
fi

#定义日志输出
function logger() {
    echo -e "${log_date_hms}:\e[32m${1}\e[0m" >> ${log_file}
}


logger "------------------------------------------华丽的分割线---------------------------------------------"
logger "start Installation and deployment"


#检测mysql连接以及是否初始化
check_conection_and_initialization() {
		$MYSQL -e "show databases;" > test_conn.tmp
	if [ $? = 0 ]; then
		printf "Connection successful:${MYSQL}\n"
		logger "Connection successful:${MYSQL}"
	else
		printf "\e[31m Connection fail:${MYSQL} \e[0m \n"
		logger "Connection fail:${MYSQL}"
logger "------------------------------------------华丽的分割线---------------------------------------------"
		exit 1
	fi
}


#备份公共库，默认间隔1小时
function dump_public_Database() {
	local hour=$1
	local insight_db=(dagschedulex dt_pub_service)
	local dump_directory=/data/my3306/dump

	i=0
	while [ $i -lt ${#insight_db[@]} ]; do #当变量（下标）小于数组长度时进入循环体
		#按下标打印数组元素
		db_name=${insight_db[$i]}

		db_dump_directory=${dump_directory}/${db_name}

		if [ -d ${db_dump_directory} ]; then
			#如果最新的备份超过指定备份时间，重新备份最新的
			old_new_back=$(ls -lt ${db_dump_directory} | grep dump | head -1 | awk '{print $NF}')

			if [ "$old_new_back" != "" ]; then
				#获取文件生成时间，换算为秒
				filetimestamp=$(stat -c %Y ${db_dump_directory}/${old_new_back})
				printf "上次备份时间戳为: ${filetimestamp}\n"
				logger "上次备份时间戳为: ${filetimestamp}"
				#系统时间，换算为秒
				timestamp=$(date +%s)
				#当前时间-文件生成时间
				timecha=$(($timestamp - $filetimestamp))
				#3600是一小时
				back_time_s=$((3600 * ${hour}))
				#如果最新的文件大于要删除的文件时间
				if [[ ${timecha} -gt ${back_time_s} ]]; then

					printf "上次备份时间过久，开始重新备份: ${db_name}\n"
					logger "上次备份时间过久，开始重新备份: ${db_name}"
					$MYSQLDUMP $db_name >${db_dump_directory}/${db_name}_${log_date_hms}.dump
				fi
			else
				printf "未找到备份文件，开始备份: ${db_name}\n"
				logger "未找到备份文件，开始备份: ${db_name}"
				$MYSQLDUMP $db_name >${db_dump_directory}/${db_name}_${log_date_hms}.dump
			fi
		else
			mkdir -p ${db_dump_directory}
			dump_public_Database 1
		fi

		let i++
	done

}



##备份库
function dumpDatabase() {
        local db=$1
        logger "start dump $db"
        printf "start dump\n"
        $MYSQLDUMP  $db > ${dump_directory}/${db}_${log_date_hms}.dump
        if [ $? == 0 ]; then
                logger "dump $db complete"
        else
                printf "dump $db faild\n"
                logger "dump $db faild"
                exit 1
        fi
}



#执行sql文件
function implement_sql() {
	local sql=$1
	local database=$2
	printf "start implement ${sql}\n"
	logger "start implement ${sql}"
	#记录sql执行
	echo "${log_date_hms}:${sql}" >> ${already_implement_sql}
	nohup $MYSQL --tee=${log_file} ${mysql_db} < ${sql} >> ${log_file} 2>&1
	if [ $? == 0 ]; then
                printf "\e[32m ${sql} implement success \e[0m \n"
 		            logger "${log_date}:${sql} implement success"
	else
		            printf "\e[31m ${sql} implement faild!!!!! \e[0m \n"
                printf "\e[31m 请查看日志文件:${log_directory}/sql_upgrade_${log_date}.log \e[0m \n"
		            logger "${sql} implement faild"
logger "------------------------------------------华丽的分割线---------------------------------------------"
		            exit 1
	fi

}

#刷增量sql
update_sql() {
        if [ "${is_dump_public}" == "" ]; then
        if [[ "${mysql_db}" != "dagschedulex" ]] || [[ ${mysql_db} != "dt_pub_service" ]]; then
        dump_public_Database 1
        fi
        fi

        dumpDatabase ${mysql_db}

        printf "update\n"
        echo "增量sql数量为: ${#}"

        for line in "$@"; do
                if [ -f $already_update_sql ]; then
                        sql=$(grep $line $already_update_sql)
                        printf "$sql"
                        if [ -z $sql ]; then
                                implement_sql $line $mysql_db
                             #   $MYSQL ${db} < $line
                                if [ $? == 0 ]; then
                                        echo "$line" >> $already_update_sql
                                        logger "${log_date}:${line} implement success"
                                else
                                        printf "$line implement faild\n"
                                        logger "$line implement faild"
                                        echo "$line" >> $already_update_sql
                                        exit 1
                                fi
                        else
                                printf "$line already implement\n"
                                logger "${log_date}:$line already implement"
                        fi
                else
                        implement_sql $line $mysql_db
                        if [ $? == 0 ]; then
                                echo "$line" >> $already_update_sql
                                logger "${log_date}:${line} implement success"
                        else
                                printf "$line implement faild\n"
                                logger "$line implement faild"
                                echo "$line" >> $already_update_sql
                                exit 1

                        fi
                fi
        done
}

#清理历史备份，根据特定天数备份最新的，并清理历史备份
function clean_history() {
    local day=$1
    if [ -d ${dump_directory} ]; then
    #如果最新的备份超过指定备份天数，重新备份最新的
    old_new_back=`ls -lt ${dump_directory} | grep dump | head -1 | awk '{print $NF}'`
    #获取文件生成时间，换算为秒
    filetimestamp=`stat -c %Y ${dump_directory}/${old_new_back}`
    #系统时间，换算为秒
    timestamp=`date +%s`
    printf "上次备份时间戳为: ${filetimestamp}\n"
    logger "上次备份时间戳为: ${filetimestamp}"
    #当前时间-文件生成时间
    timecha=$[$timestamp - $filetimestamp]
    #86400是一天
    back_time_s=$[86400 * ${day}]
    #如果最新的文件大于要删除的文件天数，就修改名称并修改时间
    if [[ ${timecha} -gt ${back_time_s} ]]; then
    mv ${dump_directory}/${old_new_back} ${dump_directory}/${timestamp}_${old_new_back}
    touch ${dump_directory}/${timestamp}_${old_new_back}
    fi
    find ${dump_directory} -mtime +${day} -name "*.dump" -exec rm -f {} \;
    fi
}


#main
check_conection_and_initialization

sql_file=`cat $implement_file`
echo $sql_file
if [ "$sql_file" != "" ]; then
update_sql $sql_file
else
logger "No incremental SQL"
printf "No incremental SQL\n"
clean_history $storage_days
exit 0
fi

clean_history $storage_days
