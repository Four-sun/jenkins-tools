#!/bin/bash

engine_restart(){

sshpass -f ${PASSWD_HOME} ssh admin@$diskSpace_IP << remotessh

  echo "diskSpace_IP：$diskSpace_IP"
  echo "PASSWD_HOME：$PASSWD_HOME"

  echo '停止服务'
  bash  --login /home/admin/app/dt-center-engine/bin/centos_rdos.sh stop

  echo '启动应用'
  bash  --login /home/admin/app/dt-center-engine/bin/centos_rdos.sh start

exit
remotessh

}

PASSWD_HOME="password"
Publish_IP="172.16.23.228"
array_dist=(${Publish_IP//||/ })

for diskSpace_IP in ${array_dist[@]}
  do
      echo "当前检查磁盘IP地址：$diskSpace_IP"
      engine_restart
done


