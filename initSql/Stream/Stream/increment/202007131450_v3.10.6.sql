-- 策略表
CREATE TABLE `rdos_stream_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(200) NOT NULL COMMENT '策略名称',
  `comment` varchar(200) DEFAULT NULL COMMENT '描述',
  `create_user_id` int(11) NOT NULL COMMENT '创建人',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '修改人',
  `time_zone` varchar(200) NOT NULL COMMENT '策略时区',
  `interval_type` tinyint(1) NOT NULL COMMENT '生效区间：0-每天，1-周一到周五',
  `date_duration` varchar(200) NOT NULL COMMENT '日期跨度集合',
  `time_duration` varchar(200) NOT NULL COMMENT '具体时间跨度集合',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx` (`project_id`,`name`(128))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 策略和任务关联表
CREATE TABLE `rdos_stream_strategy_task_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `strategy_id` int(11) NOT NULL COMMENT '策略id',
  `task_id` int(11) DEFAULT NULL COMMENT '任务id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_strategy_task_id` (`project_id`,`task_id`,`strategy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;




