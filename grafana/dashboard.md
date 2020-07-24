# grafana

```
grafana的展示开源组件地址，这里根据类别可以找到很多配置好的
https://grafana.com/grafana/dashboards

Node Exporter是linux系列类的主机监控
https://github.com/prometheus/node_exporter

https://grafana.com/grafana/dashboards/8919
Node Exporter for Prometheus Dashboard CN v20200628

https://grafana.com/grafana/dashboards/9096
Node Exporter 1.0.0
Node Exporter: 1.x.x+
- job_name: server1
  static_configs:
    - targets: ['192.168.1.10:9100']
      labels:
        env: prod
        alias: server1


windows_exporter是windows主机监控
https://github.com/prometheus-community/windows_exporter　最初是wmi_exporter

https://grafana.com/grafana/dashboards/12422 最常用
Starting at v0.13.0 the wmi_exporter was renamed to windows_exporter and all the measurements are now prefixed with windows_ instead of wmi_.

https://grafana.com/grafana/dashboards/6593
New-Service -name Windows_exporter -displayName Windows_Exporter -binaryPathName "`"C:\\prometheus\\windows_exporter.exe`" --collectors.enabled="cpu,cs,logical_disk,memory,net,os,service,system,textfile,tcp,process" --collector.textfile.directory=`"C:\\prometheus\\textfile_inputs`""


```

# 仪表板的使用的指导

prometheus 通过这个可以查看到当前数据支持的 metrics 和 label
http://localhost:9090/api/v1/label/__name__/values?
比如选择一个 windows_system_system_up_time，在 WEB 也可以查到
windows_system_system_up_time{instance="192.168.3.150:9182",job="windows_exporter"}

在 grafana 中的 dashboard 的通用模板为了规归类管理，会引入变量来在处理比如多个主机的情况
比如定义一个 server 的查询变量
　 label_values(windows_system_system_up_time, instance)
　【label_values 的含义参考　https://grafana.com/docs/grafana/latest/features/datasources/prometheus/】

dashboard 展现的某个 panel 上可以增加如下的 metric
　 sum by (mode) (rate(windows_cpu_time_total{instance=~"\$server"}[5m]))
　【Panel 中查询要检索的条件参考 PromQL (Prometheus Query Language) 　https://grafana.com/docs/grafana/latest/panels/queries/　https://prometheus.io/docs/prometheus/latest/querying/basics/　】
