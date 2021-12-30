CREATE TABLE `da_api` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) DEFAULT NULL COMMENT '类目ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `data_src_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `tableName` varchar(64) DEFAULT '' COMMENT '目标表名',
  `req_limit` int(11) DEFAULT NULL COMMENT '访问限制',
  `resp_limit` int(11) DEFAULT NULL,
  `api_type` varchar(45) DEFAULT '0' COMMENT 'api类型(0-默认,1-注册api)',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态: 0:正常/1:禁用',
  `api_desc` text COMMENT '描述',
  `input_params` text,
  `output_params` longtext COMMENT '输出参数配置',
  `create_user_id` bigint(11) NOT NULL,
  `modify_user_id` bigint(11) NOT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `req_type` int(11) DEFAULT NULL COMMENT '请求类型: 0:GET/1:POST',
  `api_path` varchar(255) DEFAULT NULL,
  `resp_page_size` int(11) DEFAULT NULL COMMENT '分页大小',
  `param_cfg_type` int(11) DEFAULT '0' COMMENT '参数配置模式：0-向导模式，1-sql模式',
  `allow_paging` int(11) DEFAULT '0' COMMENT '是否分页：0-不分页，1-分页',
  `config_sql` text,
  `resp_json` text,
  `data_src_type` int(11) DEFAULT NULL COMMENT '数据源类型',
  `original_host` varchar(255) DEFAULT NULL COMMENT '注册API的原始api host',
  `original_path` varchar(200) DEFAULT NULL COMMENT '注册api的原始api path',
  `original_port` int(11) DEFAULT NULL COMMENT '注册api的原始api port(socket协议)',
  `original_method` varchar(255) DEFAULT NULL COMMENT '注册api原始请求方式。(枚举GET,POST,PUT)',
  `error_code_list_json` text COMMENT '注册api的错误码列表',
  `error_resp_json` text COMMENT '注册api的错误返回示例',
  `body_desc_json` longtext COMMENT '注册api put、post请求body示例',
  `api_version_code` varchar(45) DEFAULT 'API_WITH_TOKEN',
  `wsdl_xml` text COMMENT 'wsdl xml 文件',
  `save_wsdl_xml` int(11) DEFAULT '0' COMMENT '是否存储 wsdl xml 标记， 0-不存储，1-存储',
  `protocol` varchar(20) DEFAULT NULL COMMENT '协议',
  `contain_header` int(11) DEFAULT '0' COMMENT '返回结果是否携带 header 中的输入参数， 0-不携带，1-携带',
  `contain_page` int(11) DEFAULT '0' COMMENT '返回结果是否携带 Page 分页信息， 0-不携带，1-携带',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `query_time_out` int(11) DEFAULT NULL COMMENT 'api查询超时时间',
  `test_status` int(11) NOT NULL DEFAULT '0' COMMENT 'da_api_test的api状态: 0:未提交/1:已提交',
  `is_secondary_release` int(11) DEFAULT '0' COMMENT '二次发布',
  `cn_name` varchar(255) DEFAULT NULL COMMENT 'api中文名称',
  `is_cache` tinyint(1) DEFAULT '0' COMMENT '是否缓存',
  `cache_expiry_period` int(11) DEFAULT NULL COMMENT '缓存失效周期，1-分，2-时，3-天，4-周，5-月',
  `cache_expiry_date_cron` varchar(255) DEFAULT NULL COMMENT '缓存失效时间的cron表达式',
  `is_ignore_syntax_check` tinyint(1) DEFAULT '0' COMMENT '是否忽略语法校验',
  `orchestration_flow` text COMMENT '服务编排执行流程',
  `app_type` int(2) NOT NULL DEFAULT '3' COMMENT '应用标识：1-RDOS，2-DQ，3-API，4-TAG，5-MAP，6-CONSOLE，7-STREAM，8-DATASCIENCE，9-DATAASSETS',
  `transfer_encrypt_type` tinyint(1) DEFAULT '0' COMMENT '传输加密方式:0-不加密,1-RSA+AES',
  `content_type` int(2) DEFAULT '1' COMMENT '输入方式 json(1) formdata(2)',
  `contain_original_status` int(2) DEFAULT '0' COMMENT '返回结果中携带第三方 API 状态码 0/1',
  `dtuic_tenant_id` int(11) NOT NULL COMMENT 'uic租户id',
  `data_center_id` int(11) DEFAULT NULL COMMENT '数据源中心id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1553 DEFAULT CHARSET=utf8;


CREATE TABLE `da_api_test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) DEFAULT NULL COMMENT '类目ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `data_src_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `tableName` varchar(64) DEFAULT '' COMMENT '目标表名',
  `req_limit` int(11) DEFAULT NULL COMMENT '访问限制',
  `resp_limit` int(11) DEFAULT NULL,
  `api_type` varchar(45) DEFAULT '0' COMMENT 'api类型(0-默认,1-注册api)',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态: 0:未提交/1:已提交',
  `api_desc` text COMMENT '描述',
  `input_params` text,
  `output_params` longtext COMMENT '输出参数配置',
  `create_user_id` bigint(11) NOT NULL,
  `modify_user_id` bigint(11) NOT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `req_type` int(11) DEFAULT NULL COMMENT '请求类型: 0:GET/1:POST',
  `api_path` varchar(255) DEFAULT NULL,
  `resp_page_size` int(11) DEFAULT NULL COMMENT '分页大小',
  `param_cfg_type` int(11) DEFAULT '0' COMMENT '参数配置模式：0-向导模式，1-sql模式',
  `allow_paging` int(11) DEFAULT '0' COMMENT '是否分页：0-不分页，1-分页',
  `config_sql` text,
  `resp_json` text,
  `data_src_type` int(11) DEFAULT NULL COMMENT '数据源类型',
  `original_host` varchar(255) DEFAULT NULL COMMENT '注册API的原始api host',
  `original_path` varchar(200) DEFAULT NULL COMMENT '注册api的原始api path',
  `original_port` int(11) DEFAULT NULL COMMENT '注册api的原始api port(socket协议)',
  `original_method` varchar(255) DEFAULT NULL COMMENT '注册api原始请求方式。(枚举GET,POST,PUT)',
  `error_code_list_json` text COMMENT '注册api的错误码列表',
  `error_resp_json` text COMMENT '注册api的错误返回示例',
  `body_desc_json` longtext COMMENT '注册api put、post请求body示例',
  `api_version_code` varchar(45) DEFAULT 'API_WITH_TOKEN',
  `wsdl_xml` text COMMENT 'wsdl xml 文件',
  `save_wsdl_xml` int(11) DEFAULT '0' COMMENT '是否存储 wsdl xml 标记， 0-不存储，1-存储',
  `protocol` varchar(20) DEFAULT NULL COMMENT '协议',
  `contain_header` int(11) DEFAULT '0' COMMENT '返回结果是否携带 header 中的输入参数， 0-不携带，1-携带',
  `contain_page` int(11) DEFAULT '0' COMMENT '返回结果是否携带 Page 分页信息， 0-不携带，1-携带',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `query_time_out` int(11) DEFAULT NULL COMMENT 'api查询超时时间',
  `cn_name` varchar(255) DEFAULT NULL COMMENT 'api中文名称',
  `is_cache` tinyint(1) DEFAULT '0' COMMENT '是否缓存',
  `cache_expiry_period` int(11) DEFAULT NULL COMMENT '缓存失效周期，1-分，2-时，3-天，4-周，5-月',
  `cache_expiry_date_cron` varchar(255) DEFAULT NULL COMMENT '缓存失效时间的cron表达式',
  `is_ignore_syntax_check` tinyint(1) DEFAULT '0' COMMENT '是否忽略语法校验',
  `orchestration_flow` text COMMENT '服务编排执行流程',
  `page_test_status` int(2) NOT NULL DEFAULT '0' COMMENT '页面测试状态: 0/1 未通过/通过',
  `app_type` int(2) NOT NULL DEFAULT '3' COMMENT '应用标识：1-RDOS，2-DQ，3-API，4-TAG，5-MAP，6-CONSOLE，7-STREAM，8-DATASCIENCE，9-DATAASSETS',
  `transfer_encrypt_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '传输加密方式:0-不加密,1-RSA+AES',
  `content_type` int(2) DEFAULT '1' COMMENT '输入方式 json(1) formdata(2)',
  `contain_original_status` int(2) DEFAULT '0' COMMENT '返回结果中携带第三方 API 状态码 0/1',
  `dtuic_tenant_id` int(11) NOT NULL COMMENT 'uic租户id',
  `data_center_id` int(11) DEFAULT NULL COMMENT '数据源中心id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1552 DEFAULT CHARSET=utf8;

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
  `begin_time` datetime DEFAULT NULL COMMENT '申请周期开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '申请周期结束时间',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `token` varchar(255) DEFAULT NULL COMMENT 'api调用时的token，默认为空或null',
  `output_params` text COMMENT '输出参数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_api` (`user_id`,`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8;

CREATE TABLE `da_api_group_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组id',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '分流比例',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_group_rel` (`group_id`,`relation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=utf8 COMMENT='服务分组关联表';

CREATE TABLE `da_api_group_relation_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组id',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '分流比例',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_group_rel` (`group_id`,`relation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8 COMMENT='服务分组关联测试表';

CREATE TABLE `da_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  `source_id` bigint(20) NOT NULL COMMENT '授权关联人id或者app_id',
  `source_type` smallint(3) NOT NULL DEFAULT '0' COMMENT 'source_id的类型（0-用户id；1-appId）',
  `app_key` varchar(255) NOT NULL COMMENT 'ak',
  `app_secret` varchar(255) NOT NULL COMMENT 'Sk',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UNI_APPKEY_TENANT` (`source_id`,`tenant_id`) USING BTREE,
  KEY `IND_APPKEY` (`app_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '函数状态: 0正常 1禁用 2 未发布',
  `test_status` int(2) NOT NULL DEFAULT '0' COMMENT 'da_function_test.status',
  `is_secondary_release` int(2) DEFAULT '0' COMMENT '二次发布',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '更新用户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_funcName` (`tenant_id`,`project_id`,`function_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

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
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '函数状态: 0:未提交/1:已提交',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '更新用户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `page_test_status` int(2) NOT NULL DEFAULT '0' COMMENT '页面测试是否成功 1/0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_funcName` (`tenant_id`,`project_id`,`function_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

CREATE TABLE `da_invoke_log` (
  `id` bigint(36) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(36) NOT NULL,
  `api_id` int(36) NOT NULL COMMENT '接口id',
  `biz_type` tinyint(2) NOT NULL COMMENT '日志类型',
  `invoke_time` datetime NOT NULL COMMENT '调用时间',
  `content` text COMMENT '日志内容',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `app_sign` varchar(64) NOT NULL,
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=68127 DEFAULT CHARSET=utf8;

CREATE TABLE `da_invoke_count` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `invoke_time` datetime NOT NULL,
  `api_id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `execute_time` int(36) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `app_sign` varchar(64) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `invoke_time` (`invoke_time`) USING BTREE,
  KEY `app_u_a_i` (`app_sign`,`user_id`,`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3693 DEFAULT CHARSET=utf8;

CREATE TABLE `da_row_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `row_permission_name` varchar(256) NOT NULL COMMENT '权限标示',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='行级权限表';

CREATE TABLE `da_row_permission_api_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `api_id` int(11) NOT NULL COMMENT '数据APIID',
  `row_permission_id` int(11) NOT NULL COMMENT '行级权限ID',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='行级权限API关联表';

CREATE TABLE `da_row_permission_user_rel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '数据API的用户ID',
  `row_permission_id` int(11) NOT NULL COMMENT '行级权限ID',
  `row_permission_val` text NOT NULL COMMENT '行级权限值',
  `data_type` int(11) DEFAULT NULL COMMENT '展示用-数据源类型',
  `data_source_id` int(11) DEFAULT NULL COMMENT '展示用-数据源ID',
  `table_name` varchar(256) DEFAULT NULL COMMENT '展示用-数据源表名',
  `table_column` varchar(256) DEFAULT NULL COMMENT '展示用-数据源字段名',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='行级权限用户关联表';

CREATE TABLE `da_secret_key_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `public_key` varchar(1024) NOT NULL COMMENT 'RSA公钥',
  `private_key` varchar(1024) NOT NULL COMMENT 'RSA私钥',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除:0-正常,1-逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_tenant` (`user_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='秘钥信息表';

CREATE TABLE `da_security_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL COMMENT '安全组名称',
  `ip` text COMMENT 'ip列表',
  `simple_ip_text` text COMMENT 'ip列表',
  `type` tinyint(1) NOT NULL COMMENT '安全组类型 0：白名单，1：黑名单',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

CREATE TABLE `da_security_group_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE `da_security_group_ref_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

CREATE TABLE `da_user_test_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `api_id` int(11) NOT NULL DEFAULT '0' COMMENT 'apiId',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'userId',
  `token` varchar(256) NOT NULL DEFAULT '0' COMMENT '测试token',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_source_api` (`api_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=703 DEFAULT CHARSET=utf8 COMMENT='用户-API测试token关联表';


CREATE TABLE `da_invoke_count_day` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `invoke_time` datetime NOT NULL,
  `api_id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `execute_time` int(36) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `app_sign` varchar(64) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `api_time` (`api_id`,`invoke_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8 COMMENT='调用情况统计表（按日维度）';

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `api_id_index` (`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10246557 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `api_user_biztype_index` (`api_id`,`user_id`,`biz_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4837285 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `userid_apiId` (`user_id`,`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6590727 DEFAULT CHARSET=utf8;

CREATE TABLE `da_statistics_trigger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_count_id` int(11) DEFAULT NULL COMMENT '上次统计到的最后一条invoke_count 表 id',
  `last_log_id` int(11) DEFAULT NULL COMMENT '上次统计到的最后一条invoke_log 表 id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73895 DEFAULT CHARSET=utf8;


CREATE TABLE `da_apply_invoke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL COMMENT '用户',
  `api_id` int(11) NOT NULL,
  `invoke_total` bigint(11) DEFAULT NULL COMMENT '调用总计',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1593 DEFAULT CHARSET=utf8;



-- 将原有已提交的api测试状态置为测试已通过
UPDATE da_api_test set page_test_status = 1 where `status` = 1;