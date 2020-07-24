# docker rmi sysmon; docker build . -t sysmon

FROM centos:7.4.1708

# https://github.com/prometheus/prometheus/releases 下载 prometheus-2.15.1.linux-amd64.tar.gz
ADD prometheus-2.15.1.linux-amd64.tar.gz /opt/.
ADD grafana-7.1.0.linux-amd64.tar.gz /opt/.
COPY daemon.sh /

RUN ln -s /opt/prometheus-2.15.1.linux-amd64 /opt/prometheus; mkdir -p /etc/prometheus/; \
    ln -s /opt/config/prometheus.yml /etc/prometheus/prometheus.yml; \
    yum install tcpdump -y; yum install net-tools.x86_64 -y; \
    mkdir -p /prometheus/grafana; ln -s /opt/grafana-7.1.0 /opt/grafana; chmod +x /*.sh

USER root

EXPOSE     9090 3000
ENTRYPOINT [ "/daemon.sh" ]