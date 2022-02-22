#!/bin/bash

#定义输入
#mysql ip
mysql_host=$1
#mysql user
mysql_user="drpeco"
#mysql password
mysql_pass="DT@Stack#123"
#mysql port
mysql_port="3306"
#mysql database
mysql_db=$2
#是否执行增量sql
is_exec_implement="yes"
#执行sql的项目(Api|Assets|Batch|Datascience|dtuic|EasyIndex|Engine|Gateway|Message|PublicService|Stream|Tag|Valid)
is_exec_project=$3
#执行sql的项目地址
is_exec_project_path="/home/admin/temp/InitSql"
#mysql_home/bin/
MYSQL_BIN=/opt/dtstack/DTBase/mysql/bin

if [ -d ${MYSQL_BIN} ]; then
	MYSQL="${MYSQL_BIN}/mysql -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port}"
else
	MYSQL="mysql -h${mysql_host} -u${mysql_user} -p${mysql_pass} -P${mysql_port}"
fi


# 判断已存在执行的库名存在则报错
function is_database_check() {

  tables=$($MYSQL -e "show tables from ${mysql_db}")
  #判断db已存在
	if [ "$tables" != "" ]; then
      printf "${mysql_db} has been initialized\n"
      exit 1
	fi

}
# 判断执行的项目
function project_check() {
    project_result=$(echo "Api|Assets|Batch|Datascience|dtuic|EasyIndex|Engine|Gateway|Message|PublicService|Stream|Tag|Valid" | grep ${is_exec_project} )

    if [ "$project_result" != "" ]; then
        if [ "${is_exec_project}" == "Engine" ]; then
            #增量sql开始执行文件名
            star_implement_file="20210510120000_v4.2.x.sql"
        elif [ "${is_exec_project}" == "Api" ]; then
            star_implement_file="202104061716_v4.2.1.sql"
        elif [ "${is_exec_project}" == "Assets" ]; then
            star_implement_file="202107231000_4.3.x.sql"
        elif [ "${is_exec_project}" == "Batch" ]; then
            star_implement_file="202106211130_v4.3.x.sql"
        elif [ "${is_exec_project}" == "Datascience" ]; then
            star_implement_file="202103291016_v4.2.0_beta.sql"
        elif [ "${is_exec_project}" == "dtuic" ]; then
            star_implement_file="202106081500_4.2.2.sql"
        elif [ "${is_exec_project}" == "EasyIndex" ]; then
            star_implement_file="202110181021_v4.3.0.sql"
        elif [ "${is_exec_project}" == "Gateway" ]; then
            star_implement_file="202108271000_v4.3.2.sql"
        elif [ "${is_exec_project}" == "Message" ]; then
            star_implement_file="202109241724_v4.3x.sql"
        elif [ "${is_exec_project}" == "PublicService" ]; then
            star_implement_file="20210630144200_v4.2.x.sql"
        elif [ "${is_exec_project}" == "Stream" ]; then
            star_implement_file="202107080619_v4.3.x.sql"
        elif [ "${is_exec_project}" == "Tag" ]; then
            star_implement_file="20210616120000_v4.2.5.sql"
        elif [ "${is_exec_project}" == "Valid" ]; then
            star_implement_file="202107191512_v4.3.0.sql"
        fi
            #默认增量sql地址
            implement_route="${is_exec_project_path}/${is_exec_project}/${is_exec_project}/increment/"
            #执行post_deploy地址
            project_path="${is_exec_project_path}/${is_exec_project}/post_deploy.sh"

        if [ "${is_exec_project}" == "Engine" ]; then
            #增量sql文件相对路径
            implement_route="${is_exec_project_path}/${is_exec_project}/${is_exec_project}/4.0/"
        fi

    else
        printf "执行项目填写错误\n"
        exit 1
    fi
        printf "开始执行初始化shell脚本\n"
        cd ${is_exec_project_path}/${is_exec_project}
        sh ${project_path} ${mysql_host} ${mysql_user} ${mysql_pass} ${mysql_port} ${mysql_db} ${implement_route} ${star_implement_file} ${is_exec_implement}
}

#main
is_database_check
project_check
