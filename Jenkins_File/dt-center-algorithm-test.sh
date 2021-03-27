#!/bin/bash

PASSWD_HOME=${JENKINS_HOME}/secret.txt
#Server=${server}
#IP="172.16.101.159"
temp_path="/home/admin/temp"
temp_name="dt-center-algorithm"
#Kerberos_server="172.16.101.159||172.16.101.207||172.16.101.228||172.16.100.190"
Kerberos_server="172.16.101.159"
#unKerberos_server="172.16.101.227||172.16.101.196||172.16.100.175||172.16.100.214"
unKerberos_server="172.16.101.227"
krbt_env="true"

diskSpace(){
	array_dist=(${Publish_IP//||/ })
	for diskSpace_IP in ${array_dist[@]}
	do
    	echo "当前检查磁盘IP地址：$diskSpace_IP"
    	echo "请选择您要查看的磁盘空间："
    	if [[ $diskSpace_IP == "172.16.21.54" ]] || [[ $diskSpace_IP == "172.16.23."* ]]; then
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
  echo "程序打包"
  tar cvf $temp_name.tar *
}

server_ip(){
  if [ $krbt_env = "true" ]; then
    Publish_IP=${server}"||"${Kerberos_server}
  else
    Publish_IP=${server}"||"${unKerberos_server}
  fi
    echo $Publish_IP
}

algorithm_path(){
  if [[ $Publish_IP == "172.16.23."* ]]; then
      algorithm_path="/opt/dtstack/DTAiworks"
  else
      if [[ $krbt_env = "true" ]] && [[ $Kerberos_server =~ $IP ]]; then
          algorithm_path="/home/hdfs"
      else
          algorithm_path="/home/admin/app"
      fi
  fi
    echo  "algorithm_path:"$algorithm_path
}

algorithm(){
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
sshpass -f ${PASSWD_HOME} scp -r $temp_name.tar admin@$IP:$temp_path/$temp_name

sshpass -f ${PASSWD_HOME} ssh admin@$IP << remotessh
  echo '解压文件'
  cd $temp_path/$temp_name && tar xvf $temp_name.tar

  echo '复制jar包'
  if [[ $krbt_env = "true" ]] && [[ $Kerberos_server =~ $IP ]] ; then
    if [[ -d $algorithm_path/$temp_name ]]; then
        echo '文件夹存在则删除文件'
        sudo rm -rf $algorithm_path/$temp_name/*
    else
        echo '创建文件夹'
        sudo mkdir -p $algorithm_path/$temp_name
    fi
    sudo cp -r $temp_path/$temp_name/* $algorithm_path/$temp_name/
    echo 'kerberos环境修改hdfs权限'
    sudo chown -R hdfs:hdfs $algorithm_path/$temp_name
  else
    if [[ -d $algorithm_path/$temp_name ]]; then
        echo '文件夹存在则删除文件'
        rm -rf $algorithm_path/$temp_name/*
    else
        echo '创建文件夹'
        mkdir -p $algorithm_path/$temp_name
    fi
    cp -r $temp_path/$temp_name/* $algorithm_path/$temp_name/
  fi
  echo '删除临时文件'
#  rm -rf $temp_path/$temp_name
exit
remotessh
}

main(){
	array=(${Publish_IP//||/ })
	for IP in ${array[@]}
	do
	    algorithm_path
    	algorithm
		  echo "当前发布IP地址：$IP"
	done
}

server_ip
#diskSpace
#preparation
#main

