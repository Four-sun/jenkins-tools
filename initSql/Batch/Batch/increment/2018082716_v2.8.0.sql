-- 工作流相关
ALTER TABLE rdos_batch_task ADD COLUMN flow_id INT (11) NOT NULL DEFAULT '0' COMMENT '工作流id';
ALTER TABLE rdos_batch_task_shade ADD COLUMN flow_id INT (11) NOT NULL DEFAULT '0' COMMENT '工作流id';
ALTER TABLE rdos_batch_job ADD COLUMN flow_job_id VARCHAR (256) NOT NULL DEFAULT '0' COMMENT '工作流实例id';

-- 添加batchJob的索引
ALTER TABLE `rdos_batch_job`
ADD INDEX `idx_name_type` (`job_name`(128), `type`);

--  系统表备份数据存储

CREATE TABLE `rdos_batch_job_4backup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `job_id` varchar(256) NOT NULL COMMENT '工作任务id',
  `job_key` varchar(256) NOT NULL DEFAULT '',
  `job_name` VARCHAR(256) NOT NULL DEFAULT '',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `business_date` varchar(256) NOT NULL COMMENT '业务日期 yyyyMMddHHmmss',
  `cyc_time` varchar(256) NOT NULL COMMENT '调度时间 yyyyMMddHHmmss',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_batch_task_shade_4backup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 0 sql,1 mr 2 数据同步',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0 flink, 1 spark',
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