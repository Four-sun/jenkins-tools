CREATE TABLE `rdos_file_merge_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `table_id` int(11) DEFAULT NULL COMMENT 'hive_info表id',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `status` int(11) DEFAULT NULL COMMENT '规则状态',
  `is_partition` tinyint(1) DEFAULT NULL COMMENT '是否是分区表',
  `location` varchar(1024) DEFAULT NULL COMMENT '存储位置',
  `merge_date` varchar(255) DEFAULT NULL COMMENT '合并时间 - 天',
  `merge_time` varchar(255) DEFAULT NULL COMMENT '合并时间 - 时分',
  `partition_info` varchar(255) DEFAULT NULL COMMENT '分区信息',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '修改者id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 0：未删除 1：已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`table_id`,`table_name`,`is_deleted`)
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
  `error_msg` varchar(255) DEFAULT NULL COMMENT '错误信息',
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小文件合并记录表';

CREATE TABLE `rdos_file_merge_partition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `record_id` int(11) DEFAULT NULL COMMENT '合并记录id',
  `status` tinyint(1) DEFAULT NULL COMMENT '合并状态',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `error_msg` varchar(255) DEFAULT NULL COMMENT '错误信息',
  `partition_name` varchar(255) DEFAULT NULL COMMENT '分区名',
  `copy_location` varchar(1024) DEFAULT NULL COMMENT '备份路径',
  `storage_before` varchar(255) DEFAULT NULL COMMENT '合并前占用存储',
  `storage_after` varchar(255) DEFAULT NULL COMMENT '合并后占用存储',
  `file_count_before` int(11) DEFAULT NULL COMMENT '合并前文件数量',
  `file_count_after` int(11) DEFAULT NULL COMMENT '合并后文件数量',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 0：未删除，1 ：已删除',
  `bak_status` tinyint(1) DEFAULT '0' COMMENT '备份文件状态：未删除：已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小文件合并分区信息表';

INSERT INTO
`dt_center_cron_schedule` (`job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES
('batchFileManagerJob', 'batchFileManagerJobGroup', 'batchFileManagerTrigger', 'batchFileManagerTriggerGroup', 'com.dtstack.batch.job.BatchFileManagerJob', '0 0/1 * * * ?', '0', null, null, 'rdos', now(), now(), '0');

ALTER TABLE `rdos_hive_table_info` ADD `table_file_count` INT NULL COMMENT '表文件数量';

UPDATE `dt_center_cron_schedule` SET `cron` = '0 0 7 * * ?' WHERE `job_detail_name` = 'batchTableSizeJob';