#!/bin/bash
#url=http://192.168.4.5/index.html
url=$1

check_http(){
status_code=$(curl --max-time 1 -I -m 10 -o /dev/null -s -w %{http_code}"\n" -L  $url)
#status_code=$(curl -m 5 -s -o /dev/null -w %{http_code} $url)
}

while true
do
	c=check_http
	if [ $i != 200 ];
		echo "url unaccessable!";
		continue
	elif [ $i = 200 ];



while :
do
       check_http
       date=$(date +%Y%m%d-%H:%M:%S) 
#生成报警邮件的内容
       echo "当前时间为:$date
       $url服务器异常,状态码为${status_code}.
       请尽快排查异常." > /tmp/http$$.pid
       
#指定测试服务器状态的函数，并根据返回码决定是发送邮件报警还是将正常信息写入日志
       if [ $status_code -ne 200 ];then
              mail -s Warning root < /tmp/http$$.pid
       else
              echo "$url连接正常" >> /var/log/http.log
       fi
       sleep 5
done
