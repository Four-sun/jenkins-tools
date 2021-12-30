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



-- 项目表新增字段标识是否开启服务编排，默认不开启
alter table da_project add column open_orchestration int(2) not null default 0 COMMENT '开启服务编排';


alter table da_api add column orchestration_flow text null COMMENT '服务编排执行流程';

alter table da_api_test add column orchestration_flow text null COMMENT '服务编排执行流程';


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

insert into da_api_source_ref (tenant_id, project_id, api_id,source_id,source_type)
select tenant_id,project_id ,id, data_src_id,data_src_type from da_api where is_deleted = 0 and data_src_id is not null;

insert into da_api_source_ref_test (tenant_id, project_id, api_id,source_id,source_type)
select tenant_id,project_id ,id, data_src_id,data_src_type from da_api_test where is_deleted = 0 and data_src_id is not null;


-- 添加且修改权限点
update da_permission set code = 'api_manager_api_query',name='API管理_API_查看',parent_id = 103 where id = 54;
update da_permission set code = 'api_manager_api_edit',name='API管理_API_编辑',parent_id = 103 where id = 56;
update da_permission set code = 'api_manager_api_menu',name='API管理_API_菜单',parent_id = 103 where id = 88;


INSERT INTO `da_permission` VALUES ('103', 'api_manager_api', 'API管理_API', 'API', '52', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('105', 'api_manager_function', 'API管理_函数', '函数', '52', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('106', 'api_manager_function_query', 'API管理_函数_查看', '查看', '105', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('107', 'api_manager_function_edit', 'API管理_函数_编辑', '编辑', '105', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('108', 'api_manager_function_menu', 'API管理_函数_菜单', '菜单', '105', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');


-- 增量sql
-- 给数据开发及以上的角色赋予权限
DROP PROCEDURE IF EXISTS pr_increment_role_permission_20210128;

delimiter //

create procedure pr_increment_role_permission_20210128()
BEGIN
DECLARE roleId INT;
DECLARE stop INT DEFAULT 0;
DECLARE cur CURSOR FOR (select id from da_role where is_deleted=0 and role_value in (1,2,5,8,6,7));
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

OPEN cur;

    FETCH cur INTO roleId;
    WHILE ( stop is not null) DO
    INSERT INTO da_role_permission(role_id, permission_id) VALUES (roleId, 103),(roleId, 105),(roleId, 106),(roleId, 107),(roleId, 108);
    FETCH cur INTO roleId;
    END WHILE;

CLOSE cur;

END;//

delimiter ;

CALL pr_increment_role_permission_20210128();


alter table da_api_test add column page_test_status int(2) NOT NULL DEFAULT 0 COMMENT '页面测试状态: 0/1 未通过/通过';