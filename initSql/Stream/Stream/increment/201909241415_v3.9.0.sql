update rdos_stream_task set
task_params='## per_job模式下jobManager配置的内存大小，默认1024（单位M）\r\n# jobmanager.memory.mb=1024\r\n
## per_job模式下taskManager配置的内存大小，默认1024（单位M）\r\n# taskmanager.memory.mb=1024\r\n
## per_job模式下启动的taskManager数量\r\n# container=1\r\n
## per_job模式下每个taskManager 对应 slot的数量\r\nslots=1\r\n
## 任务优先级, 范围:1-1000\r\njob.priority=10\r\n
## checkpoint保存时间间隔\r\nflink.checkpoint.interval=3600000' where task_type=11 and is_deleted=0;