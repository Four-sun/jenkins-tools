--  增加告警相关表
CREATE TABLE `science_alarm` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) DEFAULT '0' COMMENT '创建人',
  `update_by` int(11) DEFAULT '0' COMMENT '修改人',
  `alarm_rule_id` int(11) NOT NULL COMMENT '规则id',
  `task_id` int(11) NOT NULL COMMENT '规则id',
  `nextCheckTime` datetime NOT NULL COMMENT '下一次检查时间',
  PRIMARY KEY (`id`),
  KEY `idx_alarm_rule_id` (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警表 主要记录下次扫描时间，规则和任务关联关系';


CREATE TABLE `science_alarm_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `alarm_rule_id` int(11) NOT NULL COMMENT '规则id',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `job_id` varchar(32) NOT NULL COMMENT '告警记录和job实例关联，特殊jobid 000000，特殊规则发送的告警',
  `task_name` varchar(255) DEFAULT NULL,
  `task_type` tinyint(4) DEFAULT NULL,
  `policy_type` tinyint(4) DEFAULT NULL,
  `send_time` datetime NOT NULL COMMENT '预期发送时间',
  `send_status` tinyint(3) NOT NULL COMMENT '发送状态 0未发送 1已发送',
  `send_type` varchar(64) NOT NULL,
  `receive_user` varchar(512) NOT NULL,
  `alarm_content` varchar(512) NOT NULL COMMENT '告警内容',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警记录表';


CREATE TABLE `science_alarm_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人',
  `alarm_name` varchar(64) NOT NULL COMMENT '告警规则名称',
  `policy_type` tinyint(4) DEFAULT NULL COMMENT '触发策略类型 0任务失败，1任务成功，2定时未完成，3超时未完成，4特殊规则',
  `policy_conf` varchar(255) NOT NULL,
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0开启，1关闭',
  `send_conf` varchar(255) NOT NULL COMMENT '发送策略配置',
  `scope` tinyint(4) DEFAULT '0' COMMENT '告警规则作用域 0 指定task，1当前项目全部task',
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则表';


CREATE TABLE `science_alarm_rule_receive_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_rule_id` int(11) NOT NULL COMMENT '告警规则id',
  `user_id` int(11) NOT NULL COMMENT '告警接收人',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_alarm_rule_id` (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则接收人表';


CREATE TABLE `science_alarm_rule_send` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `alarm_rule_id` int(11) NOT NULL COMMENT '告警规则id',
  `send_type` tinyint(4) NOT NULL COMMENT '1 邮件 2短信 3微信 4钉钉',
  PRIMARY KEY (`id`),
  KEY `idx_alarm_rule_id` (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则-告警发送方式表';