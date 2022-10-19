# 该镜像基于最新的CentOS7官方镜像进行构建
FROM centos:centos7.9.2009
MAINTAINER kid20221012 shuanglulee@foxmail.com
# 设置工作目录
WORKDIR /
# 安装 epel-release 包
RUN yum install -y epel-release
#替换镜像源
RUN sed -e 's!^metalink=!#metalink=!g' \
        -e 's!^#baseurl=!baseurl=!g' \
        -e 's!//download\.fedoraproject\.org/pub!//mirrors.tuna.tsinghua.edu.cn!g' \
        -e 's!//download\.example/pub!//mirrors.tuna.tsinghua.edu.cn!g' \
        -e 's!http://mirrors!https://mirrors!g' \
        -i /etc/yum.repos.d/epel*.repo
RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
        -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
        -i.bak \
        /etc/yum.repos.d/CentOS-*.repo
# 安装基础的工具链
RUN yum install -y tmux net-tools qperf iperf3 vim wget lrzsz tree screen lsof tcpdump nmap telnet dos2unix unix2dos bash-completion OpenIPMI-tools sysstat iptraf ntp zlib-devel ncurses-devel openssl openssh-serve openssl-devel mysql-devel mysql supervisor git redis gcc gcc-c++ golang htop iperf iftop iproute less unzip zip tcpdump nmap yum-util nfs-utils iotop java-1.8.0-openjdk && yum clean all
#RUN yum install -y net-tools vim wget lrzsz tree screen lsof tcpdump nmap telnet dos2unix unix2dos bash-completion OpenIPMI-tools sysstat iptraf ntp zlib-devel ncurses-devel openssl openssh-serve openssl-devel mysql-devel mysql supervisor git redis gcc gcc-c++ golang htop iperf iftop less unzip zip tcpdump nmap yum-util nfs-utils iotop java-1.8.0-openjdk  &>/dev/null && yum clean all
# 拷贝启动脚本
COPY ["tini-amd64-0.19.0","docker-entrypoint.sh","check_pod_health.sh","/" ]
# 启动镜像默认运行挂起脚本
#CMD [ "/check_pod_health.sh" ]
#ENTRYPOINT [ "/bin/bash", "-c","/docker-entrypoint.sh &", "/bin/bash", "-c", " /check_pod_health.sh &" ]

# 添加tini作为初始1号进程,并执行不退出脚本
ENTRYPOINT ["/tini", "--"] 
CMD ["/docker-enterpoint.sh"]
