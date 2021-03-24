#!/bin/bash
PASSWD_HOME=${JENKINS_HOME}/secret.txt
flinkPlugin="syncplugin"
ss_server="172.16.101.227"
flinkPluginPath="/opt/dtstack/110_flinkplugin/$flinkPlugin"
hdfsPluginPath="/dtInsight/flink110/110_flinkplugin/$flinkPlugin"

hdfs dfs -rm -r /dtInsight/flink110/110_flinkplugin/sqlplugin
hdfs dfs -put $flinkPluginPath  /dtInsight/flink110/110_flinkplugin/sqlplugin

function updateFlinkPlugin(){

if [[ $server == "172.16.21.54||172.16.23.236" ]] || [[ $server == "172.16.23.53||172.16.23.228" ]]; then
echo "4.2环境需要上传HDFS文件"
sshpass -f ${PASSWD_HOME} ssh admin@$ss_server << remotessh
  if [[ -d $flinkPluginPath ]]; then
    echo '文件夹存在则删除文件'
    rm -rf $flinkPluginPath/*
  else
    echo '创建文件夹'
    mkdir $flinkPluginPath
  fi
    echo '处理临时文件夹'

exit
remotessh

sshpass -f ${PASSWD_HOME} scp -r $flinkPlugin/* admin@$ss_server:$flinkPluginPath

sshpass -f ${PASSWD_HOME} ssh admin@$ss_server << remotessh

  echo '删除原有HDFS项目'
  hdfs dfs -rm -r $hdfsPluginPath

  echo 'HDFS上传Plugin包'
  hdfs dfs -put $flinkPluginPath  $hdfsPluginPath

exit
remotessh
fi

}

