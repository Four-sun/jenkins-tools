#!/bin/bash

Publish_IP=${server}
Base_IP="172.16.100.213"
PASSWD_HOME=${JENKINS_HOME}/secret.txt


diskSpace(){

	array_dist=(${Publish_IP//||/ })
	for diskSpace_IP in ${array_dist[@]}
	do
    	echo "当前检查磁盘IP地址：$diskSpace_IP"
    	echo "请选择您要查看的磁盘空间："
    	if [ $diskSpace_IP == "172.16.21.54" ] || [ $diskSpace_IP == "172.16.23.236" ]; then
          disk_path="/dev/vda3"
      else
          disk_path="/dev/mapper"
    	fi
    	    echo $disk_path
          d_array=`sshpass -p password ssh admin@$diskSpace_IP df -h | grep $disk_path | awk '{print $5}' | awk -F "%" '{print $1}'`
          echo ${d_array}
          if [[  $d_array -ge 0 && $d_array != "" ]]; then
            if [[ $d_array -ge 90 ]]; then
                echo $diskSpace_IP"磁盘空间使用率大于90%程序退出无法正常执行"
                set -e 	#注意，这句最重要，一定要先设置这个
                exit 1  #然后再退出，jenkins就会报红显示构建失败
            elif [[  $d_array -lt 90 ]]; then
                echo $diskSpace_IP"磁盘空间使用率小于90%程序正常执行"
            fi
                echo "查看的磁盘空间结束"
          else
            echo "非数字类型无法匹配程序退出，检查连接是否正常"
            set	-e
            exit 1
          fi
            echo "检查返回类型结束"
	done
}


preparation(){

  cd ${WORKSPACE}
  rm -rf runner/target
  rm -rf lib
  date
  /opt/dtstack/maven/bin/mvn clean package -U -DskipTests -Pproduct -Dmaven.compile.fork=true -T 1C
  date

  cd ${WORKSPACE}
  if [ ! -d "lib" ]; then
    mkdir lib
  fi
  if [ ! -d "logs" ]; then
    mkdir logs
  fi

  if [[ $server == '172.16.100.164' ]]; then

    echo "发布4.1环境"
  	cp streamapp-web/target/streamapp-web-*-with-dependencies.jar lib/

    if [[ -f `ls ./lib/streamapp-web-*-with-dependencies.jar` ]]; then
      echo "打包上传文件资源存在"
    else
      echo "打包上传文件资源不存在程序退出"
      set -e 	#注意，这句最重要，一定要先设置这个
      exit 1  #然后再退出，jenkins就会报红显示构建失败
    fi
      ls ./lib/
  else

   	echo "发布4.0环境"
    cp streamapp-runner/target/streamapp-runner-*-with-dependencies.jar lib/

    if [[ -f `ls ./lib/streamapp-runner-*-with-dependencies.jar` ]]; then
      echo "打包上传文件资源存在"
    else
      echo "打包上传文件资源不存在程序退出"
      set -e 	#注意，这句最重要，一定要先设置这个
      exit 1  #然后再退出，jenkins就会报红显示构建失败
    fi
      ls ./lib/
  fi
      echo "当前根据IP判断发布的版本"
}

dt-center-streamapp(){

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

if [[ -d /home/admin/temp/dt-center-streamapp ]]; then
	echo '文件夹存在则删除文件'
	rm -rf /home/admin/temp/dt-center-streamapp/*
else
	echo '创建文件夹'
	mkdir /home/admin/temp/dt-center-streamapp
fi
	echo '处理临时文件夹'

exit
remotessh

echo '复制文件到指定服务器'
sshpass -f ${PASSWD_HOME} scp -r lib/streamapp-*-with-dependencies.jar admin@$IP:/home/admin/temp/dt-center-streamapp/

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

echo '停止服务'
/home/admin/app/dt-center-streamapp/bin/centos_rdos_web.sh stop

echo '删除原有jar包'
rm -rf /home/admin/app/dt-center-streamapp/lib/streamapp-*-with-dependencies.jar

echo '复制jar包'
cp -r /home/admin/temp/dt-center-streamapp/streamapp-*-with-dependencies.jar /home/admin/app/dt-center-streamapp/lib

echo '启动应用'
bash  --login /home/admin/app/dt-center-streamapp/bin/centos_rdos_web.sh start

echo '删除临时文件'
rm -rf /home/admin/temp/dt-center-streamapp

exit
remotessh
}

function incrementSql() {

sshpass -f ${PASSWD_HOME} ssh admin@$Base_IP << remotessh

  /data/anaconda3/bin/python3 /home/admin/temp/jenkins_file.py ${group} ${project} ${GIT_BRANCH} ${mysql_server} ${mysql_base} ${increment_sql}

exit
remotessh
}

function check_incrementSql() {

  if [ -n "${increment_sql}" ] ;then
    if [  -n "${increment_server}" ]; then
      if [ -n "${group}" ]; then
        if [ -n "${project}" ]; then
          echo "执行增量SQL步骤"
          incrementSql
        else
          echo "检查project此步骤是否填写正确"
          set -e
          exit 1
        fi
      else
        echo "检查group此步骤是否填写正确"
        set -e
        exit 1
      fi
    else
       echo "检查increment_server此步骤是否填写正确"
       set -e
       exit 1
    fi
  else
    echo "增量SQL未勾选不执行此步骤"
  fi

}

function get_project() {
    if [ -n $JOB_NAME ]; then
      job_base_name=`echo $JOB_NAME |  awk -F '-test' '{print $1}'`
      printf $job_base_name
    else
      echo "ERROR JOB_NAME NOT FOUND"
      exit 1
    fi

    if [ $job_base_name == "dt-insight-engine" ]; then
      group="dt-insight-engine"
    else
      group="dt-insight-web"
    fi
    printf "group:$group,project:$job_base_name"
}

main(){
	array=(${Publish_IP//||/ })
	for IP in ${array[@]}
	do
		echo "当前发布IP地址：$IP"
	done
}

echo "获取项目信息"
get_project

echo "检查磁盘空间"
diskSpace

echo "发布准备"
#preparation

echo "项目发布"
#main

echo "执行增量SQL"
check_incrementSql


