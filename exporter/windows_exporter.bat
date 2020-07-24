rem windows_exporter-0.13.0-386.msi 安装文件就是执行文件，做成了服务。　msi安装成功直接是服务，没有提示安装完毕
rem　使用这个命令行随需使用
windows_exporter.exe --log.format logger:eventlog?name=windows_exporter  --telemetry.addr :9182 --collector.textfile.directory=. --collectors.enabled="cpu,cs,logical_disk,memory,net,os,service,system,textfile,tcp,process"