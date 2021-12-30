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
