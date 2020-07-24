#!/bin/bash
:<<EOF
sh dnet.sh br0 eth0 192.168.1.2/24 192.168.1.1
docker run -itd --name testweb1 nginx
pipework br0 testweb1 192.168.1.3/24@192.168.1.1
EOF

#like br0 要创建的桥接设备名
BRNAME=$1
#like eth0 要矫健的网络接口名
IFNAME=$2
#192.168.1.2/24 当前主机IP
LOCALIP=$3
#192.168.1.1 当前主机网关
GWIP=$4
# 注意如果此脚本出错会导致主机离线,无法进行网络访问,请做好应急预案
yum install -y net-tools iproute2  bridge-utils #git
#git clone https://github.com/jpetazzo/pipework
cp pipework/pipework /usr/local/bin/
(ip link add dev "$BRNAME" type bridge > /dev/null 2>&1) || (brctl addbr "$BRNAME")
ip link set "$BRNAME" up
ip addr add $LOCALIP dev $BRNAME; \
ip addr del $LOCALIP dev $IFNAME; \
brctl addif $BRNAME $IFNAME; \
ip route del default; \
ip route add default via $GWIP dev $BRNAME
