#!/usr/bin/env expect

set sql_file [lindex $argv 0]
set database [lindex $argv 1]
set mysqlserver [lindex $argv 2]
spawn  /opt/dtstack/DTBase/mysql/bin/mysql -S /data/my3306/run/mysql.sock -h $mysqlserver  -u drpeco -p

expect "password:"
send "DT@Stack#123\r"

expect "mysql&gt;"
send "tee /home/admin/temp/implement.log;\r"

expect "mysql&gt;"
send "use $database;\r"

expect "mysql&gt;"
send "source $sql_file;\r"

expect "mysql&gt;"
send "quit;\r"

expect eof

