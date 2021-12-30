-- dataScience项目索引关联表
CREATE TABLE `science_project_engine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `engine_type` tinyint(1) NOT NULL COMMENT '多引擎的类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  `engine_identity` varchar(256) NOT NULL COMMENT '标识信息，比如hive的dbname',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- dataScience数据源表
CREATE TABLE if NOT EXISTS science_data_source_aiworks (
  id int(11) NOT NULL AUTO_INCREMENT,
  data_name varchar(128) NOT NULL COMMENT '数据源名称',
  data_desc varchar(1024) NOT NULL COMMENT '数据源描述',
  data_json varchar(2048) NOT NULL COMMENT '链接数据源信息需要加密 json格式',
  type tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型 1:mysql, 2:oracle, 3:sqlserver, 4:postgresql, 5:rdbms, 6:hdfs, 7:hive, 8:hbase, 9:ftp, 10:maxcompute, 11:es, 12:redis, 13:mongodb, 14:kafka_11, 15:ads, 16:beats, 17:kafka_10, 18:kafka_09, 19:db2, 20:carbondata, 21:libra, 22:gbase_8a, 23:kylin',
  active tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
  link_state tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  create_user_id int(11) NOT NULL COMMENT '创建的用户',
  modify_user_id int(11) NOT NULL COMMENT '修改的用户',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  is_default tinyint(4) DEFAULT '0',
  PRIMARY KEY (id),
  KEY index_science_data_source_aiworks (tenant_id,project_id,data_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据表信息
CREATE TABLE if NOT EXISTS science_hive_table_info (
  id int(11) NOT NULL AUTO_INCREMENT,
  project_id int(11) NOT NULL COMMENT '项目id',
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  table_name varchar(256) NOT NULL COMMENT '表名称',
  table_type TINYINT(2) NOT NULL COMMENT '表类型',
  table_desc varchar(2048) NULL COMMENT '表描述',
  life_day int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
  life_status int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
  table_size bigint(30) DEFAULT NULL COMMENT '表大小',
  grade varchar(128) COMMENT '模型层级',
  subject varchar(128) COMMENT '主题域',
  refresh_rate varchar(128) COMMENT '刷新频率',
  incre_type varchar(128) COMMENT '增量类型',
  is_ignore tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略',
  check_result varchar(256) COMMENT '检测结果',
  size_update_time datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '表大小更新时间',
  user_id int(11) NOT NULL COMMENT '用户id',
  charge_user_id int(11) NOT NULL COMMENT '负责人',
  modify_user_id int(11) NOT NULL COMMENT '修改人',
  path varchar(512) NOT NULL DEFAULT '""' COMMENT '目录路径',
  location varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
  delim varchar(50) NULL COMMENT '列分隔符',
  store_type varchar(100) not null default 'orc' comment '存储格式',
  catalogue_id int(11) NOT NULL DEFAULT '0' COMMENT '目录id',
  last_ddl_time datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后表结构修改时间',
  last_dml_time datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后数据更改时间',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  is_dirty_data_table tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-普通表 1-脏数据表',
  PRIMARY KEY (id),
  UNIQUE KEY idx (tenant_id,project_id,table_name(128), table_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据表分区
CREATE TABLE `science_hive_table_partition`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `partition` varchar(1024) NOT NULL COMMENT 'hdfs路径',
  `store_size` bigint(30) NOT NULL COMMENT '分区大小',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_idx` (`table_id`,`partition`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE if NOT EXISTS science_task_shade (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  node_pid int(11) NOT NULL COMMENT '父文件夹id',
  name varchar(256) NOT NULL COMMENT '任务名称',
  task_type tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL',
  engine_type tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  compute_type tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  sql_text LONGTEXT NOT NULL COMMENT 'sql 文本',
  task_params text NOT NULL COMMENT '任务参数',
  schedule_conf varchar(512) NOT NULL COMMENT '调度配置 json格式',
  period_type tinyint(2) COMMENT '周期类型',
  schedule_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  submit_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未提交,1已提交',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  modify_user_id int(11) NOT NULL COMMENT '最后修改task的用户',
  create_user_id int(11) NOT NULL COMMENT '新建task的用户',
  owner_user_id int(11) NOT NULL COMMENT '负责人id',
  version int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  task_desc varchar(256) NOT NULL,
  main_class varchar(256) NOT NULL,
  exe_args text DEFAULT NULL,
  flow_id INT ( 11 ) NOT NULL DEFAULT '0' COMMENT '工作流id',
  is_publish_to_produce tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布到生产环境：0-否，1-是',
  is_expire  TINYINT(1)   NOT NULL DEFAULT '0' COMMENT '过期策略：0永不过期 1过期取消',
  PRIMARY KEY (id),
  KEY index_name (project_id,name(128))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE if NOT EXISTS `science_hive_table_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `column_name` varchar(128) NOT NULL COMMENT '字段名称',
  `column_type` varchar(128) NOT NULL COMMENT '字段类型',
  `column_desc` varchar(256) DEFAULT NULL COMMENT '字段描述',
  `column_index` int(11) DEFAULT NULL COMMENT '排序',
  `check_result` varchar(256) DEFAULT NULL COMMENT '检测结果',
  `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`table_id`,`column_type`,`column_index`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='表名模型检测表';

CREATE TABLE if NOT EXISTS `science_batch_model_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `rule` varchar(128) NOT NULL COMMENT '建表规则配置',
  `create_user_id` int(11) NOT NULL COMMENT '新建用户',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='表名规则表';

-- 数据脱敏
CREATE TABLE `science_datamask_config` (
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
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_datamask_rule` (
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
 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
 PRIMARY KEY (`id`),
 UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_task_param_shade` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`task_id` int(11) NOT NULL COMMENT 'batch 任务id',
`type` int(2) NOT NULL COMMENT '0:系统参数, 1:自定义参数',
`param_name` varchar(64) NOT NULL COMMENT '参数名称',
`param_command` varchar(64) NOT NULL COMMENT '参数替换指令',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `index_science_parameter` (`task_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_task_resource_shade` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`task_id` int(11) NOT NULL COMMENT 'batch 任务id',
`resource_id` int(11) DEFAULT NULL COMMENT '对应batch资源的id',
`resource_type` int(11) DEFAULT NULL COMMENT '使用资源的类型 1:主体资源, 2:引用资源',
`project_id` int(11) NOT NULL COMMENT '项目id',
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `index_project_task_resource_id` (`project_id`,`task_id`,`resource_id`,`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table `science_datamask_columns_info`(
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `tenant_id` int(11) NOT NULL COMMENT '租户id',
 `project_id` int(11) NOT NULL COMMENT '项目id',
 `config_id` int(11) NOT NULL COMMENT '关联脱敏配置id',
 `table_id` int(11) NOT NULL COMMENT '关联表id',
 `column_name` varchar(128) NOT NULL COMMENT '列名称',
 `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
 `enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
 PRIMARY KEY (`id`),
 UNIQUE KEY `unique_config_table_column` (`config_id`,`table_id`,`column_name`,`is_deleted`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `science_task_version`;
CREATE TABLE `science_task_version` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`project_id` int(11) NOT NULL COMMENT '项目id',
`task_id` int(11) NOT NULL COMMENT '父文件夹id',
`origin_sql` longtext COMMENT '原始sql',
`sql_text` longtext NOT NULL COMMENT 'sql 文本',
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
) ENGINE=InnoDB AUTO_INCREMENT=617 DEFAULT CHARSET=utf8;