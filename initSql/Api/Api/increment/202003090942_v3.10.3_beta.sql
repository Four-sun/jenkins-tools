alter table `da_api` add column `query_time_out` int(11) COMMENT 'api查询超时时间' AFTER `project_id`;
alter table `da_api` add column `test_status` int(11) NOT NULL DEFAULT '0' COMMENT 'da_api_test的api状态: 0:未提交/1:已提交' AFTER `query_time_out`;
alter table `da_api` add column `is_secondary_release` int(11) DEFAULT '0' COMMENT '二次发布' AFTER `test_status`;

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
  `original_host` varchar(45) DEFAULT NULL COMMENT '注册API的原始api host',
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
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `query_time_out` int(11) COMMENT 'api查询超时时间',
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

-- 将正式api信息同步到测试api中
INSERT INTO `da_api_test` (`id`,`cat_id`,`tenant_id`,`data_src_id`,`name`,`tableName`,`req_limit`,`resp_limit`,`api_type`,`status`,`api_desc`,`input_params`,`output_params`,`create_user_id`,`modify_user_id`,`gmt_create`,`gmt_modified`,`is_deleted`,`req_type`,`api_path`,`resp_page_size`,`param_cfg_type`,`allow_paging`,`config_sql`,`resp_json`,`data_src_type`,`original_host`,`original_path`,`original_method`,`error_code_list_json`,`error_resp_json`,`body_desc_json`,`api_version_code`,`wsdl_xml`,`save_wsdl_xml`,`protocol`,`contain_header`,`contain_page`,`project_id`,`query_time_out`)
SELECT `id`,`cat_id`,`tenant_id`,`data_src_id`,`name`,`tableName`,`req_limit`,`resp_limit`,`api_type`,IF (`status`=0,1,0),`api_desc`,`input_params`,`output_params`,`create_user_id`,`modify_user_id`,`gmt_create`,`gmt_modified`,`is_deleted`,`req_type`,`api_path`,`resp_page_size`,`param_cfg_type`,`allow_paging`,`config_sql`,`resp_json`,`data_src_type`,`original_host`,`original_path`,`original_method`,`error_code_list_json`,`error_resp_json`,`body_desc_json`,`api_version_code`,`wsdl_xml`,`save_wsdl_xml`,`protocol`,`contain_header`,`contain_page`,`project_id`,`query_time_out` FROM `da_api` WHERE `is_deleted`=0;

-- 更新da_api.test_status
UPDATE da_api
LEFT JOIN da_api_test ON da_api.id = da_api_test.id
SET da_api.test_status = da_api_test.status
WHERE da_api.is_deleted = 0 and da_api_test.is_deleted = 0