#!/bin/bash
IP=114.114.114.114
#IP=1.1.1.1
#Time out for second.
IP_TIMEOUT=1.5
IP_CODE=-1
#=======================================
URL=www.baidu.com
#URL=aaa.example.com
#Time out for second.
URL_TIMEOUT=2
URL_CODE=-1
#=======================================
PID=""
#PLS in put the process name want to kill for Finance which is: uswgi
PROCESS_NAME=check_ip
function check_ip_status()
{
    ping -c 3 -i 0.2 -W 1.5 $IP &> /dev/null
    if [ $? -eq 0 ];then
      IP_CODE=0
      #return 0
    else
      IP_CODE=1
      #return 1
    fi
}

function check_url_status()
{
    #Get http head code
    ret_code=`curl -I -s --connect-timeout $URL_TIMEOUT $URL -w %{http_code} | tail -n1`
    if [ "x$ret_code" = "x200" ]; then
      URL_CODE=0
      #Connection is ok！
      #return 0
    else
      URL_CODE=1
      #Connection is ERROR！
      #return 1
    fi
}

function kill_process()
{
# 获取需要kill 的进程名
PID_ARR=($(ps -auxf |grep $PROCESS_NAME |sed 1d |awk '{print $2}'))
for((i=0;i<${#PID_ARR[@]};i++))
do
    echo "All Arr is :${PID_ARR[@]}"
    echo "Kill process ${PID_ARR[$i]}"
    #kill -9 $PID_ARR[@]
    sleep 0.5
done
}

while true
do
echo "##########`date`"
check_ip_status
check_url_status
echo IP code is :$IP_CODE
echo URL code is :$URL_CODE
  if [[ "$IP_CODE" == 0 ]] && [[ "$URL_CODE" == 0 ]]; then
      echo "OK! IP_CODE:$IP_CODE ; URL_CODE:$URL_CODE"
    elif [[ "$IP_CODE" == 0 ]] && [[ "$URL_CODE" == -1 ]]; then
      echo "ERROR 2! IP_CODE:$IP_CODE ; URL_CODE:$URL_CODE"
      exit 2
    elif [[ "$IP_CODE" == -1 ]] && [[ "$URL_CODE" == 0 ]]; then
      echo "ERROR 3! IP_CODE:$IP_CODE ; URL_CODE:$URL_CODE"
      exit 3
    else
      kill_process
      echo "RECONFIRM! IP_CODE:$IP_CODE ; URL_CODE:$URL_CODE"
      exit 1
  fi
echo "##########end###########"
sleep 0.5
done
