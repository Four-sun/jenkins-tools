CREATE TABLE IF NOT EXISTS `rods_project_job_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目 ID',
  `job_value` int(11) NOT NULL COMMENT '任务类型值',
  `tenant_id` int(11) NOT NULL COMMENT '租户 ID',
  `create_user_id` int(11) NOT NULL COMMENT '新建人 ID',
  `modify_user_id` int(11) NOT NULL COMMENT '修改人 ID',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;