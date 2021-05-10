#!/bin/bash
PASSWD_HOME=${JENKINS_HOME}/secret.txt
MYSQL_USER="drpeco"
MYSQL_PASSWORD="DT@Stack#123"
IP="172.16.100.213"

if [ -z "${project}" ];then
	echo "检查分组和项目有未勾选存在！"
    set -e
    exit 1
fi

if [ -z "${increment_sql}" ];then
	echo "检查增量SQL是否为空！"
    set -e
    exit 1
fi

if [ -z "${feature_branch}" ];then
	echo "检查feature_branch是否为空！"
    set -e
    exit 1
fi

if [ -z "${group}" ];then
	echo "检查group是否为空！"
    set -e
    exit 1
fi

if [ -z "${mysql_base}" ];then
	echo "检查mysql_base是否为空！"
    set -e
    exit 1
fi

if [ -z "${server}" ];then
	echo "检查server是否为空！"
    set -e
    exit 1
fi

function fetch_branch(){
    cd ${WORKSPACE}
    echo "----当前路径----"
    pwd
    date

    if [ ! -d "${project}" ];then
    	git clone -b ${feature_branch} ${git_repo}/${project}.git
    else
    	echo "文件夹已经存在"
        cd ${project}
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

function mv_increment_sql(){

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

    if [[ -d /home/admin/temp/increment/${project} ]]; then
        echo '文件夹存在则删除文件'
        rm -rf /home/admin/temp/increment/${project}/*
    else
        echo '创建文件夹'
        mkdir -p /home/admin/temp/increment/${project}
    fi
        echo '处理临时文件夹'

exit
remotessh

echo '复制文件到指定服务器'
sshpass -f ${PASSWD_HOME} scp -r ./${increment_sql} admin@$IP:/home/admin/temp/increment/${project}/

}

function check_increment_sql(){

    echo "----当前路径----"
    if [[ ${project} = "dt-uic" ]]; then
        cd ${WORKSPACE}/${project}/uic-web/sql/increment
    elif [[ ${project} = "DAGScheduleX" ]]; then
        cd ${WORKSPACE}/${project}/sql/4.0
    elif [[ ${project} = "dt-center-dataScience" && ${feature_branch} = "test_4.2.x" ]]; then
        cd ${WORKSPACE}/${project}/sql/increment/4.2.0
    else
        cd ${WORKSPACE}/${project}/sql/increment
    fi
        pwd

    if [ ! -f "${increment_sql}" ]; then
        echo "${increment_sql}不存在检查是否填写正确！"
        exit 1
    else
        mv_increment_sql
    fi

}

function action_sql(){

    sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh
    cd /home/admin/temp/
    pwd
    if [ ! -f "post_deploy.sh" ]; then
        echo "post_deploy.sh文件不存在！"
        exit 1
    else
        sh post_deploy.sh ${server} $MYSQL_USER $MYSQL_PASSWORD ${mysql_base} ${project} ${increment_sql}
    fi
        echo "----执行增量sql----"

exit
remotessh
}


function scp_implement(){

	cd ${WORKSPACE}

	sshpass -f ${PASSWD_HOME} scp admin@$IP:/home/admin/temp/implement.log .

   	database=`grep -wq "ERROR" implement.log && echo "fail" || echo "true"`
    echo $database

    if [ "$database" = "true" ]; then
    	echo "增量SQL执行成功！"
    else
		echo "增量SQL执行失败！"
        exit 1
    fi
}

git_repo=""
project=${project//,/ };
arr=($project);
server=${server//,/ };
server_arr=($server);
for each in ${arr[*]}
do
 	  project=`echo ${each} | sed 's/\"//g' `
	  echo "$group & ${project}"
      git_repo="http://gitlab.prod.dtstack.cn/${group}"

        echo "========STEP1:执行checkout${feature_branch}代码========"
      fetch_branch

      echo "========STEP2:检查文件SQL文件========"
      check_increment_sql

      echo "========STEP3:检查Server发布环境========"
      for server_each in ${server_arr[*]} ; do

        server=`echo ${server_each} | sed 's/\"//g' `
        echo "Server发布地址：$server"

        echo "========STEP4:执行post_deploy.sh文件插入SQL========"
        action_sql

        echo "========STEP5:检查SQL是否插入========"
        scp_implement

      done

done



function delete_incrementLog() {
    cd ${WORKSPACE}
    rm -rf implement.log
}