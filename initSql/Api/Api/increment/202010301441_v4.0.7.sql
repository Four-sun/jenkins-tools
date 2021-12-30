
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (102,'api_manager_sub', 'API管理父节点', 'API管理', 1, 1);
update da_permission set parent_id = 102 where id = 52;
update da_permission set parent_id = 102 where id = 46;
update da_permission set parent_id = 102 where id = 64;

-- 告警管理
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (98,'api_alarm', 'API管理_API告警', 'API告警', 102, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (99,'api_alarm_query', 'API管理_API告警_查看', '查看', 98, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (100,'api_alarm_edit', 'API管理_API告警_编辑', '编辑', 98, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (101,'api_alarm_menu', 'API管理_API告警_菜单', '菜单', 98, 1);

-- 添加API告警 role_user关系
INSERT INTO da_role_permission (role_id, permission_id) select id,98 from da_role where role_value != 3;
INSERT INTO da_role_permission (role_id, permission_id) select id,99 from da_role where role_value != 3;
INSERT INTO da_role_permission (role_id, permission_id) select id,100 from da_role where role_value != 3;
INSERT INTO da_role_permission (role_id, permission_id) select id,101 from da_role where role_value != 3;
INSERT INTO da_role_permission (role_id, permission_id) select id,102 from da_role;

-- 给应用开发添加消息中心的权限
INSERT INTO da_role_permission (role_id, permission_id) select id,2 from da_role where role_value = 4;
INSERT INTO da_role_permission (role_id, permission_id) select id,4 from da_role where role_value = 4;
INSERT INTO da_role_permission (role_id, permission_id) select id,6 from da_role where role_value = 4;



CREATE TABLE `da_alarm_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `alarm_name` varchar(256) NOT NULL DEFAULT '' COMMENT '告警名称',
  `trigger_type` varchar(1) NOT NULL DEFAULT '1' COMMENT '触发方式, 1-调用失败,2-在指定时间段(timeSlot)内出现(failNum)次调用失败,3-单用户连续出现failNum次调用失败',
  `time_slot` int(11) DEFAULT NULL COMMENT '统计失败次数时间段',
  `time_unit` varchar(1) DEFAULT NULL COMMENT '统计失败次数时间段,时间单位',
  `fail_num` int(11)  NULL DEFAULT '0' COMMENT '失败次数',
  `total_num` int(11) NOT NULL DEFAULT '1' COMMENT '告警总次数',
  `interval` int(11) DEFAULT '0' COMMENT '告警间隔',
  `dormant_start_time` varchar(20) DEFAULT '' COMMENT '免打扰开始时间',
  `dormant_end_time` varchar(20) DEFAULT '' COMMENT '免打扰结束时间',
  `alarm_type` varchar(100) NOT NULL DEFAULT '' COMMENT '使用二进制方式存储告警方式，如 111 表示为 钉钉-短信-邮件',
  `open_state` varchar(1) NOT NULL DEFAULT '1' COMMENT '开启状态 1/0',
  `receiver` varchar(100) NOT NULL DEFAULT '1' COMMENT '告警接收人配置',
  `webhook` varchar(255) DEFAULT NULL COMMENT '钉钉告警',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='告警配置表';

CREATE TABLE `da_alarm_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `api_id` int(11) NOT NULL DEFAULT '0' COMMENT 'api id',
  `alarm_id` int(11) NOT NULL DEFAULT '0' COMMENT '告警id',
  `trigger_user_id` int(11) DEFAULT '0' COMMENT '触发者id',
  `alarm` varchar(1) NOT NULL DEFAULT '0' COMMENT '是否发送告警',
  `status` varchar(1) NOT NULL DEFAULT '0' COMMENT '是否发送成功 1/0，比如间隔时间或者免打扰时间会使得延迟发送',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `content` varchar(512) NOT NULL COMMENT '告警内容',
  `trigger_type` varchar(255) NOT NULL COMMENT '触发失败方式，如：n秒内失败M次',
  `send_type` varchar(255) NOT NULL COMMENT '告警方式',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='告警记录表';

CREATE TABLE `da_alarm_record_receiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `alarm_record_id` int(11) NOT NULL DEFAULT '0' COMMENT '告警记录id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='告警记录-用户表';

CREATE TABLE `da_api_alarm_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `alarm_id` int(11) NOT NULL DEFAULT '0' COMMENT '告警id',
  `api_id` int(11) NOT NULL DEFAULT '0' COMMENT 'api id',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_api_alarm` (`alarm_id`,`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='接口-告警表';

CREATE TABLE `da_alarm_user_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `alarm_id` int(11) NOT NULL DEFAULT '0' COMMENT '告警id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_alarm` (`alarm_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='用户接收告警表';




INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (8, 'alarmJob', 'alarmJob', 'alarmJobTrigger', 'alarmJobTriggerGroup', 'com.dtstack.da.schedule.job.AlarmJob', '*/30 * * * * ? ', 0, NULL, NULL, 'api', now(), now(), 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (9, 'sendAlarmJob', 'sendAlarmJob', 'sendAlarmJobTrigger', 'sendAlarmJobTriggerGroup', 'com.dtstack.da.schedule.job.SendAlarmJob', '*/30 * * * * ? ', 0, NULL, NULL, 'api', now(), now(), 0);



-- 访客
delete from da_role_permission where role_id in (SELECT id FROM da_role WHERE role_value = 3) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
    'message_edit',
    'api_myapi_edit',
    'api_datasource_edit',
    'system_member_edit',
    'system_role_edit',
		'api_manager',
		'api_manager_query',
		'api_manager_edit',
		'api_manager_menu',
		'api_catalogue_edit',
		'api_authorized',
		'api_authorized_query',
		'api_authorized_edit',
		'api_authorized_menu',
		'api_market_apply',
		'api_alarm',
		'api_alarm_menu',
		'api_alarm_query',
		'api_alarm_edit'
  )
);

-- 应用开发，概览（仅看到自己的API）、API市场、我的API
delete from da_role_permission where role_id in (SELECT id FROM da_role WHERE role_value = 4) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
    'system_member_edit',
		'system_role_edit',
		'overview_market_query',
		'overview_market_menu',
		'api_manager_query',
		'api_manager_edit',
		'api_manager_menu',
		'api_catalogue_edit',
		'api_authorized',
		'api_authorized_query',
		'api_authorized_edit',
		'api_authorized_menu',
		'api_datasource_edit'
      )
);


-- 数据开发
delete from da_role_permission where role_id in (SELECT id FROM da_role WHERE role_value = 5) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
		'api_authorized',
		'api_authorized_query',
		'api_authorized_edit',
		'api_authorized_menu'
      )
);



-- 访客
delete from da_role_permission where role_id in (SELECT id FROM da_role WHERE role_value = 3) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
		'api_manager',
		'api_manager_query',
		'api_manager_edit',
		'api_manager_menu'
  )
);
