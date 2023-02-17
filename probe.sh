#!/bin/bash
dst_list=(www.baidu.com)

dst_list=$1
#lnum=${#dst_list[@]}




func chkCurl(){
		


}

func ChkCurl(){
        i=0
        while [ $i -lt 2 ]
        do
		curl --max-time 1 -I -m 10 -o /dev/null -s -w %{http_code}"\n" -L  http://${dst_list[$i]}
                curl http://${dst_list[$i]} &>/dev/null
                if [ $? -eq 0 ];then
                        action "${dst_list[$i]}" /bin/ture
                else
                        action "${dst_list[$i]}" /bin/false
                fi
                let i++
        done
}

func inputArr(){

	arr=$*
}

func main(){
while true
do
        ChkCurl
        sleep 3
 
done
}

main

