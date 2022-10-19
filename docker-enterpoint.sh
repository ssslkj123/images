#!/bin/bash
echo My PID is $$.

echo "[INFO] 开始运行"

_kill() {
  echo "[INFO] Receive sigterm"
  kill $PID
  wait $PID
  exit 143
}

looptail(){
while /bin/true
do
  #trap _kill SIGTERM
  echo "This script make docker do not exit $(date) !"
  #sleep 10m
  tail -f /dev/null 
  #break
  #wait
done
}

trap _kill SIGTERM
looptail &


PID="$!"
#PID="$$"
#java -jar app.jar &
echo "looptail PID is $PID ."

wait

