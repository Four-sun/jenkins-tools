-- 任务调试记录表
CREATE TABLE `rdos_stream_debug_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `unique_key` varchar(255) NOT NULL COMMENT '调试唯一key',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `create_user_id` int(11) NOT NULL COMMENT '调试人id',
  `job_id` varchar(255) NOT NULL COMMENT 'engine 任务id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务调试记录表';

-- 记录任务调试中用到的表
CREATE TABLE `rdos_stream_debug_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `debug_record_id` int(11) NOT NULL COMMENT '调试记录id',
  `table_name` varchar(255) binary NOT NULL COMMENT '表名',
  `table_type` tinyint(4) NOT NULL COMMENT '表类型',
  `version` int(11) NOT NULL COMMENT '表版本',
  `is_finished` tinyint(4) NOT NULL COMMENT '源表数据是否采集完成',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录任务调试中用到的表';

-- 任务调试结果数据表
CREATE TABLE `rdos_stream_debug_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `debug_table_id` int(11) NOT NULL COMMENT '任务调试表id',
  `row_data` longtext NOT NULL COMMENT '结果数据',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务调试结果数据';

-- 资源清理定时任务
INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('stream', '0 0 0 */1 * ?', 'StreamResourceCleanUpJob', 'StreamResourceCleanUpJob', 'StreamResourceCleanUpJobTrigger', 'StreamResourceCleanUpJobTriggerGroup', 'com.dtstack.streamapp.quartz.job.StreamResourceCleanUpJob', '0', null, null, now(), now(), '0');
