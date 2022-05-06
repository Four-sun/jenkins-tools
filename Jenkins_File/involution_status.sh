#!/bin/bash
RUN_HOME_INVOLUTION="/home/admin/app/involution"
RUN_HOME_INVOLUTION_WEB="/home/admin/app/involution_web"
GET_PORT=`netstat -lnt | grep 10087 | awk -F '[ :]+' '{print $5}'`
if [[ "$GET_PORT" = "10087" ]]; then
   echo "Involution is Running"
else
   echo "Involution is Stopped"

   cd "$RUN_HOME_INVOLUTION"
   nohup ./bash.sh start >nohup.out 2>&1 &

   cd "$RUN_HOME_INVOLUTION_WEB"
   nohup ./bash.sh start >nohup.out 2>&1 &
fi
   echo `netstat -lnt | grep 10087 | awk -F '[ :]+' '{print $5}'`
