
def check_disk_used(host, user, pwd, disk_partition, disk_threshold) {
	def cmd_du_partition = "sshpass -p ${pwd} ssh ${user}@${host} \"df -h |grep -w ${disk_partition}|grep -v docker |awk '{print \\\$5}' |awk -F '%' '{print \\\$1}' \""
	def du_partition = sh (returnStdout: true, script: "${cmd_du_partition}").trim().toInteger()
	echo "du_partition = ${du_partition}"
	du_partition=100- du_partition
	if(du_partition < disk_threshold) {
		echo "Disk used check error."
		sh "exit 1"
	}
}

