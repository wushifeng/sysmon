# 目的

做性能测试时，检测主机的性能指标，CPU IO 网卡等
使用步骤
1 部署运行 sysmon 容器，注意如下几点

- config/node_host_info.json 中设置好要监控的主机 ip
- 数据目录清理和准备好　 data/grafana
- 确保被监控主机和 sysmon 网络可达
- 容器的 ip --network bridge --ip 172.17.0.10
  [docker 配置容器与主机 IP 同一网段 https://www.jianshu.com/p/4d8605bea2bb ,这个麻烦的话，主要是客户场景为为了减少被监控主机的消耗，可以使用 pushgateway]

２ 　被监控主机上运行 node_exporter-1.0.1.linux-amd64.tar.gz

- 该主机的 9100 端口需要开放给上面的容器服务

３　被监控主机上运行需要进行性能测试的主机，一般为了保证系统的平稳，对于的程序需要运行２０分钟以上

- sysmon 的 http://*:3000　服务即可查看监控数据[admin/admin]

# 概要

config 运行的配置文件，监控的 node 可以修改，重启容器
data 运行结果，可以独立拷贝查看

版本运行文件和代码
grafana-7.1.0.linux-amd64.tar.gz grafana-7.1.0.tar.gz  
ProcMon-for-Linux-1.0.tar.gz：微软新开源的 procmon 的 linux 版本
prometheus-2.15.1.linux-amd64.tar.gz
node_exporter-1.0.1.linux-amd64.tar.gz
Dockerfile 生成 docker 的文件

daemon.sh： docker 中运行的守护
sysmon.sh：外部程序如何运行起来，也可以改成 docker-compose 形式
grafana.sh：官方一些 docker 镜像的例子
