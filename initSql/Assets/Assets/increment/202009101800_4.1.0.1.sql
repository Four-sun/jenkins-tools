ALTER TABLE `assets_model_attribute`
    ADD COLUMN `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 0-表 1-字段' AFTER `attribute_type`;

ALTER TABLE `assets_model_sub_management`
    ADD COLUMN `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 0-表 1-字段' AFTER `data_source_type`;

ALTER TABLE `assets_preset_model_attribute`
    ADD COLUMN `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 1-表 2字段' AFTER `field_type`;

ALTER TABLE `assets_data_table_column`
    ADD COLUMN `col_sub_model_id` bigint(20) NULL COMMENT '字段元模型ID' AFTER `sub_model_id`;

ALTER TABLE `assets_data_db`
    ADD COLUMN `col_sub_model_id` bigint(20) NULL COMMENT '字段元模型ID' AFTER `sub_model_id`;

UPDATE assets_data_table SET extra_attribute = REPLACE(extra_attribute,'filed','field') WHERE extra_attribute LIKE '%filed%';

CREATE TABLE `assets_model_column_attribute` (
   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
   `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
   `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
   `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
   `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
   `table_id` bigint(20) DEFAULT NULL COMMENT '表ID',
   `column_id` bigint(20) NOT NULL COMMENT '字段ID',
   `field_type` tinyint(1) NOT NULL COMMENT '字段类型',
   `attribute_id` bigint(20) NOT NULL COMMENT '属性ID',
   `attribute_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性名称',
   `attribute_name_cn` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '属性中文名',
   `attribute_type` tinyint(1) NOT NULL COMMENT '属性类型 0技术1通用2个性',
   `attribute_value` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性值',
   `attribute_value_id` bigint(20) DEFAULT NULL COMMENT '属性值ID（枚举、树形目录）',
   `attribute_value_display` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性值（文本）',
   `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='字段属性表';

-- 新增索引
ALTER TABLE `assets_model_column_attribute`
    ADD INDEX `idx_column_id` (`column_id`) USING BTREE;

-- Hive2
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 7, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 7, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 7, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 7, 1, 1 );
-- Hive1
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 27, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 27, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 27, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 27, 1, 1 );
-- MySQL
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 1, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 1, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 1, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 1, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 1, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 1, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 1, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 1, 1, 1 );
-- Oracle
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 2, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 2, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 2, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 2, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 2, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 2, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 2, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 2, 1, 1 );
-- SQL Server
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 3, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 3, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 3, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 3, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 3, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 3, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 3, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 3, 1, 1 );
-- TiDB
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 31, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 31, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 31, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 31, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 31, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 31, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 31, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 31, 1, 1 );

-- 增加同步时间
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 9,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='recent_sync_time');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='recent_sync_time');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='recent_sync_time');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name ='recent_sync_time');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='recent_sync_time');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='recent_sync_time');

-- 角色权限变动
-- 新增模块权限
insert into assets_permission(id,permission_code,permission_name,permission_display,parent_id,permission_type)
values
(100,'inventory','资产盘点','资产盘点',1,1),
(42,'myData_managedTable_managerEdit','我的数据_元数据管理_管理的表_负责人编辑','负责人编辑',41,1),
(43,'myData_dataResourceManager','我的数据_数据资源管理','数据资源管理',40,1),
(64,'metaDataMgr_resourceDirectoryMgr','数据管理_资源目录管理','资源目录管理',60,1),
(120,'dataResource','数据资源','数据资源',1,1),
(140,'indexLocation','首页定位','首页定位',1,1),
(141,'indexLocation_index2dataResource','首页定位_至数据资源','至数据资源',140,1),
(142,'indexLocation_index2dmap','首页定位_至数据地图','至数据地图',140,1);

-- 模块权限名修改
-- 管理的表更名
update assets_permission
set permission_name = '我的数据_元数据管理',
	permission_display = '元数据管理'
	where id = 41;
-- 元数据管理更名
update assets_permission
set permission_name = '数据管理',
	permission_display = '数据管理'
	where id = 60;

update assets_permission
set permission_name = '数据管理_数据源管理'
	where id = 61;
update assets_permission
set permission_name = '数据管理_元模型管理'
	where id = 62;
update assets_permission
set permission_name = '数据管理_元数据导出'
	where id = 63;

-- 租户管理者和管理员权限变动
insert into assets_role_permission(role_id,permission_id)
select
	id,
	100
	from assets_role
	where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select
	id,
	42
	from assets_role
	where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select
	id,
	43
	from assets_role
	where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select
	id,
	64
	from assets_role
	where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select
	id,
	120
	from assets_role
	where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select
	id,
	140
	from assets_role
	where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select
	id,
	141
	from assets_role
	where role_value = 4;

insert into assets_role_permission(role_id,permission_id)
select
	id,
	142
	from assets_role
	where role_value in (1,2,3);

-- 管理员新增旧权限
insert into assets_role_permission(role_id, permission_id)
select
	id,
	40
	from assets_role
	where role_value = 2;

insert into assets_role_permission(role_id, permission_id)
select
	id,
	41
	from assets_role
	where role_value = 2;

insert into assets_role_permission(role_id, permission_id)
select
	id,
	80
	from assets_role
	where role_value = 2;

insert into assets_role_permission(role_id, permission_id)
select
	id,
	81
	from assets_role
	where role_value = 2;

-- 访客权限变动
-- 删除数据地图访问权限
update assets_role_permission
set is_deleted = 1
where permission_id in(20,21,22) and role_id in
(
	select id
	from assets_role
	where role_value = 4
);

-- 角色变更
update assets_role
set role_name = '管理员',
	role_desc = '具有产品内所有功能权限'
	where role_value = 2;

update assets_role
set role_desc = '具有维护/查询元数据、数据资源的功能权限'
	where role_value = 3;

update assets_role
set role_desc = '具有数据资源的查询权限'
	where role_value = 4;


-- 已有租户初始化字段元模型
-- Hive2
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='column_name_cn');

-- Hive1
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='column_name_cn');

-- MySQL
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'data_length', '字段最大长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='data_length');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'column_key', '主键标识Y/N', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='column_key');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'is_nullable', '可空标识Y/N', 6, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='is_nullable');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'column_default', '默认值', 6, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='column_default');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='column_name_cn');

-- Oracle
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'data_length', '字段最大长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='data_length');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'column_key', '主键标识Y/N', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='column_key');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'is_nullable', '可空标识Y/N', 6, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='is_nullable');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'column_default', '默认值', 6, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='column_default');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='column_name_cn');

-- SQL Server
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'data_length', '字段最大长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='data_length');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'column_key', '主键标识Y/N', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='column_key');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'is_nullable', '可空标识Y/N', 6, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='is_nullable');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'column_default', '默认值', 6, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='column_default');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='column_name_cn');

-- TiDB
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'data_length', '字段最大长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='data_length');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'column_key', '主键标识Y/N', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='column_key');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'is_nullable', '可空标识Y/N', 6, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='is_nullable');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'column_default', '默认值', 6, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='column_default');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='column_name_cn');
-- 已有租户更新MySQL顺序
UPDATE assets_model_attribute SET sort_order = 3 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'engine';
UPDATE assets_model_attribute SET sort_order = 4 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'row_format';
UPDATE assets_model_attribute SET sort_order = 5 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'row_count';
UPDATE assets_model_attribute SET sort_order = 6 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'total_size';
UPDATE assets_model_attribute SET sort_order = 7 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'create_time';

-- 预设属性更新MySQL顺序
UPDATE assets_preset_model_attribute SET sort_order = 3 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'engine';
UPDATE assets_preset_model_attribute SET sort_order = 4 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'row_format';
UPDATE assets_preset_model_attribute SET sort_order = 5 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'row_count';
UPDATE assets_preset_model_attribute SET sort_order = 6 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'total_size';
UPDATE assets_preset_model_attribute SET sort_order = 7 WHERE data_source_type = 1 AND meta_data_type = 1 AND attribute_type = 0 AND attribute_name = 'create_time';


-- 预设属性添加最近同步时间
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'recent_sync_time', '最近同步时间', 0, 5, 1, 2, 0, 7 );
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'recent_sync_time', '最近同步时间', 0, 5, 1, 3, 0, 7 );
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'recent_sync_time', '最近同步时间', 0, 5, 1, 7, 0, 7 );
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'recent_sync_time', '最近同步时间', 0, 5, 1, 27, 0, 7 );
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'recent_sync_time', '最近同步时间', 0, 5, 1, 31, 0, 6 );
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'recent_sync_time', '最近同步时间', 0, 5, 1, 1, 0, 8 );

-- 数据价值排行更新元数据类型 与metaDataType保持一致
ALTER TABLE `assets_data_value_rank`
    CHANGE COLUMN `obj_type` `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 1-表 2-字段' AFTER `column_id`;
UPDATE assets_data_value_rank
SET meta_data_type = 2
WHERE
        meta_data_type = 1;
UPDATE assets_data_value_rank
SET meta_data_type = 1
WHERE
        meta_data_type = 0;

-- 字段类型增大长度以容纳Hive的自定义数据结构
ALTER TABLE `assets_data_table_column`
    MODIFY COLUMN `column_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段类型' AFTER `column_desc`;
