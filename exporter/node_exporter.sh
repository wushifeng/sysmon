#!/bin/bash
:<<EOF
The perf collector may not work by default on all Linux systems due to kernel configuration and security settings. To allow access, set the following sysctl parameter:

sysctl -w kernel.perf_event_paranoid=X
2 allow only user-space measurements (default since Linux 4.6).
1 allow both kernel and user measurements (default before Linux 4.6).
0 allow access to CPU-specific data but not raw tracepoint samples.
-1 no restrictions.

Depending on the configured value different metrics will be available, for most cases 0 will provide the most complete set. 
EOF

# 是否有别的设置项？　文档还看不出，后续使用再确认
#　node_exporter-1.0.1.linux-amd64.tar.gz 中包含执行文件
./node_exporter
