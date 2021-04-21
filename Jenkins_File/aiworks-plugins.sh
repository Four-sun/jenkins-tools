#!/bin/bash

PASSWD_HOME=${JENKINS_HOME}/secret.txt
temp_path="/home/admin/temp"
temp_name="aiworks-plugins"
Publish_IP=${server}

function preparation(){
  echo "程序打包"
  cd ${WORKSPACE}
  python3 -V
  python3 setup.py bdist_wheel

}

function aiworks_plugins() {
sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh
  if [[ -d $temp_path/$temp_name ]]; then
      echo '文件夹存在则删除文件'
      rm -rf $temp_path/$temp_name/*
  else
      echo '创建文件夹'
      mkdir -p $temp_path/$temp_name
  fi
      echo '处理临时文件夹'
exit
remotessh

echo '复制文件到指定服务器'
sshpass -f ${PASSWD_HOME} scp -r dist/aiworks_plugins*.whl admin@$IP:$temp_path/$temp_name

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh

  echo 'pip install' `ls /home/admin/app/aiworks-plugins/ | grep aiwork*`

  /data/anaconda3/bin/pip install $temp_path/$temp_name/aiworks_plugins*.whl

exit
remotessh
}

function main(){
	array=(${Publish_IP//||/ })
	for IP in ${array[@]}
	do
	    echo "当前发布IP地址：$IP"
	    aiworks_plugins
	done
}

preparation

main


