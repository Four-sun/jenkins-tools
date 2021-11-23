/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `data_name` varchar(128) NOT NULL COMMENT '数据源名称',
  `data_desc` varchar(1024) NOT NULL COMMENT '数据源描述',
  `data_json` text NOT NULL COMMENT '链接数据源信息需要加密 json格式',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型 ',
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
  `link_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `writable_db_name` varchar(256) comment '独立库的库名或Schema名',
  `writable_data_json` text comment '独立库用户名、密码',
  `expire_day` int(11) not null default 90 comment '数据存储时间，不传默认90天',
  `write_type` tinyint(1) not null default 0 comment '0-写入源库；1-写入独立库，默认写入源库',
  PRIMARY KEY (`id`),
  KEY `idx_data_name` (`data_name`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

-- 新增数据源关联表 所有旧数据迁移到此后续不再使用 dq_data_source
CREATE TABLE `dq_data_source_center` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
 `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
 `data_name` varchar(128) DEFAULT NULL COMMENT '本地数据源名称',
 `data_desc` text DEFAULT NULL COMMENT '数据源描述',
 `dt_data_source_id` int(11) NOT NULL DEFAULT '0' COMMENT '统一数据源id',
 `dt_data_source_name` varchar(255) DEFAULT NULL COMMENT '统一数据源名称',
 `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据源类型 ',
 `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
 `link_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
 `dtuic_tenant_id` int(11) DEFAULT NULL COMMENT 'uic租户id',
 `write_db_source_id` int(11) DEFAULT NULL COMMENT '独立库绑定统一数据源id',
 `expire_day` int(11) DEFAULT '90' COMMENT '数据存储时间，不传默认90天',
 `write_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-写入源库；1-写入独立库，默认写入源库',
 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
 `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
 `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COMMENT='数据源中心关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_data_source_ref`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_data_source_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `biz_type` int(11) NOT NULL COMMENT '业务类型，1：规则，2：逐行校验',
  `relation_id` int(11) DEFAULT NULL COMMENT '关联id',
  `data_source_id` int(11) NOT NULL COMMENT '数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_bizType_relationId_dataSourceId` (`biz_type`,`relation_id`,`data_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1061 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_dict`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '区分字典类型，1：数据源字典,2-规则校验类型',
  `dict_name` varchar(256) NOT NULL DEFAULT '' COMMENT '字典名',
  `dict_value` int(11) NOT NULL DEFAULT '0' COMMENT '字典值',
  `dict_name_zh` varchar(256) NOT NULL DEFAULT '' COMMENT '字典中文名',
  `dict_name_en` varchar(256) NOT NULL DEFAULT '' COMMENT '字典英文名',
  `dict_sort` int(11) NOT NULL DEFAULT '0' COMMENT '字典顺序',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_type_dict_value` (`type`,`dict_value`),
  UNIQUE KEY `idx_type_dict_name` (`type`,`dict_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_function`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_en` varchar(256) NOT NULL DEFAULT 'default_func' COMMENT '函数英文名称',
  `name_zc` varchar(256) NOT NULL DEFAULT 'default_func' COMMENT '函数汉语名称',
  `level` tinyint(1) NOT NULL DEFAULT '0' COMMENT '函数级别,0-字段级别，1-表级别',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `have_dirty` tinyint(1) DEFAULT '0' COMMENT '0-没有脏数据表 1-有脏数据表',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_multiple_support` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0不支持多字段，1支持',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '规则分类 1-完整性校验,2-准确性校验,3-规范性校验,4-唯一性校验',
  `sort` tinyint(1) NOT NULL DEFAULT '0' COMMENT '排序字段，按函数分类排序',
  PRIMARY KEY (`id`),
  KEY `idx_dq_function` (`name_en`(128))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='统计函数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_function_template`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_function_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `function_id` int(11) NOT NULL DEFAULT '0' COMMENT '函数id',
  `data_source_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据源类型',
  `template` text NOT NULL COMMENT '模板',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `template_query`  text  NOT NULL COMMENT '查询数据条件模版',
  PRIMARY KEY (`id`),
  KEY `idx_dq_function_template` (`function_id`,`data_source_type`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COMMENT='函数模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_monitor`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_monitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式',
  `period_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '调度周期',
  `is_closed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-启用 1-关闭',
  `rule_ids` text COMMENT '规则id的json字符串',
  `rule_number` int(11) DEFAULT NULL COMMENT '触发规则数',
  `url` text COMMENT '触发url',
  `task_params` text NOT NULL COMMENT '任务参数',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `partitions` varchar(256) DEFAULT NULL COMMENT '分区',
  `monitor_type` tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验',
  `schema_name` varchar(256)  COMMENT '监控规则选定的schema',
  `task_type` tinyint(4) unsigned not null default 0 comment '引擎任务类型，10-工作流虚节点；0-SQL任务；27-空任务',
  `associated` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-无关联任务，1-有关联任务',
  PRIMARY KEY (`id`),
  KEY `idx_dq_monitor` (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=utf8 COMMENT='监控对象表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_monitor_data`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_monitor_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `monitor_id` int(11) NOT NULL DEFAULT '0' COMMENT '监控对象id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `monitor_rule_id` int(11) NOT NULL DEFAULT '0' COMMENT '监控规则id',
  `monitor_record_id` int(11) NOT NULL DEFAULT '0' COMMENT '监控记录id',
  `monitor_data` varchar(256) DEFAULT NULL COMMENT '监控数值',
  `count_value` double DEFAULT NULL COMMENT '统计值',
  `is_triger` tinyint(1) DEFAULT NULL COMMENT '0没有触发 1触发',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dq_monitor_data` (`monitor_id`,`monitor_rule_id`,`monitor_record_id`),
  KEY `index_recordId` (`monitor_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=208985 DEFAULT CHARSET=utf8 COMMENT='监控数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_monitor_record`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_monitor_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `monitor_id` int(11) NOT NULL DEFAULT '0' COMMENT '监控对象id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `data_source_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据源类型',
  `data_source_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据源id',
  `table_name` varchar(256) NOT NULL DEFAULT '' COMMENT '表名',
  `partation_value` varchar(256) DEFAULT NULL COMMENT '分区',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0-成功，1-运行中，2-失败',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `biz_time` datetime DEFAULT NULL COMMENT '业务时间',
  `job_key` varchar(256) NOT NULL DEFAULT '' COMMENT 'job key',
  `remote_id` int(11) NOT NULL DEFAULT '0' COMMENT '远程调用的id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `log_info` longtext COMMENT '日志信息',
  `monitor_type` tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验',
  `dirty_table` varchar(256) comment '脏数据表，一个任务生成一张临时表',
  `dirty_table_status` tinyint(1) default 0 comment '脏数据表状态，0-未删除；1-已删除',
  `exec_end_time` datetime comment '实例运行结束的时间',
  `cyc_time` datetime comment '周期实例计划时间，如果是手动触发，就是任务执行时间',
  `exec_time` int(11) comment '执行时间',
  PRIMARY KEY (`id`),
  KEY `idx_dq_monitor_record` (`monitor_id`,`data_source_type`,`table_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=4985 DEFAULT CHARSET=utf8 COMMENT='监控记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_monitor_rule`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_monitor_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `monitor_id` int(11) NOT NULL COMMENT '监控对象id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `column_name` varchar(256) DEFAULT NULL COMMENT '字段',
  `function_id` int(11) DEFAULT NULL COMMENT '统计函数id',
  `filter` text NOT NULL COMMENT '过滤条件',
  `customize_sql` text NOT NULL COMMENT '自定义sql',
  `verify_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '校验类型',
  `operator` varchar(32) NOT NULL DEFAULT '=' COMMENT '操作,<,>,=等',
  `threshold` varchar(256) NOT NULL DEFAULT '' COMMENT '阈值',
  `is_percentage` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是百分比，0否 1是',
  `is_snapshot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是规则快照，0否 1是',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `select_data_sql` text  NULL COMMENT '查询数据条件',
  `monitor_type` tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验',
  `rule_strength` tinyint(1) unsigned default 1 not null comment '强弱规则，0-无规则（引擎预留）；1-弱规则；2-强规则，默认弱规则',
  PRIMARY KEY (`id`),
  KEY `idx_dq_monitor_rule` (`monitor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1399 DEFAULT CHARSET=utf8 COMMENT='监控规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_notify`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `biz_type` int(11) NOT NULL COMMENT '业务类型，1：规则，2：逐行校验',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `name` varchar(256) DEFAULT '' COMMENT '通知名称',
  `send_way` varchar(128) NOT NULL DEFAULT '' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
  `webhook` varchar(256) NOT NULL DEFAULT '' COMMENT '钉钉告警-自定义机器人的webhook',
  `start_time` varchar(256) DEFAULT '' COMMENT '允许通知的开始时间，如5：00，早上5点',
  `end_time` varchar(256) DEFAULT '' COMMENT '允许通知的结束时间，如22：00，不接受告警',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：正常，1：停止',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_biz_type_relation_id` (`biz_type`,`relation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=697 DEFAULT CHARSET=utf8 COMMENT='通知表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_notify_record`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_notify_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_id` int(11) NOT NULL DEFAULT '0' COMMENT '通知id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `content_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_app_type_notify_id` (`notify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3205 DEFAULT CHARSET=utf8 COMMENT='消息记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_notify_record_read`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_notify_record_read` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_record_id` int(11) NOT NULL DEFAULT '0' COMMENT '通知记录id',
  `user_id` int(11) NOT NULL COMMENT '接收人id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未读 1:已读 2:不可访问',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_notify_record_id` (`notify_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2437 DEFAULT CHARSET=utf8 COMMENT='消息记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_notify_send_record`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_notify_send_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `notify_record_id` int(11) NOT NULL COMMENT '通知记录id',
  `user_id` int(11) NOT NULL COMMENT '发送的用户id',
  `send_type` tinyint(1) NOT NULL COMMENT '1：邮件，2: 短信，3: 微信，4: 钉钉',
  `send_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:准备发送 1:发送成功 2:发送失败',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3427 DEFAULT CHARSET=utf8 COMMENT='通知记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_notify_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_notify_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_id` int(11) NOT NULL COMMENT '通知id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `user_id` int(11) NOT NULL COMMENT '接收人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_notify_id_user_id` (`notify_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1163 DEFAULT CHARSET=utf8 COMMENT='通知与接收人关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_permission`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_permission` (
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_role`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目ID',
  `role_name` varchar(256) NOT NULL COMMENT '角色名称',
  `role_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
  `role_value` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), ADMIN(2), MEMBER(3)',
  `role_desc` varchar(256) NOT NULL DEFAULT '' COMMENT '角色描述',
  `modify_user_id` int(11) COMMENT '修改用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_role_permission`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_role_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `role_id` int(11) unsigned NOT NULL COMMENT '关联角色id',
  `permission_id` int(11) unsigned NOT NULL COMMENT '关联权限id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_role_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `project_id` int(11) NOT NULL DEFAULT '-1' COMMENT '项目ID',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tenant_user_role` (`tenant_id`,`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_subscribe`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_subscribe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `table_id` int(11) NOT NULL DEFAULT '0' COMMENT '对象id,规则配置里的表对象或者逐行校验里的表',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_dq_subscribe` (`user_id`,`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='订阅表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_table`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `data_source_id` int(11) NOT NULL COMMENT '数据源id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `table_name` varchar(256) NOT NULL DEFAULT '' COMMENT '表名',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `monitor_type` tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验',
  `schema_name` varchar(256)  COMMENT '监控规则选定的schema',
  PRIMARY KEY (`id`),
  KEY `idx_dq_table` (`data_source_id`,`table_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8 COMMENT='存储表的表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_tenant`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_tenant` (
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
  KEY `idx_tenant_name` (`tenant_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dtuic_user_id` int(11) NOT NULL COMMENT 'dtuic userid',
  `user_name` varchar(256) NOT NULL COMMENT '用户名称',
  `email` varchar(256) NOT NULL COMMENT '用户email',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `phone_number` varchar(256) DEFAULT NULL COMMENT '用户手机号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dtuic_user_id` (`dtuic_user_id`),
  KEY `idx_user_name` (`user_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_verify`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `origin_table_name` varchar(256) NOT NULL DEFAULT '' COMMENT '左表名称',
  `origin_partition` varchar(512) DEFAULT '' COMMENT '分区字段',
  `target_table_name` varchar(256) NOT NULL DEFAULT '' COMMENT '右表名称',
  `target_partition` varchar(512) DEFAULT '' COMMENT '分区字段',
  `content` text NOT NULL COMMENT '配置的内容文本，包含要执行的sql',
  `execute_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '执行类型，0：立即执行，1：定时执行',
  `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式',
  `task_params` text NOT NULL COMMENT '任务参数',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `monitor_id` int default 0 null comment '监控规则id',
  `schema_name` varchar(256)  COMMENT '监控规则选定的schema',
  PRIMARY KEY (`id`),
  KEY `idx_origin_table_name` (`origin_table_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=797 DEFAULT CHARSET=utf8 COMMENT='校验表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_verify_record`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_verify_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `verify_id` int(11) NOT NULL DEFAULT '0' COMMENT '校验id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '校验状态,0-未开始，1-成功，2-失败，3-运行中',
  `diverse_num` int(11) DEFAULT NULL COMMENT '差异数',
  `diverse_ratio` double(10,2) DEFAULT NULL COMMENT '差异比例',
  `execute_time` datetime DEFAULT NULL COMMENT '执行具体时间',
  `execute_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '修改人id',
  `temp_table` varchar(256) DEFAULT NULL COMMENT '临时表',
  `report` longtext COMMENT '报告文本',
  `job_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'jobId',
  `is_lifecycle` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1销毁',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `data_source_id` int(11) NOT NULL,
  `monitor_record_id` int default 0 null comment '监控规则记录id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1225 DEFAULT CHARSET=utf8 COMMENT='校验记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_verify_report`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_verify_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `verify_record_id` int(11) NOT NULL DEFAULT '0' COMMENT '校验记录id',
  `l_all` int(11) NOT NULL DEFAULT '0',
  `r_all` int(11) NOT NULL DEFAULT '0',
  `map_failure` int(11) NOT NULL DEFAULT '0',
  `map_success` int(11) NOT NULL DEFAULT '0',
  `right_unfound` int(11) NOT NULL DEFAULT '0',
  `left_unfound` int(11) NOT NULL DEFAULT '0',
  `left_id_empty` int(11) NOT NULL DEFAULT '0' COMMENT '左表逻辑主键为空',
  `right_id_empty` int(11) NOT NULL DEFAULT '0' COMMENT '右表逻辑主键为空',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_verifyRecordId` (`verify_record_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2371 DEFAULT CHARSET=utf8 COMMENT='校验报告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dq_snapshot`
--

  /*!40101 SET @saved_cs_client     = @@character_set_client */;
  /*!40101 SET character_set_client = utf8 */;
  CREATE TABLE `dq_snapshot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '统计对象的id',
  `trigger_rules` int(11) NOT NULL DEFAULT '0'COMMENT '触发的规则数',
  `notify_1d` int(11) NOT NULL DEFAULT '0'COMMENT '最近一天的告警数量',
  `notify_7d` int(11) NOT NULL DEFAULT '0'COMMENT '最近七天的告警数量',
  `notify_30d` int(11) NOT NULL DEFAULT '0'COMMENT '最近三十天的告警数量',
  `last_record_id` int(11) NOT NULL DEFAULT '0'COMMENT '最近一次统计的监控记录id',
  `remain_record_ids` varchar(256) COMMENT '上次统计的遗留',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 monitorRecord  2  table',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE key `idx_relationId_type` (`relation_id`, `type`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='监控记录和表对象的统计结果表';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dq_remote_trigger`
--

  CREATE TABLE `dq_remote_trigger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `monitor_id` int(11) NOT NULL DEFAULT '0' COMMENT '监控对象id',
  `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
  `url` text COMMENT '触发url',
  `view_state_url` text COMMENT '查看状态url',
  `rule_ids` text COMMENT '规则id的json字符串',
  `rule_number` int(11) DEFAULT NULL COMMENT '触发规则数',
  `partition_value` varchar(256) DEFAULT NULL COMMENT '分区',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='监控对象的远程触发信息表';


-- 系统参数表
--
-- Table structure for table `dq_sys_parameter`
--

CREATE TABLE `dq_sys_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` VARCHAR(64) NOT NULL COMMENT '参数名称',
  `param_command` VARCHAR(64) NOT NULL COMMENT '参数替换指令',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '系统参数表';

-- 任务对象和任务参数关系表
--
-- Table structure for table `dq_task_parameter`
--

CREATE TABLE `dq_task_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `biz_type` int(11) NOT NULL COMMENT '业务类型，1：规则，2：逐行校验',
  `relation_id` int(11) NOT NULL COMMENT '关联id',
  `parameter_id` int(11) NOT NULL COMMENT '系统参数id',
  `partition_col` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '分区字段',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '任务对象和任务参数关系表';


-- auto-generated definition
create table dq_monitor_record_rules
(
    id           int auto_increment
        primary key,
    record_id    int        default 0                 not null comment '记录id',
    rule_id      int                                  null comment '记录运行时规则集合',
    `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
    gmt_create   datetime   default CURRENT_TIMESTAMP not null comment '新增时间',
    gmt_modified datetime   default CURRENT_TIMESTAMP not null comment '修改时间',
    is_deleted   tinyint(1) default 0                 not null comment '0正常 1逻辑删除',
    status       tinyint(1) default 0                 not null comment '状态'
)
    comment '记录规则表' charset = utf8;

-- 监控规则依赖关系表
create table `dq_monitor_relationship`
(
    `id`                 int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)      NOT NULL DEFAULT '0' COMMENT '租户id',
    `project_id`         int(11)      NOT NULL DEFAULT '1' COMMENT '项目ID',
    `monitor_id`         int(11)      NOT NULL COMMENT '监控规则id（SQL任务的）',
    `parent_monitor_id`  int(11)      NULL COMMENT '工作流中的上游任务监控id，工作流虚节点的值为null',
    `task_type`          tinyint(4)   UNSIGNED NOT NULL COMMENT '引擎任务类型，10-工作流虚节点；0-SQL任务；27-空任务',
    `create_user_id`     int(11)      NOT NULL COMMENT '创建的用户',
    `modify_user_id`     int(11)      NOT NULL COMMENT '修改的用户',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_monitor_id` (`monitor_id`),
    KEY `idx_parent_monitor_id` (parent_monitor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='监控规则依赖关系表';

-- 项目表
--
-- Table structure for table dq_project
--
DROP TABLE IF EXISTS dq_project;
CREATE TABLE dq_project (
  id int NOT NULL AUTO_INCREMENT COMMENT 'id',
  tenant_id int NOT NULL COMMENT '租户id',
  project_name varchar(128) NOT NULL COMMENT '项目名',
  project_alias varchar(512) NOT NULL COMMENT '表中文名',
  project_Identifier varchar(256) DEFAULT NULL COMMENT '项目标识',
  project_desc varchar(2048) DEFAULT NULL COMMENT '项目描述',
	status tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  create_user_id int(11) NOT NULL COMMENT '新建项目的用户id',
  gmt_create datetime NOT NULL  COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  COMMENT '最后修改时间',
  is_deleted tinyint NOT NULL DEFAULT '0' COMMENT '是否删除，0未删除 1删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目表';

-- 项目置顶表
--
-- Table structure for table dq_project_stick
--
DROP TABLE IF EXISTS dq_project_stick;
CREATE TABLE dq_project_stick (
  id int NOT NULL AUTO_INCREMENT COMMENT ' 自增id ',
  tenant_id int NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int NOT NULL DEFAULT '1' COMMENT '项目id',
  user_id int NOT NULL COMMENT '用户id',
  stick datetime DEFAULT NULL COMMENT '置顶字段',
  gmt_create datetime NOT NULL  COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint NOT NULL DEFAULT '0' COMMENT '是否删除，0未删除 1删除',
  PRIMARY KEY (id),
  UNIQUE KEY `idx_project_user_role` (`tenant_id`,`project_id`,`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目的置顶记录表';


-- -----------------------------------
-- ----------Quartz 定时任务------------
-- -----------------------------------
CREATE TABLE `dt_center_cron_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_detail_name` varchar(255) NOT NULL COMMENT 'job名称',
  `job_detail_group` varchar(255) NOT NULL COMMENT 'job group 名称',
  `job_trigger_name` varchar(255) NOT NULL COMMENT 'job trigger 名称',
  `job_trigger_group` varchar(255) NOT NULL COMMENT 'job trigger group 名称',
  `class_name` varchar(255) NOT NULL COMMENT '任务执行类名称',
  `cron` varchar(255) NOT NULL COMMENT 'cron 表达式',
  `concurrent` tinyint(1) NOT NULL COMMENT '0: false, 1:true',
  `start_time` datetime COMMENT '开始时间',
  `end_time` datetime  COMMENT '结束时间',
  `biz_type` VARCHAR(255) NOT NULL COMMENT '任务业务类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_job_name` (`job_detail_name`, `job_detail_group`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


-- 监控关联任务表
--
-- Table structure for table `dq_monitor_association`
--
DROP TABLE IF EXISTS dq_monitor_association;
create table `dq_monitor_association`
(
    `id`                 int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)      NOT NULL DEFAULT '0' COMMENT '租户id',
    `project_id`         int(11)      NOT NULL DEFAULT '1' COMMENT '项目ID',
    `monitor_id`         int(11)      NOT NULL COMMENT '监控规则id（SQL任务的）',
    `dtuic_tenant_id`    int(11)      NOT NULL DEFAULT '0' COMMENT 'uic租户id',
    `assoc_task_id`      int(11)      NOT NULL COMMENT '关联其他项目的的task id',
    `assoc_task_name`		 varchar(256) NOT NULL COMMENT '关联其他项目的的任务名称',
    `assoc_app_type`     tinyint      NOT NULL COMMENT '关联的应用类型，比如离线(1)',
    `assoc_project_alias` varchar(256) NOT NULL COMMENT '关联的应用的项目名称',
    `assoc_project_identifier` varchar(256) NOT NULL COMMENT '关联的应用的项目标识',
    `assoc_project_id`   int(11)      NOT NULL COMMENT '关联的应用项目id',
    `create_user_id`     int(11)      NOT NULL COMMENT '创建的用户',
    `modify_user_id`     int(11)      NOT NULL COMMENT '修改的用户',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '监控关联任务表';

-- v4.2.2

-- kafka实时校验
create table dq_monitor_stream
(
    `id`              int(11) primary key AUTO_INCREMENT comment '主键id',
    `tenant_id`       int(11)    NOT NULL COMMENT '租户id',
    `project_id`      int(11)    NOT NULL DEFAULT '1' COMMENT '项目ID',
    `monitor_id`      int(11) comment '监控规则id',
    `charset`         varchar(32) comment '编码格式',
    `mapping_columns` varchar(1024) comment '映射字段',
    `upper_limit`     int(11) comment '样本量上限',
    `create_user_id`  int(11)    NOT NULL COMMENT '创建的用户',
    `modify_user_id`  int(11)    NOT NULL COMMENT '修改的用户',
    `gmt_create`      datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`    datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`      tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `is_submit`       tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否提交成功 0 提交失败,1 提交成功'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '实时校验（抽检）规则相关信息';

-- 实时校验的临时表
create table dq_stream_temp_result
(
    `tenant_id`      int(11)     NOT NULL COMMENT '租户id',
    `project_id`     int(11)     NOT NULL DEFAULT '1' COMMENT '项目ID',
    `create_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '创建的用户',
    `modify_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '修改的用户',
    `gmt_create`     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`     tinyint(1)  NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `job_id`         varchar(64) not null comment '引擎的job key',
    `monitor_id`     int(11)     not null comment '监控规则id',
    `rule_id`        int(11)     not null comment '子规则id',
    `val`            varchar(32) comment '校验结果值',
    `check_column`   varchar(64) not null comment '校验的字段',
    PRIMARY KEY (`job_id`,`rule_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '实时校验（抽检）临时数据';

-- 实时校验的脏数据表，用于页面查看、下载明细
create table dq_stream_dirty_result
(
    `id`             int(11) primary key AUTO_INCREMENT comment '主键id',
    `tenant_id`      int(11)     NOT NULL COMMENT '租户id',
    `project_id`     int(11)     NOT NULL DEFAULT '1' COMMENT '项目ID',
    `create_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '创建的用户',
    `modify_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '修改的用户',
    `gmt_create`     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`     tinyint(1)  NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `job_id`         varchar(64) not null comment '引擎的job key',
    `monitor_id`     int(11)     not null comment '监控规则id',
    `rule_id`        int(11)     not null comment '子规则id',
    `data`           varchar(1024) comment '脏数据JSON'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '实时校验（抽检）脏数据表';
