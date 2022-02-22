#!/bin/bash

Publish_IP=${server}
PASSWD_HOME=${JENKINS_HOME}/secret.txt
PROJECT_NAME="dt-center-ide"


preparation(){

  cd ${WORKSPACE}
  rm -rf runner/target/runner-origin # maven编译后的jar包地址
  rm -rf lib # maven编译后的jar包地址拷贝到lib目录下
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

  echo "发布环境"
  cp runner/target/runner-origin/*dependencies.jar lib/

  if [[ -f `ls ./lib/*dependencies.jar` ]]; then
    echo "打包上传文件资源存在"
  else
    echo "打包上传文件资源不存在程序退出"
    set -e 	#注意，这句最重要，一定要先设置这个
    exit 1  #然后再退出，jenkins就会报红显示构建失败
  fi
    ls ./lib/

}

push_option(){

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

if [[ -d /home/admin/temp/${PROJECT_NAME} ]]; then
	echo '文件夹存在则删除文件'
	rm -rf /home/admin/temp/${PROJECT_NAME}/*
else
	echo '创建文件夹'
	mkdir /home/admin/temp/${PROJECT_NAME}
fi
	echo '处理临时文件夹'

exit
remotessh

echo '复制文件到指定服务器'
sshpass -f ${PASSWD_HOME} scp -r lib/*dependencies.jar admin@$IP:/home/admin/temp/${PROJECT_NAME}/

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

echo '停止服务'
/home/admin/app/${PROJECT_NAME}/bin/centos_rdos_web.sh stop

echo '删除原有jar包'
rm -rf /home/admin/app/${PROJECT_NAME}/lib/*dependencies.jar

echo '复制jar包'
cp -r /home/admin/temp/${PROJECT_NAME}/*dependencies.jar /home/admin/app/${PROJECT_NAME}/lib

echo '启动应用'
bash  --login /home/admin/app/${PROJECT_NAME}/bin/centos_rdos_web.sh start

echo '删除临时文件'
rm -rf /home/admin/temp/${PROJECT_NAME}

exit
remotessh
}

main(){
	array=(${Publish_IP//||/ })
	for IP in ${array[@]}
	do
    	push_option
		echo "当前发布IP地址：$IP"
	done
}

echo "发布准备"
preparation

echo "项目发布"
main

