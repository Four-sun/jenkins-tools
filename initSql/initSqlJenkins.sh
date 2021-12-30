#!/bin/bash
PASSWD_HOME=${JENKINS_HOME}/secret.txt
MYSQL_USER="drpeco"
MYSQL_PASSWORD="DT@Stack#123"
IP="172.16.23.53"
INIT_SQL_PATH="/home/admin/temp/InitSql"

if [ -z "${server_project}" ];then
	echo "检查分组和项目有未勾选存在！"
    set -e
    exit 1
fi

if [ -z "${feature_branch}" ];then
	echo "检查feature_branch是否为空！"
    set -e
    exit 1
fi


if [ -z "${mysql_base}" ];then
	echo "检查mysql_base是否为空！"
    set -e
    exit 1
fi

function git_fetch_branch(){
    # 下载项目git工程
    cd ${WORKSPACE}
    echo "----当前路径----"
    if [ ! -d "${server_project}" ];then
    	git clone -b ${feature_branch} ${git_repo}/${server_project}.git
    else
    	echo "文件夹已经存在"
        cd ${server_project}
        git fetch origin --prune
        rm -rf remotelist
        rm -rf pulllog
        git branch -a > remotelist
    	if grep -iw "${feature_branch}" remotelist; then
    		echo "========== ${feature_branch} is exist in remote ,please check first ========"
    	else
    		echo "========== ${feature_branch} is not exist in remote ,please check first ========"
        	exit 1
    	fi
        git checkout -f ${feature_branch}
        git branch --set-upstream-to=origin/${feature_branch} ${feature_branch}
        git pull > pulllog
        if grep -E "CONFLICT" pulllog;then
            echo "ERROR: pull分支${feature_branch}存在冲突！！！"
      		rm -rf pulllog
      		git reset --hard ${feature_branch}
      		exit 1
        fi
    fi

}

function mv_init_sql(){
# 复制本地的sql文件到服务器上
sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

    if [[ -d ${INIT_SQL_PATH}/${project}/${project} ]]; then
        echo '文件夹存在则删除文件'
        rm -rf ${INIT_SQL_PATH}/${project}/${project}/*
    else
        echo '文件夹不存在创建文件夹'
        mkdir -p ${INIT_SQL_PATH}/${project}/${project}
    fi
        echo '处理临时文件夹'

exit
remotessh

echo '复制文件到指定服务器'
sshpass -f ${PASSWD_HOME} scp -r ${WORKSPACE}/${server_project}/sql/* admin@$IP:${INIT_SQL_PATH}/${project}/${project}/

}

function get_init_project() {
# 通过jenkins上配置的server_project转换成project参数
# Api|Assets|Batch|Datascience|dtuic|EasyIndex|Engine|Gateway|Message|PublicService|Stream|Tag|Valid

    if [ "${server_project}" == "dt-center-streamapp" ]; then
        project="Stream"
    elif [ "${server_project}" == "dt-center-api" ]; then
        project="Api"
    elif [ "${server_project}" == "dt-center-assets" ]; then
        project="Assets"
    elif [ "${server_project}" == "dt-center-ide" ]; then
        project="Batch"
    elif [ "${server_project}" == "dt-center-dataScience" ]; then
        project="Datascience"
    elif [ "${server_project}" == "dt-uic" ]; then
        project="dtuic"
    elif [ "${server_project}" == "dt-center-easyindex" ]; then
        project="EasyIndex"
    elif [ "${server_project}" == "DAGScheduleX" ]; then
        project="Engine"
    elif [ "${server_project}" == "dt-center-api-gateway" ]; then
        project="Gateway"
    elif [ "${server_project}" == "dt-center-message" ]; then
        project="Message"
    elif [ "${server_project}" == "dt-public-service" ]; then
        project="PublicService"
    elif [ "${server_project}" == "dt-center-tagapp" ]; then
        project="Tag"
    elif [ "${server_project}" == "dt-center-valid" ]; then
        project="Valid"
    else
      echo "请选择正确的项目名称"
      exit 1
    fi
        echo "${project}"
}

function action_sql(){

    sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

    if [ ! -f "/home/admin/temp/InitSql/${project}/post_deploy.sh" ]; then
        echo "ERROR fail post_deploy.sh文件不存在！"
        exit 1
    else
        sh /home/admin/temp/InitSql/initSql.sh ${server_path} ${mysql_base} ${project}
    fi
        echo "----执行增量sql----"

exit
remotessh
}


function main() {
    git_repo=""
    get_init_project
    server_path=${server_path//,/ };
    git_repo="http://gitlab.prod.dtstack.cn/${group}"
    echo "${git_repo}"

    echo "========STEP1:执行checkout${feature_branch}代码========"
    git_fetch_branch

    echo "========STEP2:复制本地sql执行文件到服务器========"
    mv_init_sql

    echo "========STEP3:执行初始化SQL插入脚本========"
    action_sql

    echo "========STEP4:验证SQL是否执行完成========"

}

main
