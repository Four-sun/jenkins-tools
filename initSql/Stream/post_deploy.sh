#!/bin/bash


#################################
#Script: post_deploy.sh
#Author: 亚东(lvyadong@dtstack.com)
#Data: 2021-06-01
#Desciption: 完成web应用sql组件初始化sql操作
#Usage: ./post_deploy.sh ${mysql_host} ${mysql_user} ${mysql_pass} ${mysql_port} ${mysql_db}
#################################

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
implement_route=$6
#增量sql开始执行文件名
star_implement_file=$7
#是否执行增量sql
is_exec_implement=$8
#需要刷的初始化sql文件
exec_init=./exec_init.sql
#不用执行的初始化增量sql
not_exec_implement=./not_exec_implement.sql
#定义脚本全局变量
#定义datetime变量
log_date_hms=$(date +"%Y-%m-%d-%H:%M:%S")
log_date=$(date +"%Y-%m-%d")
datetime=$(date +%Y%m%d_%H%M%S_%N | cut -b1-20)
date=$(date +%Y%m%d)
#mysql_home/bin/
MYSQL_BIN=/opt/dtstack/DTBase/mysql/bin
#日志目录
log_directory=/data/sqllog/${mysql_db}
#日志文件
log_file=${log_directory}/sql_deploy_${log_date}.log
#记录已经刷过的sql文件
already_implement_sql=${log_directory}/deploy_exec_${mysql_db}.sql


if [ -d ${MYSQL_BIN} ]; then
	MYSQL="${MYSQL_BIN}/mysql -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port}"
else
	MYSQL="mysql -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port}"
fi



#创建log目录
mkdir -p $log_directory
if [ $? != 0 ]; then
  logger "${log_directory} create faild"
  printf "${log_directory} create faild\n"
fi


#定义日志输出
function logger() {
    echo -e "${log_date_hms}:\e[32m${1}\e[0m" >> ${log_file}
}

#检测mysql连接以及是否初始化
check_conection_and_initialization() {
	$MYSQL -e "show databases;"
	if [ $? = 0 ]; then
		printf "Connection successful:${MYSQL}\n"
		logger "Connection successful:${MYSQL}"
	else
		printf "Connection fail:${MYSQL}\n"
		logger "Connection fail:${MYSQL}"
		exit 1
	fi
}

##create database
function create_database() {

    local mysql_db=$1

 if [ ! $($MYSQL -e "use ${mysql_db}") ]; then

		printf "create database "${mysql_db}"\n"

		$MYSQL -e "CREATE DATABASE IF NOT EXISTS ${mysql_db} DEFAULT CHARSET utf8 COLLATE utf8_general_ci;"
		if [ $? != 0 ]; then
			printf "database create faild:${mysql_db}!\n"
			logger "database create faild:${mysql_db}!"
			exit 1

		fi

	fi

}


##############################
#Desciption：执行sql文件
#args: $1:sql文件名
##############################
function implement_sql() {
	local sql=$1
	printf "start implement ${sql}\n"
	logger "start implement ${sql}"
	#记录sql执行
  echo "${log_date_hms}:${sql}" >> ${already_implement_sql}
	nohup $MYSQL --tee=${log_file} ${mysql_db} < ${sql} >> ${log_file} 2>&1
	if [ $? == 0 ]; then
		logger "${sql} implement success"
	else
		printf "${sql} implement faild\n"
		logger "${sql} implement faild"
		exit 1
	fi
}





##############################
#Desciption：获取需要执行的增量sql文件
#args: $1:不用执行的初始化增量sql
##############################
function implement_update_sql() {
        local not_exec_sql=$1
        #拿到所有增量sql文件
        ls -l $implement_route | grep sql | awk '{print $NF}' >${implement_route}/full_implement_update_file.txt
        #获取需要执行的增量sql
        update_sql=$(tail -n +$(sed -n "/${star_implement_file}/=" ${implement_route}/full_implement_update_file.txt) ${implement_route}/full_implement_update_file.txt)
        #过滤不需要执行的sql文件,然后执行sql文件
        echo $update_sqlcat
        for line in $update_sql; do
                if [ -f $not_exec_sql ]; then

                        is_exec=$(grep ${line} ${not_exec_sql})

                        if [ "$is_exec" = "" ]; then

                                implement_sql "${implement_route}${line}"

                        fi

                else
                  implement_sql "${implement_route}${line}"
                fi

        done

}




#执行sql文件，执行失败即退出，返回错误：1
function import_sql() {

	local exec_init_sql=$1
	tables=$($MYSQL -e "show tables from ${mysql_db}")

  #判断是否是第一次部署
	if [ "$tables" == "" ]; then

		printf "init ${mysql_db}\n"
		logger "init ${mysql_db}"

		if [ -f $exec_init_sql ]; then
		  #拿到所有的初始化sql，遍历执行
			exec_sql=$(cat $exec_init_sql)
			for line in $exec_sql; do
				implement_sql "$line"
			done

		else
			printf "not found exec_init.sql\n"
			logger "not found exec_init.sql"
			exit 1
		fi

	else
		printf "${mysql_db} has been initialized\n"
		logger "${mysql_db} has been initialized"
		exit 0
	fi
}

function customized_exec() {

    if [ -f "customized.sql" ]; then

    implement_sql "customized.sql"

    fi


}


#main
check_conection_and_initialization
create_database ${mysql_db}
import_sql $exec_init
if [ ${is_exec_implement} == "yes" ]; then
implement_update_sql $not_exec_implement
fi
customized_exec
