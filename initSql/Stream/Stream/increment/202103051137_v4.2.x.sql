-- 任务操作日志
CREATE TABLE `rdos_stream_task_operation_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL COMMENT '当前app下的用户租户id',
  `operator` varchar(100) NOT NULL COMMENT '操作人',
  `operator_id` int(11) NOT NULL COMMENT '操作人id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `action` varchar(200) NOT NULL COMMENT '执行的动作',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation` tinyint(1) NOT NULL COMMENT '当前操作 1:提交/重跑 2:停止 3:续跑',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  PRIMARY KEY (`id`),
  KEY `idx_task_log` (`task_id`,`operation`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='任务操作日志';