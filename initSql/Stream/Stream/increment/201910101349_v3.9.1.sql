
CREATE TABLE `rdos_dirty_hive_table_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `table_desc` varchar(2048) NULL COMMENT '表描述',
  `source_id` int(11) NOT NULL COMMENT '数据源id',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `life_day` int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
  `life_status` int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
  `table_size` bigint(30) DEFAULT NULL COMMENT '表大小',
  `size_update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '表大小更新时间',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `charge_user_id` int(11) NOT NULL COMMENT '负责人',
  `modify_user_id` int(11) NOT NULL COMMENT '修改人',
  `location` varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
  `delim` varchar(50) NULL COMMENT '列分隔符',
  `store_type` varchar(100) not null default 'orc' comment '存储格式',
  `last_ddl_time` datetime NULL COMMENT '最后表结构修改时间',
  `last_dml_time` datetime NULL COMMENT '最后数据更改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`tenant_id`,`project_id`,`table_name`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





