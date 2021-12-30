-- 函数和任务关联表
CREATE TABLE `rdos_stream_function_task_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `function_id` int(11) NOT NULL COMMENT '函数id',
  `task_id` int(11) DEFAULT NULL COMMENT '任务id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_task_function_ref_function_id` (`function_id`),
  KEY `idx_task_function_ref_task_id` (`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;