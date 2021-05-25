#!/bin/bash
server_list="172.16.101.121,172.16.100.164,172.16.23.236,172.16.23.228,172.16.101.235,172.16.100.213"
server="172.16.101.121"
function foo() {
    if [[ $server_list =~ $server ]]; then
        echo "包含"
    else
        echo "不包含"
    fi

}

foo
diskSpace(){
  Publish_IP="172.16.23.53"
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
#            d_array=`sshpass -p password ssh admin@$diskSpace_IP df -h | grep $disk_path | awk '{print $5}' | awk -F "%" '{print $1}'`
#            echo ${d_array}
#            if [[  $d_array -ge 0 && $d_array != "" ]]; then
#                if [[ $d_array -ge 90 ]]; then
#                    echo $diskSpace_IP"磁盘空间使用率大于90%程序退出无法正常执行"
#                    set -e 	#注意，这句最重要，一定要先设置这个
#                    exit 1  #然后再退出，jenkins就会报红显示构建失败
#                elif [[  $d_array -lt 90 ]]; then
#                    echo $diskSpace_IP"磁盘空间使用率小于90%程序正常执行"
#                fi
#                    echo "查看的磁盘空间结束"
#            else
#                echo "非数字类型无法匹配程序退出，检查连接是否正常"
#                set	-e
#                exit 1
#            fi
#                echo "检查返回类型结束"
	done

}

#diskSpace
