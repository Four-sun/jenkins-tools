CREATE TABLE `rdos_batch_alarm_receive_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `user_id` int(11) NOT NULL COMMENT '告警接收人',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_batch_alarm_receive_user` (`alarm_id`,`user_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='告警接收人配置表';

CREATE TABLE `rdos_batch_alarm_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `cyc_time` VARCHAR(32) COMMENT '批处理调度的时间',
  `alarm_content` varchar(512) NOT NULL COMMENT '告警内容',
  `receive_user` VARCHAR(512) COMMENT '告警接收人',
  `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发方式 0:BEFORE 1:AFTER 2:INSTEAD_OF',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='告警发送记录表';

CREATE TABLE `rdos_batch_catalogue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_name` varchar(128) NOT NULL COMMENT '文件夹名称',
  `node_pid` int(11) NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
  `order_val` int(3) DEFAULT NULL,
  `level` tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级 n:n+1级',
  `engine_type` INT   DEFAULT 0   NOT NULL COMMENT '1: hadoop 2:libra 3:kylin',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  catalogue_type TINYINT(1) DEFAULT '0' COMMENT '目录类型 0任务目录 1 项目目录',
  PRIMARY KEY (`id`),
  KEY `index_catologue_name` (`project_id`,`node_pid`,`node_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 COMMENT ='文件夹、目录表';

CREATE TABLE `rdos_batch_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_name` varchar(128) NOT NULL COMMENT '数据源名称',
  `data_desc` varchar(1024) NOT NULL COMMENT '数据源描述',
  `data_json` TEXT NOT NULL COMMENT '链接数据源信息需要加密 json格式',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型 1:mysql, 2:oracle, 3:sqlserver, 4:postgresql, 5:rdbms, 6:hdfs, 7:hive, 8:hbase, 9:ftp, 10:maxcompute, 11:es, 12:redis, 13:mongodb, 14:kafka_11, 15:ads, 16:beats, 17:kafka_10, 18:kafka_09, 19:db2, 20:carbondata, 21:libra, 22:gbase_8a, 23:kylin',
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
  `link_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_default` TINYINT DEFAULT 0 NULL,
  PRIMARY KEY (`id`),
  KEY `index_rdos_batch_data_source` (`tenant_id`,`project_id`,`data_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT ='数据源配置表';

CREATE TABLE `rdos_batch_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL COMMENT '函数名称',
  `class_name` VARCHAR(512) DEFAULT NULL COMMENT 'main函数类名',
  `purpose` varchar(1024) DEFAULT NULL COMMENT '函数用途',
  `command_formate` varchar(1024) DEFAULT NULL COMMENT '函数命令格式',
  `param_desc` varchar(1024) DEFAULT NULL COMMENT '函数参数说明',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0自定义 1系统',
  `engine_type` int DEFAULT 0 NOT NULL COMMENT '1: hadoop 2:libra 3:kylin',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `sql_text` text DEFAULT NULL COMMENT 'sql文本',
  PRIMARY KEY (`id`),
  KEY `index_rdos_batch_function` (`project_id`,`name`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='函数管理表';

CREATE TABLE `rdos_batch_function_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `function_id` int(11) NOT NULL COMMENT '函数id',
  `resource_id` int(11) NOT NULL COMMENT '对应batch资源的id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` bigint(20) DEFAULT NULL,
  `tenant_id` bigint(20) DEFAULT NULL,
  `resourceId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_rdos_function_resource` (`function_id`,`resource_id`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='函数关联的资源表';


CREATE TABLE `rdos_batch_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `url` varchar(1028) NOT NULL COMMENT '资源路径',
  `resource_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '资源类型 0:other, 1:jar, 2:py, 3:zip, 4:egg',
  `resource_name` varchar(256) NOT NULL COMMENT '资源名称',
  `origin_file_name` varchar(256) NOT NULL COMMENT '源文件名',
  `resource_desc` varchar(256) NOT NULL COMMENT '源文描述',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '新建资源的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改人',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `node_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_resource_name` (`project_id`,`resource_name`(128)),
  KEY `index_resource_type` (`resource_type`,`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT ='资源表';


CREATE TABLE `rdos_batch_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL ',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  `compute_type` tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式',
  `period_type` tinyint(2) COMMENT '周期类型',
  `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  `submit_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未提交,1已提交',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改task的用户',
  `create_user_id` int(11) NOT NULL COMMENT '新建task的用户',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人id',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `task_desc` varchar(256) NOT NULL,
  `main_class` varchar(256) NOT NULL,
  `exe_args` text DEFAULT NULL,
  `flow_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT '工作流id',
  `component_version` varchar(25) DEFAULT NULL COMMENT '组件版本',
  PRIMARY KEY (`id`),
  KEY `index_name` (`project_id`,`name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT ='任务表';

CREATE TABLE `rdos_batch_task_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `task_id` int(11) NOT NULL COMMENT '父文件夹id',
  `origin_sql` LONGTEXT COMMENT '原始sql',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `publish_desc` text NOT NULL COMMENT '任务参数',
  `create_user_id` int(11) NOT NULL COMMENT '新建的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式',
  `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  `dependency_task_ids` text NOT NULL COMMENT '依赖的任务id，多个以,号隔开',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='任务具体版本信息表';

CREATE TABLE `rdos_batch_task_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `resource_id` int(11) DEFAULT NULL COMMENT '对应batch资源的id',
  `resource_type` int(11) COMMENT '使用资源的类型 1:主体资源, 2:引用资源',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_resource_id` (`project_id`,`task_id`,`resource_id`,`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务和资源关联表';

CREATE TABLE `rdos_batch_script` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(512) NOT NULL COMMENT '脚本名称',
  `script_desc` varchar(1024) DEFAULT NULL COMMENT '脚本描述',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `script_text` LONGTEXT NOT NULL COMMENT '脚本内容',
  `task_params` text COMMENT '脚本环境参数',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:sql,1:python,2:shell',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'script版本',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_batch_script_projectId_name` (`project_id`,`name`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='数据开发-脚本表';


CREATE TABLE `rdos_batch_task_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `parent_task_id` int(11) DEFAULT NULL COMMENT '对应batch任务父节点的id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `parent_apptype` int(2) NOT NULL DEFAULT '1' COMMENT '对应任务父节点的产品类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_batch_task_task` (`project_id`,`parent_task_id`,`task_id`,`parent_apptype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务上下游关联关系表';

CREATE TABLE `rdos_batch_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '告警名称',
  `task_id` int(11) DEFAULT NULL COMMENT 'batch 任务id',
  `my_trigger` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 失败 1完成 2 未完成',
  `uncomplete_time` VARCHAR (20) DEFAULT NULL COMMENT 'batch 任务 未完成超时的时间设置,HH:mm',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `status` tinyint(1) NOT NULL default 0 comment '0 正常 1关闭 2删除',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `sender_type` int(4) NOT NULL DEFAULT '0' COMMENT '发送的客户端类型 0x001: 邮件 0x010: 短信',
   `is_task_holder` tinyint(1) DEFAULT NULL COMMENT '1有任务负责人 0无任务负责人',
   `alarm_type` TINYINT(1) DEFAULT 2 COMMENT '告警类型 1：项目  2：任务',
   `receive_types` varchar(10) DEFAULT NULL COMMENT '接收人类别（项目管理员：1，其他：2）',
   `send_time` varchar(10) DEFAULT NULL COMMENT '项目运行报告发送时间',
  PRIMARY KEY (`id`),
  KEY `index_batch_alarm_name` (`project_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='告警规则配置表';

-- 此张表如果需要处理，同时需要处理他的备份 rdos_batch_job_alarm_back 表，添加相同字段
CREATE TABLE `rdos_batch_job_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` varchar(256) NULL COMMENT 'engine job_id',
  `task_id` int(11) NOT NULL COMMENT 'batch task id',
  `task_status` int(2) NOT NULL COMMENT '当前任务状态',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务的告警实例表';


CREATE TABLE `rdos_batch_sys_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` VARCHAR(64) NOT NULL COMMENT '参数名称',
  `param_command` VARCHAR(64) NOT NULL COMMENT '参数替换指令',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务开发-系统参数表';


CREATE TABLE `rdos_batch_task_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `type` int(2) NOT NULL COMMENT '0:系统参数, 1:自定义参数',
  `param_name` VARCHAR(64) NOT NULL COMMENT '参数名称',
  `param_command` VARCHAR(64) NOT NULL COMMENT '参数替换指令',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_batch_task_parameter` (`task_id`, `param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务开发-任务参数配置表';

CREATE TABLE `rdos_hive_table_action_record`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `action_sql` LONGTEXT NOT NULL COMMENT '操作sql语句',
  `operate` VARCHAR(100) NOT NULL COMMENT '操作类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_table_id`(`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='hive表操作记录表';

-- 数据类目
CREATE TABLE `rdos_hive_catalogue`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `node_name` varchar(128) NOT NULL COMMENT '文件夹名称',
  `node_pid` int(11) NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
  `order_val` int(3) DEFAULT NULL,
  `path` varchar(512) NOT NULL COMMENT '目录路径',
  `level` tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级 n:n+1级',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT 'hive分类目录表';


CREATE TABLE `rdos_table_project_data_history`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `table_num` int(11) NOT NULL COMMENT '表数量',
  `project_size` varchar(20) NOT NULL COMMENT '项目存储大小',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  unique key idx(`project_id`,`gmt_create`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT ='项目存储空间表';


CREATE TABLE `rdos_batch_sql_text_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskId` int(11) NOT NULL COMMENT '任务 id',
  `writeable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：可写 1：不可写',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改tsql text的用户',
  `create_user_id` int(11) NOT NULL COMMENT '新建sql text的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'sql text 版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT ='生成建表语句的模板表';


CREATE TABLE `rdos_batch_data_source_task_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_source_id` int(11) NOT NULL COMMENT '任务id',
  `task_id` int(11) DEFAULT NULL COMMENT '对应资源的id,只有MR才需要添加资源id',
  `project_id` int(11) COMMENT '项目id',
  `tenant_id` int(11) COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_data_source_task_id` (`data_source_id`,`task_id`),
  KEY `index_task_id` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT ='数据源和任务的关联表';

CREATE TABLE `rdos_batch_task_resource_shade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `resource_id` int(11) DEFAULT NULL COMMENT '对应batch资源的id',
  `resource_type` int(11) COMMENT '使用资源的类型 1:主体资源, 2:引用资源',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_resource_shade_id` (`project_id`,`task_id`,`resource_id`,`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务资源关联信息- 提交表';

CREATE TABLE `rdos_batch_task_param_shade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `type` int(2) NOT NULL COMMENT '0:系统参数, 1:自定义参数',
  `param_name` VARCHAR(64) NOT NULL COMMENT '参数名称',
  `param_command` VARCHAR(64) NOT NULL COMMENT '参数替换指令',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_batch_task_parameter` (`task_id`, `param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务参数配置- 提交表';


CREATE TABLE `rdos_hive_table_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `table_type` tinyint(2) NOT NULL COMMENT '表类型',
  `table_desc` varchar(2048) DEFAULT NULL COMMENT '表描述',
  `life_day` int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
  `life_status` int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
  `table_size` bigint(30) DEFAULT NULL COMMENT '表大小',
  `grade` varchar(128) DEFAULT NULL COMMENT '模型层级',
  `subject` varchar(128) DEFAULT NULL COMMENT '主题域',
  `refresh_rate` varchar(128) DEFAULT NULL COMMENT '刷新频率',
  `incre_type` varchar(128) DEFAULT NULL COMMENT '增量类型',
  `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略',
  `check_result` varchar(256) DEFAULT NULL COMMENT '检测结果',
  `size_update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '表大小更新时间',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `charge_user_id` int(11) NOT NULL COMMENT '负责人',
  `modify_user_id` int(11) NOT NULL COMMENT '修改人',
  `path` varchar(512) NOT NULL DEFAULT '""' COMMENT '目录路径',
  `location` varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
  `delim` varchar(50) DEFAULT NULL COMMENT '列分隔符',
  `store_type` varchar(100) NOT NULL DEFAULT 'orc' COMMENT '存储格式',
  `catalogue_id` int(11) NOT NULL DEFAULT '0' COMMENT '目录id',
  `last_ddl_time` datetime DEFAULT NULL COMMENT '最后表结构修改时间',
  `last_dml_time` datetime DEFAULT NULL COMMENT '最后数据更改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_dirty_data_table` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-普通表 1-脏数据表',
  `table_file_count` int(11) DEFAULT NULL COMMENT '表文件数量',
  `is_partition` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否分区表 默认非分区',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx` (`tenant_id`,`project_id`,`table_name`(128),`table_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='同步的hive表';


CREATE TABLE `rdos_hive_table_info_deleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `table_type` TINYINT(2) COMMENT '表类型',
  `table_desc` varchar(2048) NULL COMMENT '表描述',
  `life_day` int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
  `life_status` int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
  `table_size` bigint(30) DEFAULT NULL COMMENT '表大小',
  `table_file_count` int(11) DEFAULT NULL COMMENT '表文件数量',
  `grade` varchar(128) COMMENT '模型层级',
  `subject` varchar(128) COMMENT '主题域',
  `refresh_rate` varchar(128) COMMENT '刷新频率',
  `incre_type` varchar(128) COMMENT '增量类型',
  `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略 1:忽略',
  `check_result` varchar(256) COMMENT '检测结果',
  `size_update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '表大小更新时间',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '修改人',
  `charge_user_id` int(11) NOT NULL COMMENT '负责人',
  `path` varchar(512) NOT NULL DEFAULT '""' COMMENT '目录路径',
  `location` varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
  `delim` varchar(50) NULL COMMENT '列分隔符',
  `store_type` varchar(100) not null default 'orc' comment '存储格式',
  `catalogue_id` int(11) NOT NULL DEFAULT '0' COMMENT '目录id',
  `last_ddl_time` datetime NULL COMMENT '最后表结构修改时间',
  `last_dml_time` datetime NULL COMMENT '最后数据更改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_dirty_data_table` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-普通表 1-脏数据表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='已经删除的hive表';


CREATE TABLE `rdos_batch_dirty_data_count`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `task_name` varchar(256) NOT NULL COMMENT '任务名称',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `dirty_data_num` int(11) NOT NULL DEFAULT 0 COMMENT '脏数据总数',
  `run_time` datetime NOT NULL COMMENT '运行时间',
  `error_num1` int(11) NOT NULL DEFAULT 0 COMMENT '错误类型1数量',
  `error_num2` int(11) NOT NULL DEFAULT 0 COMMENT '错误类型2数量',
  `error_num3` int(11) NOT NULL DEFAULT 0 COMMENT '错误类型3数量',
  `error_num4` int(11) NOT NULL DEFAULT 0 COMMENT '错误类型4数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_task_name` (`task_name`(128),`run_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='脏数据类型错误统计';

-- 血缘表
CREATE TABLE `rdos_batch_table_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `task_id`   int(11) DEFAULT 0 NOT NULL COMMENT '所属任务',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `data_source_id` int(11) NOT NULL COMMENT '表id',
  `col` varchar(256) NULL COMMENT '字段名称',
  `input_project_id` int(11) NOT NULL COMMENT '项目id',
  `input_table_name` varchar(256) NOT NULL COMMENT '表名称',
  `input_data_source_id` int(11) NOT NULL COMMENT '表id',
  `input_col` varchar(256) NULL COMMENT '字段名称',
  `unique_key` varchar(64) NULL COMMENT '血缘唯一键',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_idx` (`unique_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='血缘关系--表的依赖关系表';

CREATE TABLE `rdos_batch_table_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `data_source_id` int(11) NOT NULL COMMENT '数据源id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `relation_id` int(11) NOT NULL COMMENT '相关id',
  `relation_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是任务，0-否，1-是',
  `detail_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `relation_result_type` int(11) NOT NULL DEFAULT '0' COMMENT '对应表在sql中类型 0:依赖表 1:主表',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_idx` (`data_source_id`,`table_id`,`relation_id`,`relation_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='血缘关系表';

CREATE TABLE `rdos_batch_model_table` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`type` tinyint(1) NOT NULL COMMENT '1 层级 2 主题域 3 刷新频率 4 增量定义',
`level` tinyint(1) COMMENT '层级编号',
`name` varchar(128) NOT NULL COMMENT '名称定义',
`model_desc` varchar(256) COMMENT '说明',
`prefix` varchar(128) NULL COMMENT '前缀标识',
`life_day` int(11) COMMENT '生命周期  单位：天',
`depend` tinyint(1) COMMENT '是否层级依赖 0:不依赖, 1:依赖',
`create_user_id` int(11) NOT NULL COMMENT '新建用户',
`modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `index_type_prefix` (`type`,`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表名模型表';

CREATE TABLE `rdos_batch_model_column` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`type` tinyint(1) NOT NULL COMMENT '类型 原子/衍生',
`column_type` tinyint(2) COMMENT '指标类型 原子/修饰词',
`column_name` varchar(128) NOT NULL COMMENT '指标命名',
`column_name_zh` varchar(128) NOT NULL COMMENT '指标名称',
`data_type` varchar(128) NOT NULL COMMENT '数据类型',
`model_desc` varchar(256) COMMENT '指标口径',
`create_user_id` int(11) NOT NULL COMMENT '新建用户',
`modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `index_name_type` (`type`,`column_name`,`data_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段名模型表';

CREATE TABLE `rdos_batch_hive_table_column` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`table_id` int(11) NOT NULL COMMENT '表id',
`column_name` varchar(128) NOT NULL COMMENT '字段名称',
`column_type` varchar(128) NOT NULL  COMMENT '字段类型',
`column_desc` varchar(256) COMMENT '字段描述',
`column_index` int(11) NULL COMMENT '排序',
`check_result` varchar(256) COMMENT '检测结果',
`is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `idx` (`table_id`,`column_type`,`column_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表名模型检测表';

CREATE TABLE `rdos_batch_model_monitor_record` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`bad_table` int(11) NOT NULL DEFAULT '0' COMMENT '不规范模型总数',
`bad_column` int(11) NOT NULL DEFAULT '0' COMMENT '不规范字段总数',
`grade` int(11) NOT NULL DEFAULT '0' COMMENT '层级不规范数',
`subject` int(11) NOT NULL DEFAULT '0' COMMENT '主题域不规范数',
`refresh_rate` int(11) NOT NULL DEFAULT '0' COMMENT '刷新不规范数',
`incre_type` int(11) NOT NULL DEFAULT '0' COMMENT '增量方式不规范数',
`col_name` int(11) NOT NULL DEFAULT '0' COMMENT '字段名不规范数',
`data_type` int(11) NOT NULL DEFAULT '0' COMMENT '字段数据类型不规范数',
`col_desc` int(11) NOT NULL DEFAULT '0' COMMENT '字段描述不规范数',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `project_id_gmt_create` (`project_id`,`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测记录表';

CREATE TABLE `rdos_batch_model_rule` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`rule` varchar(128) NOT NULL COMMENT '建表规则配置',
`create_user_id` int(11) NOT NULL COMMENT '新建用户',
`modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表名规则表';


CREATE TABLE `rdos_batch_hive_select_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` varchar(256) NOT NULL COMMENT '工作任务id',
  `temp_table_name` varchar(256) NOT NULL COMMENT '临时表名',
  `is_select_sql` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-否 1-是',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `user_id` int(11) NULL COMMENT '执行用户',
  `sql_text` LONGTEXT NULL COMMENT 'sql',
  `parsed_columns` LONGTEXT NULL COMMENT '字段信息',
  `engine_type` int null COMMENT '引擎类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `other_type` int null COMMENT '其他类型：0 默认，1 Impala',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`job_id`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sql查询临时表';


-- 资源申请表
CREATE TABLE `rdos_batch_apply`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '资源所属项目',
  `user_id` int(11) NOT NULL COMMENT '申请用户',
  `apply_resource_type` tinyint(1) NOT NULL COMMENT '资源类型',
  `resource_id` int(11) NOT NULL COMMENT '申请的资源id',
  `resource_name` varchar(255) NOT NULL COMMENT '资源名称',
  `deal_user_id` int(11) NULL COMMENT '处理用户',
  `day` int(11) NOT NULL COMMENT '申请期限',
  `apply_reason` varchar(1024) NOT NULL COMMENT '申请理由',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态:0-待审批，1-通过，2-不通过',
  `reply` varchar(1024) NULL COMMENT '回复内容',
  `is_cancel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否取消 0-否 1-是',
  `is_revoke` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否撤销 0-否 1-是',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='资源申请表';


-- 用户收藏表
CREATE TABLE `rdos_batch_hive_table_collection`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '申请用户',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id_user_id_table_id` (`project_id`,`user_id`,`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='hive表收藏信息表';


-- 表分区
CREATE TABLE `rdos_batch_hive_table_partition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `partition` varchar(1024) NOT NULL COMMENT 'hdfs路径',
  `store_size` bigint(30) NOT NULL COMMENT '分区大小',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `partition_name` varchar(255) DEFAULT NULL COMMENT '分区名称',
  `file_count` int(11) DEFAULT '0' COMMENT '文件数量',
  `last_ddl_time` datetime NOT NULL COMMENT '文件最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='hive表分区信息';



-- 表权限
CREATE TABLE `rdos_batch_hive_table_permission`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `permission_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-只读，1-读写，2-修改',
  `apply_id` int(11) NOT NULL COMMENT '申请id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='申请的hive表权限信息';


-- 整库迁移 配置
CREATE TABLE `rdos_batch_data_source_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `data_source_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据源id',
  `schedule_conf` varchar(512) DEFAULT '' COMMENT '调度配置 json格式',
  `sync_type` TINYINT(1) NOT NULL COMMENT '同步类型：1=增量 2=全量',
  `time_field_identifier` varchar(32) DEFAULT '' COMMENT '日期标识字段，全量为空',
  `parallel_type` TINYINT(1) NOT NULL COMMENT '并发配置：1=分批上传 2=整批上传',
  `parallel_conf` varchar(32) DEFAULT '' COMMENT '分批上传需配置',
  `transform_field_config` text DEFAULT NULL COMMENT '字段转换规则, json array',
  `create_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='数据同步-整库同步的配置信息表';



-- 整库迁移 任务
CREATE TABLE `rdos_batch_data_source_migration_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `migration_id` int(11) NOT NULL DEFAULT '0' COMMENT '迁移id',
  `task_id` int(11) NOT NULL DEFAULT '0' COMMENT 'taskId',
  `job_id` int(11) NOT NULL DEFAULT '0' COMMENT 'jobId',
  `table_name` varchar(256) NOT NULL DEFAULT '' COMMENT '表名',
  `ide_table_name` varchar(256) NOT NULL DEFAULT '' COMMENT 'ide中hive表名',
  `status` int(11) NOT NULL COMMENT '任务创建状态',
  `report` text DEFAULT NULL COMMENT '日志报告',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='数据同步-整库同步的任务表';

-- 调度端记录离线job处理的id
create table `rdos_batch_task_process_record`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `job_id` varchar(256) NOT NULL COMMENT '工作任务id',
    `status` tinyint(1) NULL COMMENT 'job状态 0:unsubmit, 1:created, 2:scheduled, 3:deploying, 4:running, 5:finished, 6:canceling, 7:canceled, 8:failed, 9:submitfaild, 10:submitting, 11:restarting, 12:manualsuccess, 13:killed, 14:submitte, 16:waitengine, 17:waitcompute, 18:frozen, 19:engineaccepted, 20:enginedistribute, 21:parentfailed, 22:failing',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx` (`job_id`(128))
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务处理记录表';

-- 默认离线任务模版
CREATE TABLE `rdos_batch_task_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_type` tinyint(2) NOT NULL COMMENT '任务类型',
  `type` tinyint(2) NOT NULL COMMENT '1-ods  2-dwd  3-dws  4-ads  5-dim',
  `content` text NOT NULL COMMENT '任务内容',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='任务模板字典表';

CREATE TABLE `rdos_batch_task_shade_4backup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL ',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  `compute_type` tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `task_desc` varchar(256) NOT NULL,
  `exe_args` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


-- add rdos_batch_test_produce_resource
CREATE TABLE `rdos_batch_test_produce_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `test_resource_id` varchar(128) NOT NULL COMMENT '数据源id',
  `produce_resource_id` varchar(128) NOT NULL COMMENT '关联数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `resource_type` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '资源类型 默认0：资源  1：函数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`test_resource_id`,`produce_resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='测试环境和生产环境 资源 关联关系表';


-- add rdos_batch_test_produce_task
CREATE TABLE `rdos_batch_test_produce_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `test_task_id` varchar(128) NOT NULL COMMENT '数据源id',
  `produce_task_id` varchar(128) NOT NULL COMMENT '关联数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`test_task_id`,`produce_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='测试环境和生产环境 任务 关联关系表';


-- add rdos_batch_test_produce_data_source
CREATE TABLE `rdos_batch_test_produce_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_data_source_id` varchar(128) NOT NULL COMMENT '数据源id',
  `produce_data_source_id` varchar(128) NOT NULL COMMENT '关联数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`test_data_source_id`,`produce_data_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='测试环境和生产环境 数据源 关联关系表';


-- add rdos_batch_package
CREATE TABLE `rdos_batch_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(200) NOT NULL COMMENT '包名称',
  `comment` varchar(500) NOT NULL COMMENT '描述',
  `create_user_id` int(11) NOT NULL COMMENT '申请人',
  `publish_user_id` int(11) DEFAULT NULL COMMENT '发布人',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发布状态：0-待发布，1-成功，2-失败',
  `log` text COMMENT '失败日志',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `package_type` int(11) NOT NULL COMMENT ' 一键发布0 导入导出1',
  `path` varchar(500) DEFAULT NULL COMMENT '如果式导入 则为导入的压缩包的path',
  `path_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '用于后期判断zip的导入时间是否过期',
  PRIMARY KEY (`id`),
  KEY `idx` (`tenant_id`,`project_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='任务发布包表';


-- add rdos_batch_package_item
CREATE TABLE `rdos_batch_package_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `package_id` int(11) NOT NULL COMMENT '发布包id',
  `item_id` int(11) NOT NULL COMMENT '发布包下的资源id',
  `item_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '资源类型：0-任务，1-表，2-资源，3-函数',
  `item_inner_type` tinyint(1) DEFAULT NULL COMMENT '资源具体类型',
  `publish_param` text COMMENT '发布参数,json格式',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `status` int(11) NOT NULL COMMENT '表示条目发布是否成功',
  `log` text COMMENT '条目发布时的日志记录',
  `type` int(11) NOT NULL COMMENT '条目属于 0一键发布  1导入导出',
  `item_name` varchar(255) DEFAULT NULL COMMENT '条目名称 作为冗余字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='发布包明细表';


CREATE TABLE `rdos_user_operator_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `operator_id` int(11) NOT NULL COMMENT '操作类型',
  `type` tinyint(1) NOT NULL COMMENT 'ddl/dml',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `apply_id` int(11) NOT NULL COMMENT '申请id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `create_user_id` int(11) COMMENT '创建人id',
  `modify_user_id` int(11) COMMENT '修改人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='表权限申请记录表';


CREATE TABLE `rdos_user_column_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id`  int(11) NOT NULL COMMENT '用户id',
  `column_name` varchar(50) NOT NULL COMMENT '字段名称',
  `full_column` tinyint(1) NOT NULL COMMENT '全部字段 0-否, 1-是',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `apply_id`  int(11) NOT NULL COMMENT '申请id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `create_user_id` int(11) COMMENT '创建人id',
  `modify_user_id` int(11) COMMENT '修改人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='表字段权限申请记录表';

-- 脱敏相关
CREATE TABLE `rdos_datamask_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `table_id` int(11) NOT NULL COMMENT '关联表id',
  `column_name` varchar(128) NOT NULL COMMENT '列名称',
  `rule_id` int(11) NOT NULL COMMENT '关联规则id',
  `example` varchar(255) COMMENT '样例',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
  `enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='脱敏配置表';

CREATE TABLE `rdos_datamask_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `example` varchar(255) COMMENT '样例',
  `mask_type` int(11) NOT NULL COMMENT '脱敏效果 0-全部脱敏 1-部分脱敏',
  `replace_str` varchar(32) NOT NULL COMMENT '替换字符',
  `begin_pos` int(11) NOT NULL DEFAULT '0' COMMENT '起始位置',
  `end_pos` int(11) NOT NULL DEFAULT '0' COMMENT '结束位置',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='脱敏规则配置表';

create table `rdos_datamask_parse_record`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `job_id` varchar(63) NOT NULL COMMENT '工作任务id',
    `status` tinyint(1) NULL COMMENT 'job状态 0:unsubmit, 1:created, 2:scheduled, 3:deploying, 4:running, 5:finished, 6:canceling, 7:canceled, 8:failed, 9:submitfaild, 10:submitting, 11:restarting, 12:manualsuccess, 13:killed, 14:submitte, 16:waitengine, 17:waitcompute, 18:frozen, 19:engineaccepted, 20:enginedistribute, 21:parentfailed, 22:failing',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_job_id` (`job_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='脱敏解析记录表';


create table `rdos_datamask_columns_info`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `tenant_id` int(11) NOT NULL COMMENT '租户id',
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `config_id` int(11) NOT NULL COMMENT '关联脱敏配置id',
    `table_id` int(11) NOT NULL COMMENT '关联表id',
    `column_name` varchar(128) NOT NULL COMMENT '列名称',
    `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
    `enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `is_origin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否原始配置脱敏字段 1:原始脱敏字段',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_config_table_column` (`config_id`,`table_id`,`column_name`,`is_deleted`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='脱敏字段配置信息表';

create table `rdos_batch_task_record` (
    `id` int(11) NOT NULL auto_increment,
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `tenant_id` int(11) NOT NULL COMMENT '租户id',
    `record_type` int(2) NOT NULL COMMENT '记录类型',
    `task_id` int(11) NOT NULL COMMENT '任务id',
    `operator_id` int(11) NOT NULL COMMENT '操作者id',
    `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='任务变更记录表';

create table `rdos_carbon_task_relation`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `task_id` int(11) NOT NULL COMMENT '工作任务id',
    `source_id` int(11) NULL COMMENT '数据源id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_task_id` (`task_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='Carbon Sql 任务与数据源对应关系表';

create table `rdos_batch_table_sync_log` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`tenant_id` int(11) NOT NULL COMMENT '租户id',
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `source_id` int(11) NOT NULL COMMENT '数据源id',
    `original_table_name` VARCHAR(256) NOT NULL COMMENT '原始表名',
    `modify_table_name` VARCHAR(256) DEFAULT NULL COMMENT '修改后表名',
    `task_status` tinyint(1) DEFAULT NULL COMMENT '任务状态',
    `task_report` TEXT DEFAULT NULL COMMENT '任务失败描述',
    `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='整库同步任务日志表';

-- 告警配置告警通道关联表
CREATE TABLE `rdos_batch_alarm_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) DEFAULT NULL COMMENT '预警id',
  `alarm_type_id` int(11) DEFAULT NULL COMMENT '预警方式id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `alarm_id_index` (`alarm_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='告警配置告警通道关联表';

-- 控制台配置告警通道信息表
CREATE TABLE `rdos_batch_alarm_type_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_gate_source` varchar(256) DEFAULT NULL COMMENT '告警通道唯一标识',
  `alert_gate_name` varchar(256) DEFAULT NULL COMMENT '告警通道名称',
  `alert_gate_type` tinyint(1) DEFAULT NULL COMMENT '通道类别： 1短信 2邮件 3钉钉 4自定义',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `gate_source_index` (`alert_gate_source`(8))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='控制台配置告警通道信息表';



CREATE TABLE `rdos_file_merge_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `status` int(11) DEFAULT NULL COMMENT '规则状态',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '修改者id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 0：未删除 1：已删除',
  `rule_name` varchar(255) DEFAULT NULL COMMENT '规则名称',
  `merge_type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '治理方式:1 周期治理 2一次性治理',
  `schedule_conf` varchar(512) DEFAULT NULL COMMENT '调度配置 ：json字符串和任务的调度配置类似;',
  `file_count` int(11) NOT NULL DEFAULT '0' COMMENT '需要治理的文件数量',
  `storage` double NOT NULL DEFAULT '0' COMMENT '容量大小',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小文件合并规则表';

CREATE TABLE `rdos_file_merge_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `table_id` int(11) DEFAULT NULL COMMENT '合并hive表id',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `rule_id` int(11) DEFAULT NULL COMMENT '小文件合并规则id',
  `location` varchar(1024) DEFAULT NULL COMMENT '存储位置',
  `status` tinyint(1) DEFAULT NULL COMMENT '合并状态',
  `error_msg` longtext COMMENT '错误信息',
  `start_time` datetime DEFAULT NULL COMMENT '合并开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '合并结束时间',
  `is_partition` tinyint(1) DEFAULT NULL COMMENT '是否是分区表',
  `count_before` int(11) DEFAULT NULL COMMENT '合并前文件数量',
  `count_after` int(11) DEFAULT NULL COMMENT '合并后文件数量',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建用户',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '修改人id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 0:未删除， 1：已删除',
  `plan_time` datetime NOT NULL COMMENT '计划时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小文件合并记录表';

CREATE TABLE `rdos_file_merge_partition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `record_id` int(11) DEFAULT NULL COMMENT '合并记录id',
  `status` tinyint(1) DEFAULT NULL COMMENT '合并状态',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `error_msg` longtext COMMENT '错误信息',
  `partition_name` varchar(255) DEFAULT NULL COMMENT '分区名',
  `copy_location` varchar(1024) DEFAULT NULL COMMENT '备份路径',
  `storage_before` varchar(255) DEFAULT NULL COMMENT '合并前占用存储',
  `storage_after` varchar(255) DEFAULT NULL COMMENT '合并后占用存储',
  `file_count_before` int(11) DEFAULT NULL COMMENT '合并前文件数量',
  `file_count_after` int(11) DEFAULT NULL COMMENT '合并后文件数量',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 0：未删除，1 ：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小文件合并分区信息表';

-- 表操作记录备份表
CREATE TABLE `rdos_hive_table_action_record_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `action_sql` longtext NOT NULL COMMENT '操作sql语句',
  `operate` varchar(100) NOT NULL COMMENT '操作类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_table_id` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表操作记录备份';