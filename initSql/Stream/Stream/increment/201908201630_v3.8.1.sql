alter table rdos_dict
CHANGE COLUMN `type` `type` int(11) NOT NULL DEFAULT '0' COMMENT '区分字典类型，1:数据源类型, 2:hive表字段类型, 3:脚本类型, 4:离线root目录类型, 5:实时root目录类型, 6:离线一级目录类型, 7:实时一级目录类型, 8:权限树隐藏的权限点, 9:数据模型原子指标和衍生指标的支持的数据类型, 10:集群部署时支持的任务类型, 11:单机部署支持的任务类型';

alter table rdos_stream_alarm
CHANGE COLUMN `task_status` `task_status` tinyint(1) DEFAULT NULL COMMENT '0:unsubmit, 1:created, 2:scheduled, 3:deploying, 4:running, 5:finished, 6:canceling, 7:canceled, 8:failed, 9:submitfaild, 10:submitting, 11:restarting, 12:manualsuccess, 13:killed, 14:submitte, 16:waitengine, 17:waitcompute, 18:frozen, 19:engineaccepted, 20:enginedistribute, 21:parentfailed, 22:failing';

alter table rdos_stream_alarm_record
CHANGE COLUMN `trigger_type` `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发方式 0:BEFORE, 1:AFTER, 2:INSTEAD_OF';

alter table rdos_stream_catalogue
CHANGE COLUMN `level` `level` tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级 n:n+1级';

alter table rdos_stream_task
CHANGE COLUMN `engine_type` `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:librasql, 11:hive';

alter table rdos_stream_task_shade
CHANGE COLUMN `engine_type` `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:librasql, 11:hive';