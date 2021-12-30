-- Kafka2.x预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('topic', 'topic名称', 0, 6, 37, 0, 1),
('partition_count', '分区数量', 0, 6, 37, 0, 2),
('replication', '副本量', 0, 6, 37, 0, 3),
('manager', '负责人', 1, 1, 37, 1, 1),
('topic_cn', 'topic中文名', 1, 2, 37, 1, 2);

-- Kafka0.10预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('topic', 'topic名称', 0, 6, 17, 0, 1),
('partition_count', '分区数量', 0, 6, 17, 0, 2),
('replication', '副本量', 0, 6, 17, 0, 3),
('manager', '负责人', 1, 1, 17, 1, 1),
('topic_cn', 'topic中文名', 1, 2, 17, 1, 2);


-- 已有租户初始化元模型(Kafka2.x)
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 37, 0, NULL, 'topic', 'topic名称', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 37 and attribute_name='topic');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 37, 0, NULL, 'partition_count', '分区数量', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 37 and attribute_name='partition_count');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 37, 0, NULL, 'replication', '副本量', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 37 and attribute_name='replication');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 37, 1, NULL, 'manager', '负责人', 1, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 37 and attribute_name='manager');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 37, 1, NULL, 'topic_cn', 'topic中文名', 2, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 37 and attribute_name='topic_cn');


-- 已有租户初始化元模型(Kafka0.10)
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 17, 0, NULL, 'topic', 'topic名称', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 17 and attribute_name='topic');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 17, 0, NULL, 'partition_count', '分区数量', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 17 and attribute_name='partition_count');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 17, 0, NULL, 'replication', '副本量', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 17 and attribute_name='replication');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 17, 1, NULL, 'manager', '负责人', 1, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 17 and attribute_name='manager');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 17, 1, NULL, 'topic_cn', 'topic中文名', 2, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 17 and attribute_name='topic_cn');

-- 第二批提测内容
-- 新增权限
insert into assets_permission(id,permission_code,permission_name,permission_display,parent_id,permission_type)
values
(700,'dataModel','数据模型','数据模型',1,1),
(701,'dataModel_createTable','数据模型_标准化建表','标准化建表',700,1),
(702,'dataModel_createTable_flink','数据模型_标准化建表_Flink表','Flink表',701,1),
(506,'platformMgr_dataAuthMgr','平台管理_数据权限管理','数据权限管理',500,1);

-- 新增用户角色权限关联
insert into assets_role_permission(role_id,permission_id)
select id, 700
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 701
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 702
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 506
from assets_role
where role_value in (1,2);

-- 更新角色描述信息
update assets_role
set role_desc = '具有资产盘点、元数据、数据资源和数据模型模块的部分权限'
where role_value = 3;

-- flink建表模块
-- flink表额外参数信息表
CREATE TABLE `assets_flink_table_param` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`table_id` bigint(20) NOT NULL COMMENT 'flink表id',
`db_id` bigint(20) NOT NULL COMMENT 'flink库id',
`source_id` bigint(20) NOT NULL COMMENT 'flink源id',
`mapping_source_id` bigint(20) NOT NULL COMMENT 'flink映射源id',
`mapping_db_id` bigint(20) NOT NULL COMMENT 'flink映射库id',
`mapping_table_id` bigint(20) NOT NULL COMMENT 'flink映射数据表id',
`mapping_source_type` int(11) NOT NULL COMMENT 'flink映射数据源类型',
`charset` varchar(100) DEFAULT NULL COMMENT '编码类型',
`sink_params` json DEFAULT NULL COMMENT '结果表参数 json字符串',
`source_params` json DEFAULT NULL COMMENT '源表参数 json字符串',
`side_params` json DEFAULT NULL COMMENT '维表参数 json字符串',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='flink表额外参数信息表';

-- 添加Flink表预设元模型
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 201, 0, 1),
('data_base', '数据库', 0, 6, 201, 0, 2),
('mapping_type', '映射数据源类型', 0, 6, 201, 0, 3),
('mapping_resource', '映射数据源', 0, 6, 201, 0, 4),
('mapping_table', '映射表(Topic)', 0, 6, 201, 0, 5),
('create_time', '创建时间', 0, 5, 201, 0, 6),
('manager', '负责人', 1, 1, 201, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 201, 1, 2);

-- 添加Flink字段预设元模型
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 201, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 201, 0, 2 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 201, 1, 3 ),
( 'key', 'flink源表结构key', 0, 6, 2, 201, 0, 4 );

-- 已有租户初始化元模型
-- Flink
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, NULL, 'mapping_type', '映射数据源类型', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='mapping_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, NULL, 'mapping_resource', '映射数据源', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='mapping_resource');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, NULL, 'mapping_table', '映射表(Topic)', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='mapping_table');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, NULL, 'create_time', '创建时间', 5, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name ='tb_name_cn');

-- 已有租户初始化字段元模型
-- Flink
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name='column_name_cn');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 201, 0, 2, NULL, 'key', 'flink源表结构key', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 201 and attribute_name='key');

-- 数据权限
-- 策略表
CREATE TABLE `assets_strategy` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
`strategy_name` varchar(255) NOT NULL COMMENT '策略名称',
`strategy_desc` varchar(255) DEFAULT '' COMMENT '策略描述',
`strategy_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0生效,1未生效',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略表';

-- 策略元数据关系表
CREATE TABLE `assets_strategy_data` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除,0未删除',
`tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
`strategy_id` bigint(20) NOT NULL COMMENT '策略id',
`data_source_type` bigint(20) NOT NULL COMMENT '数据源类型',
`meta_data_type` tinyint(1) NOT NULL COMMENT '元数据类型 0表示库,1表示表,2表示字段',
`meta_data_id` bigint(20) NOT NULL COMMENT '元数据id 数据库id/数据表id/字段id',
`meta_data_name` varchar(100) NOT NULL COMMENT '元数据名称',
`relation_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '关系类型,0选中,1排除',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略元数据关系表';

-- 策略用户关系表
CREATE TABLE `assets_strategy_user` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除,0未删除',
`tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
`strategy_id` bigint(20) NOT NULL COMMENT '策略id',
`user_id` bigint(20) NOT NULL COMMENT '用户id',
`permission_type` tinyint(1) NOT NULL COMMENT '权限类型 0表示可读权限、1表示读写权限',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略用户关系表';