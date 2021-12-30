CREATE TABLE `rdos_stream_alarm_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) DEFAULT NULL COMMENT '告警id',
  `alarm_type_id` int(11) DEFAULT NULL COMMENT '告警方式id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `alarm_id_index` (`alarm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_alarm_type_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_gate_source` varchar(256) DEFAULT NULL COMMENT '告警通道唯一标识',
  `alert_gate_name` varchar(256) DEFAULT NULL COMMENT '告警通道名称',
  `alert_gate_type` tinyint(1) DEFAULT NULL COMMENT '通道类别： 1邮件 2短信 3钉钉 4自定义',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `gate_source_index` (`alert_gate_source`(8))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_support_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '1.数据源 2.FlinkSql_源表 3.FlinkSql_结果表 4.FlinkSql_维表 5.实时采集_向导模式_源表 6.实时采集_向导模式_结果表 7.实时采集_脚本模式_源表 8.实时采集_脚本模式_结果表',
  `data_source_name` varchar(256) NOT NULL DEFAULT '' COMMENT '数据源名称',
  `data_source_value` int(11) NOT NULL DEFAULT '0' COMMENT '数据源值',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_type_data_source_name` (`type`,`data_source_name`),
  UNIQUE KEY `index_type_data_source_value` (`type`,`data_source_value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='数据源支持表';

CREATE TABLE `rdos_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_name` varchar(256) NOT NULL COMMENT '项目名称',
  `project_alias` varchar(256) NOT NULL COMMENT '项目别名',
  `project_Identifier` varchar(256) NOT NULL COMMENT '项目标识',
  `project_desc` varchar(4000) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `create_user_id` int(11) NOT NULL COMMENT '新建项目的用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '修改项目的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型:0-普通项目，1-测试项目，2-生产项目',
  `produce_project_id` int(11) NULL COMMENT '绑定的生产项目id',
  `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '调度状态：0-开启，1-关闭',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_name` (`project_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

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
  UNIQUE KEY `index_tenant_name` (`tenant_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '区分字典类型，1:数据源类型, 2:hive表字段类型, 3:脚本类型, 4:离线root目录类型, 5:实时root目录类型, 6:离线一级目录类型, 7:实时一级目录类型, 8:权限树隐藏的权限点, 9:数据模型原子指标和衍生指标的支持的数据类型, 10:集群部署时支持的任务类型, 11:单机部署支持的任务类型',
  `dict_name` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '字典名',
  `dict_value` int(11) NOT NULL DEFAULT '0' COMMENT '字典值',
  `dict_name_zh` varchar(256) NOT NULL DEFAULT '' COMMENT '字典中文名',
  `dict_name_en` varchar(256) NOT NULL DEFAULT '' COMMENT '字典英文名',
  `dict_sort` int(11) NOT NULL DEFAULT '0' COMMENT '字典顺序',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_type_dict_name` (`type`,`dict_name`(128)),
  UNIQUE KEY `index_type_dict_value` (`type`,`dict_value`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



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
  `create_user_id` int(11) COMMENT '新建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户',
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
  `create_user_id` int(11) COMMENT '新建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_user_role` (`project_id`,`user_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

CREATE TABLE `rdos_read_write_lock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lock_name` varchar(256) NOT NULL COMMENT '锁名称',
  `project_id` int(11) NOT NULL COMMENT '项目Id',
  `relation_id` int(11) NOT NULL COMMENT 'Id',
  `type` varchar(256) NOT NULL COMMENT '任务类型 ',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁,0是特殊含义',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_read_write_lock` (`lock_name`(128)),
  UNIQUE KEY `index_lock` (`project_id`,`relation_id`,`type`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `biz_type` tinyint(1) NOT NULL COMMENT '业务类型，1：实时，2：离线',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `name` varchar(256) DEFAULT '' COMMENT '通知名称',
  `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发类型',
  `webhook` varchar(256) NOT NULL DEFAULT '' COMMENT '钉钉告警-自定义机器人的webhook',
  `uncomplete_time` VARCHAR (20) DEFAULT NULL COMMENT 'batch 任务 未完成超时的时间设置,HH:mm',
  `send_way` varchar (128) NOT NULL DEFAULT '' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
  `start_time` varchar(256) DEFAULT '' COMMENT '允许通知的开始时间，如5：00，早上5点',
  `end_time` varchar(256) DEFAULT '' COMMENT '允许通知的结束时间，如22：00，不接受告警',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：正常，1：停止，2 停止访问',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
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
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态',
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
  `create_user_id` int(11) COMMENT '创建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
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
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `stick` datetime COMMENT '置顶字段',
  `create_user_id` int(11) COMMENT '创建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `idx_project_user` (`project_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目的置顶记录表';


CREATE TABLE `rdos_stream_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT '告警名称',
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `task_status` tinyint(1) DEFAULT NULL COMMENT '0:unsubmit, 1:created, 2:scheduled, 3:deploying, 4:running, 5:finished, 6:canceling, 7:canceled, 8:failed, 9:submitfaild, 10:submitting, 11:restarting, 12:manualsuccess, 13:killed, 14:submitte, 16:waitengine, 17:waitcompute, 18:frozen, 19:engineaccepted, 20:enginedistribute, 21:parentfailed, 22:failing',
  `threshold` int(11) DEFAULT NULL COMMENT '阈值',
  `alarm_data_source` varchar(200) DEFAULT NULL COMMENT '告警数据源',
  `trigger_index` tinyint(1) DEFAULT NULL COMMENT '触发指标',
  `compare_op` tinyint(1) DEFAULT NULL COMMENT '比较符',
  `alarm_control` text DEFAULT NULL COMMENT '告警抑制参数',
  `my_trigger` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 失败',
  `uncomplete_time` VARCHAR (20) DEFAULT NULL COMMENT 'batch 任务 未完成超时的时间设置,HH:mm',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 正常 1关闭 2删除',
  `sender_type` int(4) NOT NULL,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modified_user_id` int(11) NOT NULL COMMENT '修改人',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_stream_alarm_name` (`project_id`,`task_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_alarm_receive_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `user_id` int(11) NOT NULL COMMENT '告警接收人',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `create_user_id` int(11) COMMENT '创建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_stream_alarm_receive_user` (`alarm_id`,`user_id`,`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_alarm_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `alarm_content` varchar(512) NOT NULL COMMENT '告警内容',
  `receive_user` VARCHAR(512) COMMENT '告警接收人',
  `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发方式 0:BEFORE, 1:AFTER, 2:INSTEAD_OF',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_stream_alarm_record` (`alarm_id`,`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_catalogue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_name` varchar(128) NOT NULL COMMENT '文件夹名称',
  `node_pid` int(11) NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
  `order_val` int(3) DEFAULT '-1',
  `level` tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级 n:n+1级',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_catologue_name` (`project_id`,`node_pid`,`node_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `url` varchar(1028) NOT NULL COMMENT '资源路径',
  `resource_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '资源类型 1,jar 2 file',
  `resource_name` varchar(256) NOT NULL COMMENT '资源名称',
  `origin_file_name` varchar(256) NOT NULL COMMENT '源文件名',
  `resource_desc` varchar(256) NOT NULL COMMENT '源文描述',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '新建资源的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改资源的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_system` tinyint (1) NOT NULL DEFAULT 0 COMMENT '0用户 1系统',
  PRIMARY KEY (`id`),
  KEY `index_resource_name` (`project_id`,`resource_name`(128)),
  KEY `index_resource_type` (`resource_type`,`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 新增资源历史表
CREATE TABLE `rdos_stream_resource_history` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL COMMENT '资源id',
  `version` varchar(256) NOT NULL COMMENT '版本',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `url` varchar(1028) NOT NULL COMMENT '资源路径',
  `resource_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '资源类型 1,jar 2 file',
  `resource_name` varchar(256) NOT NULL COMMENT '资源名称',
  `origin_file_name` varchar(256) NOT NULL COMMENT '源文件名',
  `resource_desc` varchar(256) NOT NULL COMMENT '源文描述',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '新建资源的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改资源的用户',
  `is_current_version` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0不是当前版本 1当前版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `task_id` varchar(256) NOT NULL COMMENT '任务id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `main_class` varchar(256) COMMENT '任务名称',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 0 sql, 1 mr',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:librasql, 11:hive',
  `compute_type` tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改task的用户',
  `create_user_id` int(11) NOT NULL COMMENT '新建task的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `task_desc` varchar(255) DEFAULT NULL,
  `exe_args` text DEFAULT NULL,
  `source_params` LONGTEXT DEFAULT NULL COMMENT '输入源',
  `sink_params` LONGTEXT DEFAULT NULL COMMENT '输出源',
  `side_params` LONGTEXT DEFAULT NULL COMMENT '维表',
  `create_model` tinyint(1) COMMENT '任务模式 0 向导模式  1 脚本模式 2 算子化拖拽模式（仅flinkSql）',
  `component_version` varchar(255) DEFAULT NULL comment '组件版本',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_name` (`project_id`,`name`(128)),
  KEY `index_task_id` (`task_id`(128),`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `rdos_stream_task_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `resource_id` int(11) DEFAULT NULL COMMENT '对应资源的id,只有MR才需要添加资源id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_addition_resource` tinyint(1) NOT NULL DEFAULT 2 COMMENT '是否属于附加资源;1:附加资源,2:非附加资源',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_resource_id_addition` (`project_id`,`task_id`,`resource_id`,`is_addition_resource`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;


CREATE TABLE `rdos_stream_function` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`udf_type` tinyint(1) NOT NULL COMMENT '函数类型scala/table/aggregate',
`name` varchar(512) NOT NULL COMMENT '函数名称',
`class_name` varchar(512) NOT NULL COMMENT '函数类名',
`resource_id` int(11) NOT NULL COMMENT '关联的资源id',
`purpose` varchar(1024) DEFAULT NULL COMMENT '函数用途',
`command_format` varchar(1024) DEFAULT NULL COMMENT '函数命令格式',
`param_desc` varchar(1024) DEFAULT NULL COMMENT '函数参数说明',
`node_pid` int(11) NOT NULL COMMENT '父文件夹id',
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`project_id` int(11) NOT NULL COMMENT '项目id',
`create_user_id` int(11) NOT NULL COMMENT '创建的用户',
`modify_user_id` int(11) NOT NULL COMMENT '创建的用户',
`type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0自定义 1系统',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `index_rdos_stream_function` (`project_id`,`name`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_task_resource_shade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `resource_id` int(11) DEFAULT NULL COMMENT '对应资源的id,只有MR才需要添加资源id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_resource_id` (`project_id`,`task_id`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_task_shade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `task_id` varchar(256) NOT NULL COMMENT '任务id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `main_class` varchar(256) DEFAULT NULL COMMENT '任务名称',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 0 sql, 1 mr',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:librasql, 11:hive',
  `compute_type` tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改task的用户',
  `create_user_id` int(11) NOT NULL COMMENT '新建task的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `task_desc` varchar(255) DEFAULT NULL,
  `exe_args` text,
  `source_params` LONGTEXT DEFAULT NULL COMMENT '输入源',
  `sink_params` LONGTEXT DEFAULT NULL COMMENT '输出源',
  `side_params` LONGTEXT DEFAULT NULL COMMENT '维表',
  `create_model` tinyint(1) COMMENT '任务模式 0 向导模式  1 脚本模式',
  `component_version` varchar(255) DEFAULT NULL comment '组件版本',
  PRIMARY KEY (`id`),
  KEY `index_name` (`project_id`,`name`(128)),
  KEY `index_task_id` (`task_id`(128),`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_task_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `task_id` int(11) NOT NULL COMMENT '父文件夹id',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `publish_desc` text NOT NULL COMMENT '发布描述',
  `create_user_id` int(11) NOT NULL COMMENT '新建的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '最后修改task的用户',
  `task_desc` varchar(255) DEFAULT NULL,
  `source_params` LONGTEXT COMMENT '输入源',
  `sink_params` LONGTEXT COMMENT '输出源',
  `side_params` LONGTEXT COMMENT '维表',
  `create_model` tinyint(1) DEFAULT NULL COMMENT '任务模式 0 向导模式  1 脚本模式',
  `component_version` varchar(255) DEFAULT NULL comment '组件版本',
  `exe_args` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;


-- 创建实时数据源表
CREATE TABLE `rdos_stream_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_name` varchar(128) NOT NULL COMMENT '数据源名称',
  `data_desc` varchar(1024) NOT NULL COMMENT '数据源描述',
  `data_json` text NOT NULL COMMENT '链接数据源信息需要加密 json格式',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型',
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
  `link_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_rdos_batch_data_source` (`tenant_id`,`project_id`,`data_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 创建任务引用数据源表
CREATE TABLE `rdos_stream_data_source_task_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_source_id` int(11) NOT NULL COMMENT '数据源id',
  `task_id` int(11) DEFAULT NULL COMMENT '任务id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_data_source_task_id` (`data_source_id`,`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 创建实时任务表
CREATE TABLE `rdos_stream_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(256) NOT NULL COMMENT '任务id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提交状态',
  `log_info` text COMMENT '日志信息',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `user_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `create_user_id` int(11) COMMENT '创建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
  `submit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`(128))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 脏数据表
CREATE TABLE `rdos_dirty_hive_table_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `table_desc` varchar(2048) NULL COMMENT '表描述',
  `source_id` int(11) NOT NULL COMMENT '数据源id',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `life_day` int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
  `life_status` int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
  `table_size` bigint(30) DEFAULT NULL COMMENT '表大小',
  `size_update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '表大小更新时间',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `charge_user_id` int(11) NOT NULL COMMENT '负责人',
  `modify_user_id` int(11) NOT NULL COMMENT '修改人',
  `location` varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
  `delim` varchar(50) NULL COMMENT '列分隔符',
  `store_type` varchar(100) not null default 'orc' comment '存储格式',
  `last_ddl_time` datetime NULL COMMENT '最后表结构修改时间',
  `last_dml_time` datetime NULL COMMENT '最后数据更改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(200) NOT NULL COMMENT '包名称',
  `comment` varchar(500) DEFAULT NULL COMMENT '描述',
  `create_user_id` int(11) NOT NULL COMMENT '申请人-即为打包人',
  `publish_user_id` int(11) DEFAULT NULL COMMENT '发布人',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '包类型：0-本地创建，1-上传',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发布状态：0-待发布，1-成功，2-失败',
  `log` text COMMENT '失败日志',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_downloaded` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx` (`tenant_id`,`project_id`,`name`(128))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_package_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL COMMENT 'item名称',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `package_id` int(11) NOT NULL COMMENT '发布包id',
  `item_id` int(11) DEFAULT NULL COMMENT '发布包下的资源id',
  `item_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '资源类型：0-资源，1-函数, 2 任务',
  `item_inner_type` tinyint(1) DEFAULT NULL COMMENT '资源具体类型',
  `is_update_param` tinyint(1) DEFAULT NULL COMMENT '更新环境参数：0-不更新，1-更新',
  `is_update_strategy` tinyint(1) DEFAULT 0 NULL COMMENT '更新启停策略：0-不更新，1-更新',
  `log` text COMMENT '失败日志',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `create_user_id` int(11) DEFAULT NULL COMMENT '资源原始的创建人id',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '资源原始的修改人id',
  `create_user_name` varchar(22) DEFAULT NULL COMMENT '资源原始的创建人',
  `modify_user_name` varchar(22) DEFAULT NULL COMMENT '资源原始的创建人',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`package_id`,`item_id`,`item_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

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
  `create_user_id` int(11) COMMENT '创建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_id` (`project_id`,`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='任务提交重试配置表';

-- checkpoint失败告警记录表
CREATE TABLE `rdos_stream_alarm_checkpoint_failure_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `checkpoint_id` varchar(50) NOT NULL COMMENT 'checkpoint失败唯一标识',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_stream_alarm_checkpoint` (`project_id`,`alarm_id`,`checkpoint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'checkpoint失败告警记录表';

-- 任务操作日志
CREATE TABLE `rdos_stream_task_operation_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL COMMENT '当前app下的用户租户id',
  `operator` varchar(100) NOT NULL COMMENT '操作人',
  `operator_id` int(11) NOT NULL COMMENT '操作人id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `action` varchar(200) NOT NULL COMMENT '执行的动作',
  `create_user_id` int(11) COMMENT '创建的用户id',
  `modify_user_id` int(11) COMMENT '修改的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation` tinyint(1) NOT NULL COMMENT '当前操作 1:提交/重跑 2:停止 3:续跑',
  `task_id` int(11) NOT NULL COMMENT '任务id',
   PRIMARY KEY (`id`),
   KEY `idx_task_log` (`task_id`,`operation`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='任务操作日志';

-- 任务调试记录表
CREATE TABLE `rdos_stream_debug_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `unique_key` varchar(255) NOT NULL COMMENT '调试唯一key',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `create_user_id` int(11) NOT NULL COMMENT '调试人id',
  `job_id` varchar(255) NOT NULL COMMENT 'engine 任务id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务调试记录表';

-- 记录任务调试中用到的表
CREATE TABLE `rdos_stream_debug_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `debug_record_id` int(11) NOT NULL COMMENT '调试记录id',
  `table_name` varchar(255) binary NOT NULL COMMENT '表名',
  `table_type` tinyint(4) NOT NULL COMMENT '表类型',
  `version` int(11) NOT NULL COMMENT '表版本',
  `is_finished` tinyint(4) NOT NULL COMMENT '源表数据是否采集完成',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录任务调试中用到的表';

-- 任务调试结果数据表
CREATE TABLE `rdos_stream_debug_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `debug_table_id` int(11) NOT NULL COMMENT '任务调试表id',
  `row_data` longtext NOT NULL COMMENT '结果数据',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务调试结果数据';

-- 任务支持的metric指标
CREATE TABLE `rdos_stream_metric_support` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) NOT NULL COMMENT '指标中文名称',
  `task_type` tinyint(4) NOT NULL COMMENT '指标支持的任务类型',
  `value` varchar(255) NOT NULL COMMENT '指标key',
  `metric_tag` int(11) NOT NULL COMMENT 'metric匹配模式',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务支持的metric指标';

-- 数据源中心映射表
CREATE TABLE `rdos_data_source_center` (
  `id` INT (11) NOT NULL AUTO_INCREMENT COMMENT '关联的流计算数据源ID',
  `project_id` INT (11) DEFAULT NULL COMMENT '项目ID',
  `tenant_id` INT (11) DEFAULT NULL COMMENT '租户ID',
  `dt_center_source_id` INT (11) DEFAULT NULL COMMENT '数据源中心ID',
  `data_name` VARCHAR (255) DEFAULT NULL COMMENT '数据源中心名称',
  `type` INT (11) DEFAULT NULL COMMENT '数据源类型',
  `create_user_id` INT (11) DEFAULT NULL,
  `modify_user_id` INT (11) DEFAULT NULL,
  `gmt_create` DATETIME DEFAULT NULL,
  `gmt_modified` DATETIME DEFAULT NULL,
  `is_deleted` TINYINT (1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8 COMMENT = '数据源中心映射表';
