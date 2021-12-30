
-- ----------------------------
-- Table structure for da_api
-- ----------------------------
CREATE TABLE `da_api` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) COMMENT '类目ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `data_src_id` int(11),
  `name` varchar(255),
  `tableName` varchar(64) DEFAULT '' COMMENT '目标表名',
  `req_limit` int(11) COMMENT '访问限制',
  `resp_limit` int(11),
  `api_type` varchar(45) DEFAULT '0' COMMENT 'api类型(0-默认,1-注册api)',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态: 0:正常/1:禁用',
  `api_desc` text COMMENT '描述',
  `input_params` text ,
  `output_params` text ,
  `create_user_id` bigint(11) NOT NULL,
  `modify_user_id` bigint(11) NOT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `req_type` int(11) COMMENT '请求类型: 0:GET/1:POST',
  `api_path` varchar(255),
  `resp_page_size` int(11) COMMENT '分页大小',
  `param_cfg_type` int(11) DEFAULT '0' COMMENT '参数配置模式：0-向导模式，1-sql模式',
  `allow_paging` int(11) DEFAULT '0' COMMENT '是否分页：0-不分页，1-分页',
  `config_sql` text,
  `resp_json` text,
  `data_src_type` int(11) COMMENT '数据源类型',
  `original_host` varchar(255) DEFAULT NULL COMMENT '注册API的原始api host',
  `original_path` varchar(200) DEFAULT NULL COMMENT '注册api的原始api path',
  `original_port` INT NULL COMMENT '注册api的原始api port(socket协议)',
  `original_method` varchar(255) DEFAULT NULL COMMENT '注册api原始请求方式。(枚举GET,POST,PUT)',
  `error_code_list_json` text COMMENT '注册api的错误码列表',
  `error_resp_json` text COMMENT '注册api的错误返回示例',
  `body_desc_json` varchar(1000) DEFAULT NULL COMMENT '注册api put、post请求body示例',
  `api_version_code` varchar(45) DEFAULT 'API_WITH_TOKEN',
  `wsdl_xml` text COMMENT 'wsdl xml 文件',
  `save_wsdl_xml` int(11) DEFAULT '0' COMMENT '是否存储 wsdl xml 标记， 0-不存储，1-存储',
  `protocol` varchar(20) DEFAULT NULL COMMENT '协议',
  `contain_header` int(11) DEFAULT '0' COMMENT '返回结果是否携带 header 中的输入参数， 0-不携带，1-携带',
  `contain_page` int(11) DEFAULT '0' COMMENT '返回结果是否携带 Page 分页信息， 0-不携带，1-携带',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `query_time_out` int(11) COMMENT 'api查询超时时间',
  `test_status` int(11) NOT NULL DEFAULT '0' COMMENT 'da_api_test的api状态: 0:未提交/1:已提交',
  `is_secondary_release` int(11) DEFAULT '0' COMMENT '二次发布',
  `cn_name` varchar(255) DEFAULT NULL COMMENT 'api中文名称',
  `is_cache` tinyint(1) DEFAULT '0' COMMENT '是否缓存',
  `cache_expiry_period` int(11) DEFAULT NULL COMMENT '缓存失效周期，1-分，2-时，3-天，4-周，5-月',
  `cache_expiry_date_cron` varchar(255) DEFAULT NULL COMMENT '缓存失效时间的cron表达式',
  `execution_flow_chart` text DEFAULT NULL COMMENT '服务编排执行流程图',
  `is_ignore_syntax_check` tinyint(1) DEFAULT '0' COMMENT '是否忽略语法校验',
  `orchestration_flow` text null COMMENT '服务编排执行流程',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 新增项目表
CREATE TABLE `da_project`
(
  `id`                 int(11)      NOT NULL AUTO_INCREMENT,
  `tenant_id`          int(11)      NOT NULL COMMENT '租户id',
  `project_name`       varchar(256) NOT NULL COMMENT '项目名称',
  `project_identifier` varchar(255)          DEFAULT NULL COMMENT '项目标识名',
  `project_alias`      varchar(256) NOT NULL COMMENT '项目显示名',
  `project_desc`       varchar(4000)         DEFAULT NULL COMMENT '项目描述',
  `status`             tinyint(1)   NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `open_orchestration` int(2) not null default 0 COMMENT '开启服务编排',
  `create_user_id`     int(11)               DEFAULT NULL COMMENT '创建项目的用户id',
  `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted`         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='api项目表';

-- 项目的置顶记录表
CREATE TABLE `da_project_stick`
(
  `id`           int(11)    NOT NULL AUTO_INCREMENT,
  `tenant_id`    int(11)    NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id`   int(11)    NOT NULL DEFAULT '0' COMMENT '项目id',
  `user_id`      int(11)             DEFAULT NULL COMMENT '用户id',
  `stick`        datetime            DEFAULT NULL COMMENT '置顶字段',
  `gmt_create`   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted`   tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='项目的置顶记录表';

-- ----------------------------
-- Table structure for da_api_apply
-- ----------------------------
CREATE TABLE `da_api_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL COMMENT 'API_ID',
  `user_id` int(11) NOT NULL,
  `apply_content` varchar(256) DEFAULT '' COMMENT '申请内容',
  `reply_content` varchar(256) DEFAULT '' COMMENT '回复内容',
  `reply_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0:审核中/1:通过/2:拒绝',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0',
  `call_limit` int(11) DEFAULT '0' COMMENT '申请次数限制，-1表示无限制',
  `begin_time` datetime COMMENT '申请周期开始时间',
  `end_time` datetime COMMENT '申请周期结束时间',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `token` VARCHAR(255) DEFAULT NULL COMMENT 'api调用时的token，默认为空或null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api` (`user_id`,`api_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_api_catalogue
-- ----------------------------
CREATE TABLE `da_api_catalogue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
  `node_name` varchar(128) NOT NULL COMMENT '文件夹名称',
  `order_val` int(3) NOT NULL DEFAULT '0',
  `level` tinyint(1) NOT NULL DEFAULT '0' COMMENT '目录层级 0:一级 1:二级3:二级以下目录',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  KEY `pid_name` (`node_name`,`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_data_source
-- ----------------------------
CREATE TABLE `da_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
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
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  KEY `idx_data_name` (`data_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_data_source_ref
-- ----------------------------
CREATE TABLE `da_data_source_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `biz_type` int(11) NOT NULL COMMENT '业务类型，1:api',
  `relation_id` int(11) DEFAULT NULL COMMENT '关联id',
  `data_source_id` int(11) NOT NULL COMMENT '数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bizType_relationId_dataSourceId` (`biz_type`,`relation_id`,`data_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_dict
-- ----------------------------
CREATE TABLE `da_dict` (
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for da_notify
-- ----------------------------
CREATE TABLE `da_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `biz_type` int(11) NOT NULL COMMENT '业务类型，1：规则，2：逐行校验',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `name` varchar(256) DEFAULT '' COMMENT '通知名称',
  `send_way` varchar(128) NOT NULL DEFAULT '' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
  `start_time` varchar(256) DEFAULT '' COMMENT '允许通知的开始时间，如5：00，早上5点',
  `end_time` varchar(256) DEFAULT '' COMMENT '允许通知的结束时间，如22：00，不接受告警',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0：正常，1：停止',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_biz_type_relation_id` (`biz_type`,`relation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='通知表';

-- ----------------------------
-- Table structure for da_notify_record
-- ----------------------------
CREATE TABLE `da_notify_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_id` int(11) NOT NULL DEFAULT '0' COMMENT '通知id',
  `trigger_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `content_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_app_type_notify_id` (`notify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='消息记录';

-- ----------------------------
-- Table structure for da_notify_record_read
-- ----------------------------
CREATE TABLE `da_notify_record_read` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_record_id` int(11) NOT NULL DEFAULT '0' COMMENT '通知记录id',
  `user_id` int(11) NOT NULL COMMENT '接收人id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未读 1:已读',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_notify_record_id` (`notify_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='消息记录';

-- ----------------------------
-- Table structure for da_notify_send_record
-- ----------------------------
CREATE TABLE `da_notify_send_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_record_id` int(11) NOT NULL COMMENT '通知记录id',
  `user_id` int(11) NOT NULL COMMENT '发送的用户id',
  `send_type` tinyint(1) NOT NULL COMMENT '1：邮件，2: 短信，3: 微信，4: 钉钉',
  `send_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:准备发送 1:发送成功 2:发送失败',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='通知记录表';

-- ----------------------------
-- Table structure for da_notify_user
-- ----------------------------
CREATE TABLE `da_notify_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `notify_id` int(11) NOT NULL COMMENT '通知id',
  `user_id` int(11) NOT NULL COMMENT '接收人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_notify_id_user_id` (`notify_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='通知与接收人关系表';

-- ----------------------------
-- Table structure for da_permission
-- ----------------------------
CREATE TABLE `da_permission` (
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

-- ----------------------------
-- Table structure for da_role
-- ----------------------------
CREATE TABLE `da_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
  `role_name` varchar(256) NOT NULL COMMENT '角色名称',
  `role_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
  `role_value` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), ADMIN(2), MEMBER(3)',
  `role_desc` varchar(256) NOT NULL DEFAULT '' COMMENT '角色描述',
  `modify_user_id` int(11) NOT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for da_role_permission
-- ----------------------------
CREATE TABLE `da_role_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `role_id` int(11) unsigned NOT NULL COMMENT '关联角色id',
  `permission_id` int(11) unsigned NOT NULL COMMENT '关联权限id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

-- ----------------------------
-- Table structure for da_role_user
-- ----------------------------
CREATE TABLE `da_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_role` (`user_id`,`role_id`,`tenant_id`, project_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

-- ----------------------------
-- Table structure for da_snapshot_api
-- ----------------------------
CREATE TABLE `da_snapshot_api` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `invoke_total` bigint(11) NOT NULL DEFAULT '0' COMMENT '调用总计',
  `sub_total` int(11) NOT NULL DEFAULT '0' COMMENT '订阅数总计',
  `fail_total` bigint(11) NOT NULL DEFAULT '0' COMMENT '总失败率',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `tenant_id` int(11) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(2) unsigned zerofill NOT NULL DEFAULT '00',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_id_index` (`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_snapshot_err
-- ----------------------------
CREATE TABLE `da_snapshot_err` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biz_type` tinyint(2) NOT NULL,
  `total_fail` bigint(11) NOT NULL DEFAULT '0',
  `fail_1d` bigint(11) NOT NULL DEFAULT '0',
  `fail_7d` bigint(11) NOT NULL DEFAULT '0',
  `fail_30d` bigint(11) NOT NULL DEFAULT '0',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_user_biztype_index` (`api_id`,`user_id`,`biz_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_snapshot_invoke
-- ----------------------------
CREATE TABLE `da_snapshot_invoke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL COMMENT '用户',
  `api_id` int(11) NOT NULL,
  `invoke_total` bigint(11) DEFAULT NULL COMMENT '调用总计',
  `fail_total` bigint(11) unsigned zerofill DEFAULT '00000000000' COMMENT '总失败率',
  `total_1d` bigint(11) DEFAULT NULL,
  `fail_1d` bigint(11) DEFAULT NULL COMMENT '24h失败率',
  `total_7d` bigint(11) DEFAULT NULL,
  `fail_7d` bigint(11) DEFAULT NULL COMMENT '7日失败率',
  `total_30d` bigint(11) DEFAULT NULL,
  `fail_30d` bigint(11) DEFAULT NULL COMMENT '30日失败率',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(2) unsigned zerofill NOT NULL DEFAULT '00',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_apiId` (`user_id`,`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `da_apply_invoke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL COMMENT '用户',
  `api_id` int(11) NOT NULL,
  `invoke_total` bigint(11) DEFAULT NULL COMMENT '调用总计',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_statistics_trigger
-- ----------------------------
CREATE TABLE `da_statistics_trigger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_count_id` int(11) DEFAULT NULL COMMENT '上次统计到的最后一条invoke_count 表 id',
  `last_log_id` int(11) DEFAULT NULL COMMENT '上次统计到的最后一条invoke_log 表 id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_tenant
-- ----------------------------
CREATE TABLE `da_tenant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dtuic_tenant_id` int(11) NOT NULL COMMENT '租户id',
  `tenant_name` varchar(256) NOT NULL COMMENT '用户名称',
  `tenant_desc` varchar(256) DEFAULT NULL COMMENT '租户描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `create_user_id` bigint(20) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_name` (`tenant_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_user
-- ----------------------------
CREATE TABLE `da_user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for da_security_group
-- ----------------------------
CREATE TABLE `da_security_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL COMMENT '安全组名称',
  `ip` text COMMENT 'ip列表',
  `simple_ip_text` text COMMENT 'ip列表',
  `type` tinyint(1) NOT NULL COMMENT '安全组类型 0：白名单，1：黑名单',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_security_group_ref
-- ----------------------------
CREATE TABLE `da_security_group_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 创建授权表
CREATE TABLE `da_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  `source_id` bigint(20) NOT NULL COMMENT '授权关联人id或者app_id',
  `source_type` SMALLINT(3) NOT NULL DEFAULT 0 COMMENT 'source_id的类型（0-用户id；1-appId）',
  `app_key` varchar(255) NOT NULL COMMENT 'ak',
  `app_secret` varchar(255) NOT NULL COMMENT 'Sk',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNI_APPKEY_TENANT` (`source_id`,`tenant_id`),
  KEY `IND_APPKEY` (`app_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建api授权表
CREATE TABLE `da_api_auth` (
  `id` bigint(20) NOT NULL,
  `api_id` bigint(20) NOT NULL COMMENT 'api id',
  `auth_id` bigint(20) NOT NULL COMMENT 'da_auth表中的id',
  `tenant_id` bigint(20) NOT NULL,
  `begin_time` datetime DEFAULT NULL COMMENT '申请开始调用时间',
  `end_time` datetime DEFAULT NULL COMMENT '申请结束调用时间',
  `call_limit` int(11) DEFAULT NULL,
  `status` smallint(2) DEFAULT '0' COMMENT '授权状态(-1:未申请，0:待处理，1:通过，2:拒绝，3:停用，4:禁用，5，已到期)',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`),
  KEY `idx_api_id_auth_id` (`api_id`,`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `da_row_permission`
(
    `id`                  int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`           int(11)      NOT NULL COMMENT '租户ID',
    `project_id`          int(11)      NOT NULL COMMENT '项目id',
    `row_permission_name` VARCHAR(256) NOT NULL COMMENT '权限标示',
    `modify_user_id`      int(11)      NOT NULL COMMENT '最近修改人id',
    `gmt_create`          datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`          tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='行级权限表';

CREATE TABLE `da_row_permission_user_rel`
(
    `id`                 int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)    NOT NULL COMMENT '租户ID',
    `project_id`         int(11)    NOT NULL COMMENT '项目id',
    `user_id`            int(11)    NOT NULL COMMENT '数据API的用户ID',
    `row_permission_id`  int(11)    NOT NULL COMMENT '行级权限ID',
    `row_permission_val` text       NOT NULL COMMENT '行级权限值',
    `data_type`          int(11)             DEFAULT NULL COMMENT '展示用-数据源类型',
    `data_source_id`     int(11)             DEFAULT NULL COMMENT '展示用-数据源ID',
    `table_name`         VARCHAR(256)        DEFAULT NULL COMMENT '展示用-数据源表名',
    `table_column`       VARCHAR(256)        DEFAULT NULL COMMENT '展示用-数据源字段名',
    `modify_user_id`     int(11)    NOT NULL COMMENT '最近修改人id',
    `gmt_create`         datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='行级权限用户关联表';

CREATE TABLE `da_row_permission_api_rel`
(
    `id`                int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`         int(11)    NOT NULL COMMENT '租户ID',
    `project_id`        int(11)    NOT NULL COMMENT '项目id',
    `api_id`            int(11)    NOT NULL COMMENT '数据APIID',
    `row_permission_id` int(11)    NOT NULL COMMENT '行级权限ID',
    `modify_user_id`    int(11)    NOT NULL COMMENT '最近修改人id',
    `gmt_create`        datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`      datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`        tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='行级权限API关联表';

  CREATE TABLE `da_api_test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) COMMENT '类目ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `data_src_id` int(11),
  `name` varchar(255),
  `tableName` varchar(64) DEFAULT '' COMMENT '目标表名',
  `req_limit` int(11) COMMENT '访问限制',
  `resp_limit` int(11),
  `api_type` varchar(45) DEFAULT '0' COMMENT 'api类型(0-默认,1-注册api)',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态: 0:未提交/1:已提交',
  `api_desc` text COMMENT '描述',
  `input_params` text ,
  `output_params` text ,
  `create_user_id` bigint(11) NOT NULL,
  `modify_user_id` bigint(11) NOT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `req_type` int(11) COMMENT '请求类型: 0:GET/1:POST',
  `api_path` varchar(255),
  `resp_page_size` int(11) COMMENT '分页大小',
  `param_cfg_type` int(11) DEFAULT '0' COMMENT '参数配置模式：0-向导模式，1-sql模式',
  `allow_paging` int(11) DEFAULT '0' COMMENT '是否分页：0-不分页，1-分页',
  `config_sql` text,
  `resp_json` text,
  `data_src_type` int(11) COMMENT '数据源类型',
  `original_host` varchar(255) DEFAULT NULL COMMENT '注册API的原始api host',
  `original_path` varchar(200) DEFAULT NULL COMMENT '注册api的原始api path',
  `original_port` INT NULL COMMENT '注册api的原始api port(socket协议)',
  `original_method` varchar(255) DEFAULT NULL COMMENT '注册api原始请求方式。(枚举GET,POST,PUT)',
  `error_code_list_json` text COMMENT '注册api的错误码列表',
  `error_resp_json` text COMMENT '注册api的错误返回示例',
  `body_desc_json` varchar(1000) DEFAULT NULL COMMENT '注册api put、post请求body示例',
  `api_version_code` varchar(45) DEFAULT 'API_WITH_TOKEN',
  `wsdl_xml` text COMMENT 'wsdl xml 文件',
  `save_wsdl_xml` int(11) DEFAULT '0' COMMENT '是否存储 wsdl xml 标记， 0-不存储，1-存储',
  `protocol` varchar(20) DEFAULT NULL COMMENT '协议',
  `contain_header` int(11) DEFAULT '0' COMMENT '返回结果是否携带 header 中的输入参数， 0-不携带，1-携带',
  `contain_page` int(11) DEFAULT '0' COMMENT '返回结果是否携带 Page 分页信息， 0-不携带，1-携带',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `query_time_out` int(11) COMMENT 'api查询超时时间',
  `cn_name` varchar(255) DEFAULT NULL COMMENT 'api中文名称',
  `is_cache` tinyint(1) DEFAULT '0' COMMENT '是否缓存',
  `cache_expiry_period` int(11) DEFAULT NULL COMMENT '缓存失效周期，1-分，2-时，3-天，4-周，5-月',
  `cache_expiry_date_cron` varchar(255) DEFAULT NULL COMMENT '缓存失效时间的cron表达式',
  `execution_flow_chart` text DEFAULT NULL COMMENT '服务编排执行流程图',
  `is_ignore_syntax_check` tinyint(1) DEFAULT '0' COMMENT '是否忽略语法校验',
  `orchestration_flow` text null COMMENT '服务编排执行流程',
   `page_test_status` int(2) NOT NULL DEFAULT 0 COMMENT '页面测试状态: 0/1 未通过/通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `da_security_group_ref_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `da_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `label_name` varchar(255) NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='标签表';

CREATE TABLE `da_api_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `label_id` int(11) NOT NULL COMMENT '对应da_lable的id',
  `api_id` int(11) NOT NULL COMMENT '对应da_api的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='api标签关联表表';

-- 任务调度表
CREATE TABLE `dt_center_cron_schedule`
(
    `id`                int(11)      NOT NULL AUTO_INCREMENT,
    `job_detail_name`   varchar(255) NOT NULL COMMENT 'job名称',
    `job_detail_group`  varchar(255) NOT NULL COMMENT 'job group 名称',
    `job_trigger_name`  varchar(255) NOT NULL COMMENT 'job trigger 名称',
    `job_trigger_group` varchar(255) NOT NULL COMMENT 'job trigger group 名称',
    `class_name`        varchar(255) NOT NULL COMMENT '任务执行类名称',
    `cron`              varchar(255) NOT NULL COMMENT 'cron 表达式',
    `concurrent`        tinyint(1)   NOT NULL COMMENT '0: false, 1:true',
    `start_time`        datetime COMMENT '开始时间',
    `end_time`          datetime COMMENT '结束时间',
    `biz_type`          VARCHAR(255) NOT NULL COMMENT '任务业务类型',
    `gmt_create`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_job_name` (`job_detail_name`, `job_detail_group`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;




CREATE TABLE `da_alarm_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `alarm_name` varchar(256) NOT NULL DEFAULT '' COMMENT '告警名称',
  `trigger_type` varchar(1) NOT NULL DEFAULT '1' COMMENT '触发方式, 1-调用失败,2-在指定时间段(timeSlot)内出现(failNum)次调用失败,3-单用户连续出现failNum次调用失败',
  `time_slot` int(11) DEFAULT NULL COMMENT '统计失败次数时间段',
  `time_unit` varchar(1) DEFAULT NULL COMMENT '统计失败次数时间段,时间单位',
  `fail_num` int(11) NULL DEFAULT '0' COMMENT '失败次数',
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

-- quartz自带表

CREATE TABLE QRTZ_JOB_DETAILS
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    JOB_NAME          VARCHAR(200) NOT NULL,
    JOB_GROUP         VARCHAR(200) NOT NULL,
    DESCRIPTION       VARCHAR(250) NULL,
    JOB_CLASS_NAME    VARCHAR(250) NOT NULL,
    IS_DURABLE        VARCHAR(1)   NOT NULL,
    IS_NONCONCURRENT  VARCHAR(1)   NOT NULL,
    IS_UPDATE_DATA    VARCHAR(1)   NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1)   NOT NULL,
    JOB_DATA          BLOB         NULL,
    PRIMARY KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_TRIGGERS
(
    SCHED_NAME     VARCHAR(120) NOT NULL,
    TRIGGER_NAME   VARCHAR(200) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL,
    JOB_NAME       VARCHAR(200) NOT NULL,
    JOB_GROUP      VARCHAR(200) NOT NULL,
    DESCRIPTION    VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13)   NULL,
    PREV_FIRE_TIME BIGINT(13)   NULL,
    PRIORITY       INTEGER      NULL,
    TRIGGER_STATE  VARCHAR(16)  NOT NULL,
    TRIGGER_TYPE   VARCHAR(8)   NOT NULL,
    START_TIME     BIGINT(13)   NOT NULL,
    END_TIME       BIGINT(13)   NULL,
    CALENDAR_NAME  VARCHAR(200) NULL,
    MISFIRE_INSTR  SMALLINT(2)  NULL,
    JOB_DATA       BLOB         NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(200) NOT NULL,
    TRIGGER_GROUP   VARCHAR(200) NOT NULL,
    REPEAT_COUNT    BIGINT(7)    NOT NULL,
    REPEAT_INTERVAL BIGINT(12)   NOT NULL,
    TIMES_TRIGGERED BIGINT(10)   NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(200) NOT NULL,
    TRIGGER_GROUP   VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(120) NOT NULL,
    TIME_ZONE_ID    VARCHAR(80),
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    VARCHAR(120)   NOT NULL,
    TRIGGER_NAME  VARCHAR(200)   NOT NULL,
    TRIGGER_GROUP VARCHAR(200)   NOT NULL,
    STR_PROP_1    VARCHAR(512)   NULL,
    STR_PROP_2    VARCHAR(512)   NULL,
    STR_PROP_3    VARCHAR(512)   NULL,
    INT_PROP_1    INT            NULL,
    INT_PROP_2    INT            NULL,
    LONG_PROP_1   BIGINT         NULL,
    LONG_PROP_2   BIGINT         NULL,
    DEC_PROP_1    NUMERIC(13, 4) NULL,
    DEC_PROP_2    NUMERIC(13, 4) NULL,
    BOOL_PROP_1   VARCHAR(1)     NULL,
    BOOL_PROP_2   VARCHAR(1)     NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    TRIGGER_NAME  VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA     BLOB         NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    INDEX (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_CALENDARS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    CALENDAR_NAME VARCHAR(200) NOT NULL,
    CALENDAR      BLOB         NOT NULL,
    PRIMARY KEY (SCHED_NAME, CALENDAR_NAME)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    ENTRY_ID          VARCHAR(95)  NOT NULL,
    TRIGGER_NAME      VARCHAR(200) NOT NULL,
    TRIGGER_GROUP     VARCHAR(200) NOT NULL,
    INSTANCE_NAME     VARCHAR(200) NOT NULL,
    FIRED_TIME        BIGINT(13)   NOT NULL,
    SCHED_TIME        BIGINT(13)   NOT NULL,
    PRIORITY          INTEGER      NOT NULL,
    STATE             VARCHAR(16)  NOT NULL,
    JOB_NAME          VARCHAR(200) NULL,
    JOB_GROUP         VARCHAR(200) NULL,
    IS_NONCONCURRENT  VARCHAR(1)   NULL,
    REQUESTS_RECOVERY VARCHAR(1)   NULL,
    PRIMARY KEY (SCHED_NAME, ENTRY_ID)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    INSTANCE_NAME     VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13)   NOT NULL,
    CHECKIN_INTERVAL  BIGINT(13)   NOT NULL,
    PRIMARY KEY (SCHED_NAME, INSTANCE_NAME)
)
    ENGINE = InnoDB;

CREATE TABLE QRTZ_LOCKS
(
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40)  NOT NULL,
    PRIMARY KEY (SCHED_NAME, LOCK_NAME)
)
    ENGINE = InnoDB;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS (SCHED_NAME, REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS (SCHED_NAME, JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS (SCHED_NAME, JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS (SCHED_NAME, CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS (SCHED_NAME, NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP,
                                                             TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

commit;

CREATE TABLE `da_package_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `import_user_id` int(11) COMMENT '导入人',
  `state` int(1) COMMENT 'api包导入状态，6种',
  `package_name` varchar(255) NOT NULL COMMENT 'api包名称',
  `package_desc` varchar(255) NOT NULL COMMENT '描述',
  `md5_val` varchar(255) NOT NULL COMMENT 'md5值',
  `source_project` varchar(255) NOT NULL COMMENT '原项目名称',
  `source_tenant` varchar(255) NOT NULL COMMENT '原租户名称',
  `api_count` int(11) NOT NULL DEFAULT '0' COMMENT 'api总数量',
  `api_fail` int(11) NOT NULL DEFAULT '0' COMMENT 'API失败数量',
  `api_success` int(11) NOT NULL DEFAULT '0' COMMENT 'api成功数',
  `tenant_id` int(11) COMMENT 'id',
  `project_id` int(11) COMMENT 'id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='api包记录表';

CREATE TABLE `da_api_import` ( -- (修改,api导入表)
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
 -- `cat_id` int(11) COMMENT '类目ID',
 -- `tenant_id` int(11) NOT NULL COMMENT '租户ID',
 -- `data_src_id` int(11),
  `data_src_name` varchar(255),
  `api_cat_path` text,
  `package_id` int(11) NOT NULL COMMENT 'api包id',
  `import_state` int(11) DEFAULT '0' COMMENT '状态，成功or失败',
  `labels` text COMMENT 'api标签',
  `name` varchar(255),
  `table_name` varchar(255) DEFAULT '' COMMENT '目标表名',
  `req_limit` int(11) COMMENT '访问限制',
  `resp_limit` int(11),
  `api_type` varchar(45) DEFAULT '0' COMMENT 'api类型(0-默认,1-注册api)',
 -- `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态: 0:正常/1:禁用',
  `api_desc` text COMMENT '描述',
  `input_params` text ,
  `output_params` text ,
  `create_user_id` bigint(11) NOT NULL,
  `modify_user_id` bigint(11) NOT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `req_type` int(11) COMMENT '请求类型: 0:GET/1:POST',
  `api_path` varchar(255),
  `resp_page_size` int(11) COMMENT '分页大小',
  `param_cfg_type` int(11) DEFAULT '0' COMMENT '参数配置模式：0-向导模式，1-sql模式',
  `allow_paging` int(11) DEFAULT '0' COMMENT '是否分页：0-不分页，1-分页',
  `config_sql` text,
  `resp_json` text,
  `data_src_type` int(11) COMMENT '数据源类型',
  `original_host` varchar(255) DEFAULT NULL COMMENT '注册API的原始api host',
  `original_path` varchar(200) DEFAULT NULL COMMENT '注册api的原始api path',
  `original_method` varchar(255) DEFAULT NULL COMMENT '注册api原始请求方式。(枚举GET,POST,PUT)',
  `error_code_list_json` text COMMENT '注册api的错误码列表',
  `error_resp_json` text COMMENT '注册api的错误返回示例',
  `body_desc_json` varchar(1000) DEFAULT NULL COMMENT '注册api put、post请求body示例',
  `api_version_code` varchar(45) DEFAULT 'API_WITH_TOKEN',
  `wsdl_xml` text COMMENT 'wsdl xml 文件',
  `save_wsdl_xml` int(11) DEFAULT '0' COMMENT '是否存储 wsdl xml 标记， 0-不存储，1-存储',
  `protocol` varchar(20) DEFAULT NULL COMMENT '协议',
  `contain_header` int(11) DEFAULT '0' COMMENT '返回结果是否携带 header 中的输入参数， 0-不携带，1-携带',
  `contain_page` int(11) DEFAULT '0' COMMENT '返回结果是否携带 Page 分页信息， 0-不携带，1-携带',
  -- `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `query_time_out` int(11) COMMENT 'api查询超时时间',
 -- `test_status` int(11) NOT NULL DEFAULT '0' COMMENT 'da_api_test的api状态: 0:未提交/1:已提交',
 -- `is_secondary_release` int(11) DEFAULT '0' COMMENT '二次发布',
  `cn_name` varchar(255) DEFAULT NULL COMMENT 'api中文名称',
  `is_cache` tinyint(1) DEFAULT '0' COMMENT '是否缓存',
  `cache_expiry_period` int(11) DEFAULT NULL COMMENT '缓存失效周期，1-分，2-时，3-天，4-周，5-月',
  `cache_expiry_date_cron` varchar(255) DEFAULT NULL COMMENT '缓存失效时间的cron表达式',
  `is_ignore_syntax_check` tinyint(1) DEFAULT '0' COMMENT '是否忽略语法校验',
  `log` text COMMENT '操作日志',
  `api_id` int(11) COMMENT 'apiid',

  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

create table da_invoke_count
(
    id           int(11) unsigned auto_increment
        primary key,
    user_id      int                  not null,
    invoke_time  datetime             not null,
    api_id       int                  not null,
    count        int                  not null,
    execute_time int(36)              not null,
    gmt_create   datetime             not null,
    gmt_modified datetime             not null on update CURRENT_TIMESTAMP,
    is_deleted   tinyint(2) default 0 not null comment '0正常 1逻辑删除',
    app_sign     varchar(64)          not null,
    project_id int(11) DEFAULT NULL COMMENT '项目id',
    index invoke_time(invoke_time)
)
    charset = utf8;

create index app_u_a_i
    on da_invoke_count (app_sign, user_id, api_id);

create table da_invoke_count_all
(
    id           int(11) unsigned auto_increment primary key,
    user_id      int                  not null,
    invoke_time  datetime             not null,
    api_id       int                  not null,
    count        int                  not null,
    execute_time int(36)              not null,
    gmt_create   datetime             not null,
    gmt_modified datetime             not null on update CURRENT_TIMESTAMP,
    is_deleted   tinyint(2) default 0 not null comment '0正常 1逻辑删除',
    app_sign     varchar(64)          not null,
    project_id   int(11)    DEFAULT NULL COMMENT '项目id',
    index invoke_time(invoke_time)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='调用情况统计表（全记录）';

create table da_invoke_count_day
(
    id           int(11) unsigned auto_increment primary key,
    user_id      int                  not null,
    invoke_time  datetime             not null,
    api_id       int                  not null,
    count        int                  not null,
    execute_time int(36)              not null,
    gmt_create   datetime             not null,
    gmt_modified datetime             not null on update CURRENT_TIMESTAMP,
    is_deleted   tinyint(2) default 0 not null comment '0正常 1逻辑删除',
    app_sign     varchar(64)          not null,
    project_id   int(11)    DEFAULT NULL COMMENT '项目id',
    index api_time(api_id, invoke_time)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='调用情况统计表（按日维度）';

create  table  da_invoke_log
(
    id           bigint(36) unsigned auto_increment
        primary key,
    user_id      bigint(36)                           not null,
    api_id       int(36)                              not null comment '接口id',
    biz_type     tinyint(2)                           not null comment '日志类型',
    invoke_time  datetime                             not null comment '调用时间',
    content      text                                 null comment '日志内容',
    gmt_create   datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modified datetime   default CURRENT_TIMESTAMP not null comment '修改时间',
    app_sign     varchar(64)                          not null,
    is_deleted   tinyint(2) default 0                 not null comment '0正常 1逻辑删除',
    project_id int(11) DEFAULT NULL COMMENT '项目id'
) charset = utf8;


-- 函数目录表
CREATE TABLE `da_function_catalogue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `pid` int(11) NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
  `node_name` varchar(128) NOT NULL COMMENT '文件夹名称',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_nodeName` (`tenant_id`,`project_id`,`node_name`) USING BTREE,
  KEY `idx_pid` (`tenant_id`,`project_id`,`node_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 函数表
CREATE TABLE `da_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `catalogue_id` int(11) NOT NULL COMMENT '目录id',
  `function_name` varchar(128) NOT NULL COMMENT '函数名称',
  `function_desc` varchar(128) NOT NULL DEFAULT '' COMMENT '函数描述',
  `content` varchar(2048) NOT NULL DEFAULT '' COMMENT '函数内容',
  `input_param` varchar(1024) NOT NULL DEFAULT '' COMMENT '输入参数',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT 'python版本',
  `status` int(2) NOT NULL DEFAULT 0 COMMENT '函数状态: 0正常 1禁用 2 未发布',
  `test_status` int(2) NOT NULL DEFAULT 0 COMMENT 'da_function_test.status',
  `is_secondary_release` int(2) DEFAULT '0' COMMENT '二次发布',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '更新用户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_funcName` (`tenant_id`,`project_id`,`function_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 函数测试表
CREATE TABLE `da_function_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `catalogue_id` int(11) NOT NULL COMMENT '目录id',
  `function_name` varchar(128) NOT NULL COMMENT '函数名称',
  `function_desc` varchar(128) NOT NULL DEFAULT '' COMMENT '函数描述',
  `content` varchar(2048) NOT NULL DEFAULT '' COMMENT '函数内容',
  `input_param` varchar(1024) NOT NULL DEFAULT '' COMMENT '输入参数',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT 'python版本',
  `status` int(2) NOT NULL DEFAULT 0 COMMENT '函数状态: 0:未提交/1:已提交',
  `page_test_status` int(2) NOT NULL DEFAULT 0 COMMENT '页面测试是否成功 1/0',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '更新用户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_funcName` (`tenant_id`,`project_id`,`function_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 函数变更记录表
CREATE TABLE `da_function_change_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `function_id` int(11) NOT NULL COMMENT '函数id',
  `catalogue_id` int(11) NOT NULL COMMENT '目录id',
  `function_name` varchar(128) NOT NULL COMMENT '函数名称',
  `function_desc` varchar(128) NOT NULL DEFAULT '' COMMENT '函数描述',
  `content` varchar(2048) NOT NULL DEFAULT '' COMMENT '函数内容',
  `input_param` varchar(1024) NOT NULL DEFAULT '' COMMENT '输入参数',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT 'python版本',
  `change_version` int(11) NOT NULL DEFAULT 1 COMMENT '变更版本，递增+1',
  `submit_comment` varchar(1024) NOT NULL DEFAULT '' COMMENT '提交备注',
  `submit_user_id` int(11) NOT NULL COMMENT '提交人',
  `publish_user_id` int(11) NULL COMMENT '发布用户id',
  `publish_time` datetime NULL COMMENT '发布时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `uniq_funcName` (`tenant_id`,`project_id`,`function_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

drop table if exists da_orchestrate_node;
CREATE TABLE `da_orchestrate_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `orchestration_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务编排id',
  `relation_id` int(11) NULL DEFAULT '0' COMMENT '关联id',
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '关联id的类型, START(1),END(2),API(3),PYTHON_FUNCTION(4)',
  `node_name` varchar(256) NOT NULL DEFAULT '' COMMENT '节点名称',
  `node_desc` varchar(256) NULL DEFAULT '' COMMENT '节点描述',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_orcheId` (`tenant_id`,`project_id`, `orchestration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT ='服务编排节点表';

CREATE TABLE `da_orchestrate_node_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `orchestration_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务编排id',
  `relation_id` int(11) NULL DEFAULT '0' COMMENT '关联id',
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '关联id的类型, START(1),END(2),API(3),PYTHON_FUNCTION(4)',
  `node_name` varchar(256) NOT NULL DEFAULT '' COMMENT '节点名称',
  `node_desc` varchar(256) NULL DEFAULT '' COMMENT '节点描述',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_orcheId` (`tenant_id`,`project_id`, `orchestration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT ='服务编排节点表';


drop table if exists da_orchestrate_node_mapping;
CREATE TABLE `da_orchestrate_node_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `orchestration_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务编排id',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点id',
  `parent_node_id` int(11) NULL DEFAULT '0' COMMENT '上游节点id',
  `param_name` varchar(256) NOT NULL DEFAULT '' COMMENT '参数名称',
  `param_type` varchar(128) NULL DEFAULT '' COMMENT '参数类型',
  `required` int(2) NOT NULL DEFAULT '0' COMMENT '是否必填 1-必填 0-非必填',
  `json_path` varchar(256) NULL DEFAULT '' COMMENT 'json路径',
  `test_value` varchar(1024) NULL DEFAULT '' COMMENT '测试值',
  `is_page` int(2) NOT NULL DEFAULT '0' COMMENT '是否是分页参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nodeId_param` (`tenant_id`,`project_id`,`orchestration_id`,`node_id`,`param_name`) USING BTREE
	) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT '服务编排节点入参映射配置表';



drop table if exists da_orchestrate_node_mapping_test;
CREATE TABLE `da_orchestrate_node_mapping_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `orchestration_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务编排id',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点id',
  `parent_node_id` int(11) NULL DEFAULT '0' COMMENT '上游节点id',
  `param_name` varchar(256) NOT NULL DEFAULT '' COMMENT '参数名称',
  `param_type` varchar(128) NULL DEFAULT '' COMMENT '参数类型',
  `required` int(2) NOT NULL DEFAULT '0' COMMENT '是否必填 1-必填 0-非必填',
  `json_path` varchar(256) NULL DEFAULT '' COMMENT 'json路径',
  `test_value` varchar(1024) NULL DEFAULT '' COMMENT '测试值',
  `is_page` int(2) NOT NULL DEFAULT '0' COMMENT '是否是分页参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nodeId_param` (`tenant_id`,`project_id`,`orchestration_id`,`node_id`,`param_name`) USING BTREE
	) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT '服务编排节点入参映射配置表';


drop table if exists da_api_source_ref;
CREATE TABLE `da_api_source_ref` (
	`id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
	`tenant_id` BIGINT ( 20 ) NOT NULL,
	`project_id` INT ( 11 ) DEFAULT NULL COMMENT '项目id',
	`api_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT 'apiId',
	`source_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT '数据源id',
	`source_type` INT ( 2 ) NOT NULL DEFAULT '1' COMMENT '数据源类型',
	`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
	`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
	PRIMARY KEY ( `id` ),
KEY `idx_source_api` ( `source_id`, `api_id` )
) ENGINE = INNODB AUTO_INCREMENT = 57 DEFAULT CHARSET = utf8 COMMENT = 'API-数据源关联表';

drop table if exists da_api_source_ref_test;
CREATE TABLE `da_api_source_ref_test` (
	`id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
	`tenant_id` BIGINT ( 20 ) NOT NULL,
	`project_id` INT ( 11 ) DEFAULT NULL COMMENT '项目id',
	`api_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT 'apiId',
	`source_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT '数据源id',
	`source_type` INT ( 2 ) NOT NULL DEFAULT '1' COMMENT '数据源类型',
	`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
	`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
	PRIMARY KEY ( `id` ),
KEY `idx_source_api` ( `source_id`, `api_id` )
) ENGINE = INNODB AUTO_INCREMENT = 57 DEFAULT CHARSET = utf8 COMMENT = 'API-数据源关联测试表';
