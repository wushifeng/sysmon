#!/bin/bash
:<<EOF
配置变更时，执行本脚本进行清理和重启
 config 目录下是配置文件
 data 目录下是数据文件
EOF

#清理历史数据，重新运行时都是历史数据
docker rm -f sysmon
sudo rm -rf data/*
mkdir -p data/grafana
# rm -rf data; mkdir -p data/grafana; docker rmi sysmon; docker build . -t sysmon

# MODE1 默认的网络模式 NAT
# docker run -itd -v $(pwd)/config:/opt/config -v $(pwd)/data:/prometheus -p 9090:9090 -p 3000:3000 --name sysmon sysmon

# MODE2 
docker run --privileged -itd -v $(pwd)/config:/opt/config -v $(pwd)/data:/prometheus --network host --name sysmon sysmon

# 查看监控服务的日志信息
# docker logs sysmon -f

# 配置不变时，直接执行 docker restart sysmon 即可