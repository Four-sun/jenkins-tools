-- 任务提交重试配置表
CREATE TABLE `rdos_stream_task_retry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `fail_retry` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0不重试 1重试',
  `max_retry_num` int(11) DEFAULT NULL COMMENT '最大重试次数',
  `submit_expired` int(11) DEFAULT NULL COMMENT '超时时间',
  `retry_interval` int(11) DEFAULT NULL COMMENT '重试间隔',
  `submit_expired_unit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '超时时间单位 0秒 1 分',
  `retry_interval_unit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '重试间隔单位 0秒 1 分',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_id` (`project_id`,`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='任务提交重试配置表';