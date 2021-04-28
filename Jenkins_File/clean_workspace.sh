#!/bin/bash

clean_file="/logs/"
project_base_path="/home/admin/app/"
current_time=`date "+%Y-%m-%d %H:%M:%S"`
project_list="dt-center-dataScience,dt-center-tagapp,dt-center-engine,dt-assets,dt-center-api,dt-center-gateway,dt-center-ide,dt-center-streamapp,dt-center-valid"
clean_log="/home/admin/temp/clean_log.log"

function while_clean() {
  find_clean_project_path=`find $project_path -maxdepth 1 -type f -size +1M`
  array=(${find_clean_project_path// / })
  for project in ${array[@]}
	do
	    echo  "清理时间："$current_time ,"当前文件超过预定大小,日志文件地址："$project >> $clean_log
      echo "" > $project
  done
}

function clean_project(){
	array=(${project_list//,/ })
	for PROJECT in ${array[@]}
	do
	    project_path=$project_base_path$PROJECT$clean_file
	    echo "当前清理项目:"$PROJECT
	    echo "当前清理项目地址:"$project_path
      while_clean
	done
}

function other_clean() {

    echo `find /home/admin/app/dt-center-engine/logs/rdos_*-*.log -maxdepth 1  -type f` >> $clean_log

    find /home/admin/app/dt-center-engine/logs/rdos_*-*.log -maxdepth 1  -type f  | xargs rm -rf

    echo `find /home/admin/app/dt-center-tagapp/logs/*-*-*.log -maxdepth 1  -type f` >> $clean_log

    find /home/admin/app/dt-center-tagapp/logs/*-*-*.log -maxdepth 1  -type f  | xargs rm -rf

    echo `find /home/admin/app/dt-uic/logs/*-*-*.log -maxdepth 1  -type f` >> $clean_log

    find /home/admin/app/dt-uic/logs/*-*-*.log -maxdepth 1  -type f  | xargs rm -rf

}


echo "清理日志文件"

other_clean

clean_project


