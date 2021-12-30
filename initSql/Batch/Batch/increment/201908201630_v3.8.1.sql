alter table rdos_batch_alarm_record
CHANGE COLUMN `trigger_type` `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发方式 0:BEFORE 1:AFTER 2:INSTEAD_OF';

alter table rdos_batch_catalogue
CHANGE COLUMN `level` `level` tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级 n:n+1级',
CHANGE COLUMN `engine_type` `engine_type` INT   DEFAULT 0   NOT NULL COMMENT '1: hadoop 2:libra 3:kylin';

alter table rdos_batch_data_source
CHANGE COLUMN `type` `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型 1:mysql, 2:oracle, 3:sqlserver, 4:postgresql, 5:rdbms, 6:hdfs, 7:hive, 8:hbase, 9:ftp, 10:maxcompute, 11:es, 12:redis, 13:mongodb, 14:kafka_11, 15:ads, 16:beats, 17:kafka_10, 18:kafka_09, 19:db2, 20:carbondata, 21:libra, 22:gbase_8a, 23:kylin';

alter table rdos_batch_function
CHANGE COLUMN `engine_type` `engine_type` int DEFAULT 0 NOT NULL COMMENT '1: hadoop 2:libra 3:kylin';

alter table rdos_batch_resource
CHANGE COLUMN `resource_type` `resource_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '资源类型 0:other, 1:jar, 2:py, 3:zip, 4:egg';

alter table rdos_batch_task
CHANGE COLUMN `task_type` `task_type` tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL ',
CHANGE COLUMN `engine_type` `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive';

alter table rdos_batch_script
CHANGE COLUMN `type` `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:sql,1:python,2:shell';

alter table rdos_hive_catalogue
CHANGE COLUMN `level` `level` tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级 n:n+1级';

alter table rdos_batch_task_shade
CHANGE COLUMN `task_type` `task_type` tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL',
CHANGE COLUMN `engine_type` `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive';

alter table rdos_hive_table_info
CHANGE COLUMN `is_ignore` `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略';

alter table rdos_hive_table_info_deleted
CHANGE COLUMN `is_ignore` `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略 1:忽略';

alter table rdos_batch_model_table
CHANGE COLUMN `depend` `depend` tinyint(1) COMMENT '是否层级依赖 0:不依赖, 1:依赖';

alter table rdos_batch_hive_table_column
CHANGE COLUMN `is_ignore` `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略';

alter table rdos_batch_apply
CHANGE COLUMN `is_cancel` `is_cancel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否取消 0-否 1-是',
CHANGE COLUMN `is_revoke` `is_revoke` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否撤销 0-否 1-是';

alter table rdos_batch_task_process_record
CHANGE COLUMN `status` `status` tinyint(1) NULL COMMENT 'job状态 0:unsubmit, 1:created, 2:scheduled, 3:deploying, 4:running, 5:finished, 6:canceling, 7:canceled, 8:failed, 9:submitfaild, 10:submitting, 11:restarting, 12:manualsuccess, 13:killed, 14:submitte, 16:waitengine, 17:waitcompute, 18:frozen, 19:engineaccepted, 20:enginedistribute, 21:parentfailed, 22:failing';

alter table rdos_batch_task__shade_4backup
CHANGE COLUMN `task_type` `task_type` tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL ',
CHANGE COLUMN `engine_type` `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive';

alter table rdos_batch_package_item
CHANGE COLUMN `item_inner_type` `item_inner_type` tinyint(1) NULL COMMENT '-1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL';

alter table rdos_user_column_permission
CHANGE COLUMN `full_column` `full_column` tinyint(1) NOT NULL COMMENT '全部字段 0-否, 1-是';

alter table rdos_datamask_parse_record
CHANGE COLUMN `status` `status` tinyint(1) NULL COMMENT 'job状态 0:unsubmit, 1:created, 2:scheduled, 3:deploying, 4:running, 5:finished, 6:canceling, 7:canceled, 8:failed, 9:submitfaild, 10:submitting, 11:restarting, 12:manualsuccess, 13:killed, 14:submitte, 16:waitengine, 17:waitcompute, 18:frozen, 19:engineaccepted, 20:enginedistribute, 21:parentfailed, 22:failing';

alter table rdos_project_engine
CHANGE COLUMN `engine_type` `engine_type` tinyint(1) NOT NULL COMMENT '多引擎的类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive';

alter table rdos_notify
CHANGE COLUMN `trigger_type` `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发类型 0:failed, 1:finished, 2:unfinished 3:canceled, 4:timing-uncompleted 5:timing-exec-over';

alter table rdos_notify_record
CHANGE COLUMN `status` `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态 0:unread, 1:read, 2:unaccess';


