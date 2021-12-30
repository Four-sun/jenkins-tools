CREATE TABLE `rdos_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_name` varchar(256) NOT NULL COMMENT '项目名称',
  `project_alias` varchar(256) NOT NULL COMMENT '项目别名',
  `project_Identifier` varchar(256) NOT NULL COMMENT '项目标识',
  `project_desc` varchar(4000) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `create_user_id` int(11) NOT NULL COMMENT '新建项目的用户id',
  `modify_user_id` int(11) COMMENT '修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型:0-普通项目，1-测试项目，2-生产项目',
  `produce_project_id` int(11) NULL COMMENT '绑定的生产项目id',
  `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '调度状态：0-开启，1-关闭',
  `is_allow_download` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否允许下载查询结果 1-正常 0-禁用',
  `catalogue_id` int(11) NOT NULL DEFAULT '0' COMMENT '目录id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT ='项目表';


CREATE TABLE `rdos_project_engine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `engine_type` tinyint(1) NOT NULL COMMENT '多引擎的类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  `engine_identity` varchar(256) NOT NULL COMMENT '标识信息，比如hive的dbname',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `create_user_id` int(11) COMMENT '创建人id',
  `modify_user_id` int(11) COMMENT '修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='项目与engine的关联关系表';

CREATE TABLE `rdos_tenant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dtuic_tenant_id` int(11) NOT NULL COMMENT '租户id',
  `tenant_name` varchar(256) NOT NULL COMMENT '用户名称',
  `tenant_desc` varchar(256) DEFAULT NULL COMMENT '租户描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `create_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tenant_id` (`dtuic_tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT ='租户表';

CREATE TABLE `rdos_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dtuic_user_id` int(11) NOT NULL COMMENT 'dtuic userid',
  `user_name` varchar(256) NOT NULL COMMENT '用户名称',
  `email` varchar(256) NOT NULL COMMENT '用户手机号',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `default_project_id` int(11) DEFAULT NULL COMMENT '默认项目id',
  `phone_number` varchar(256) DEFAULT NULL COMMENT '用户手机号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_dtuic_user_id` (`dtuic_user_id`),
  KEY `index_user_name` (`user_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT ='用户表';

CREATE TABLE `rdos_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '区分字典类型，1：数据源字典 ...',
  `dict_name` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '字典名',
  `dict_value` int(11) NOT NULL DEFAULT '0' COMMENT '字典值',
  `dict_name_zh` varchar(256) NOT NULL DEFAULT '' COMMENT '字典中文名',
  `dict_name_en` varchar(256) NOT NULL DEFAULT '' COMMENT '字典英文名',
  `dict_sort` int(11) NOT NULL DEFAULT '0' COMMENT '字典顺序',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_type_dict_name` (`type`,`dict_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='字典表';



CREATE TABLE `rdos_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(256) NOT NULL DEFAULT '' COMMENT '权限CODE',
  `name` varchar(256) DEFAULT NULL COMMENT '权限名',
  `display` varchar(256) DEFAULT NULL COMMENT '展示名称',
  `parent_id` int(11) DEFAULT NULL COMMENT '父权限id',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:功能权限;2:数据权限',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='权限表';

CREATE TABLE `rdos_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `role_name` varchar(256) NOT NULL COMMENT '角色名称',
  `role_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
  `role_value` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), PROJECTOWNER(2), PROJECTADMIN(3), MEMBER(4), OPERATION(5), DATADEVELOP(6)',
  `role_desc` varchar(256) NOT NULL DEFAULT '' COMMENT '角色描述',
  `modify_user_id` int(11) COMMENT '修改的用户',
  `create_user_id` int(11) COMMENT '创建的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';


CREATE TABLE `rdos_role_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `role_id` int(11) unsigned NOT NULL COMMENT '关联角色id',
  `permission_id` int(11) unsigned NOT NULL COMMENT '关联权限id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `modify_user_id` int(11) COMMENT '修改的用户',
  `create_user_id` int(11) COMMENT '创建的用户',
  `tenant_id` int(11) COMMENT '角色所属租户id,0:基础角色',
  `project_id` int(11) COMMENT '项目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

CREATE TABLE `rdos_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '-1' COMMENT '项目id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `modify_user_id` int(11) COMMENT '修改的用户',
  `create_user_id` int(11) COMMENT '创建的用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_user_role` (`project_id`,`user_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

CREATE TABLE `rdos_read_write_lock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lock_name` varchar(256) NOT NULL COMMENT '锁名称',
  `tenant_id` int(11) COMMENT '租户Id',
  `project_id` int(11) NOT NULL COMMENT '项目Id',
  `relation_id` int(11) NOT NULL COMMENT 'Id',
  `type` varchar(256) NOT NULL COMMENT '任务类型 ',
  `create_user_id` int(11) COMMENT '创建人Id',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁,0是特殊含义',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_read_write_lock` (`lock_name`(128)),
  UNIQUE KEY `index_lock` (`project_id`,`relation_id`,`type`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ='读写锁记录表';

CREATE TABLE `rdos_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `biz_type` tinyint(1) NOT NULL COMMENT '业务类型，1：实时，2：离线',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `name` varchar(256) DEFAULT '' COMMENT '通知名称',
  `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发类型 0:failed, 1:finished, 2:unfinished 3:canceled, 4:timing-uncompleted 5:timing-exec-over',
  `webhook` varchar(256) NOT NULL DEFAULT '' COMMENT '钉钉告警-自定义机器人的webhook',
  `uncomplete_time` VARCHAR (20) DEFAULT NULL COMMENT 'batch 任务 未完成超时的时间设置,HH:mm',
  `send_way` varchar(128)  DEFAULT '' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
  `start_time` varchar(256) DEFAULT '' COMMENT '允许通知的开始时间，如5：00，早上5点',
  `end_time` varchar(256) DEFAULT '' COMMENT '允许通知的结束时间，如22：00，不接受告警',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：正常，1：停止，2 停止访问',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `alarm_type` TINYINT(1) DEFAULT 2 COMMENT '通知类型 1：项目  2：任务',
PRIMARY KEY (`id`),
KEY `idx_biz_type_relation_id` (`biz_type`,`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知表';

CREATE TABLE `rdos_notify_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `notify_id` int(11) NOT NULL DEFAULT '0' COMMENT '通知id',
  `content_id` int(11) NOT NULL DEFAULT '0' COMMENT '内容文本id',
  `cyc_time` VARCHAR(32) COMMENT '批处理调度的时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态 0:unread, 1:read, 2:unaccess',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息记录';

CREATE TABLE `rdos_notify_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `notify_id` int(11) NOT NULL COMMENT '通知id',
  `user_id` int(11) NOT NULL COMMENT '接收人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `idx_notify_id_user_id` (`notify_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知与接收人关系表';

CREATE TABLE `rdos_notify_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `biz_type` tinyint(1) NOT NULL COMMENT '业务类型，1：实时，2：离线',
  `notify_id` int(11) NOT NULL COMMENT '通知id',
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `idx_biz_type_notify_id_alarm_id` (`biz_type`,`notify_id`,`alarm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知记录表';

CREATE TABLE `rdos_project_stick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `create_user_id` int(11) NOT NULL COMMENT '创建人id',
  `modify_user_id` int(11) COMMENT '修改人id',
  `stick` datetime COMMENT '置顶字段',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `idx_project_user` (`project_id`,`create_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目的置顶记录表';

COMMIT;