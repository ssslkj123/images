#!/bin/bash

echo "[INFO] 开始运行"
PID="$$"
#PID="$!"
# 上一条命令的PID
echo "process PID is $PID ."
#java -jar app.jar &
while /bin/true
do
  echo "This script make docker do not exit $(date) !"
  #sleep 10m
  tail -f /dev/null
done
wait
