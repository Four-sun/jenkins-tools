-- Phoenix预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 38, 0, 1),
('namespace', '命名空间', 0, 6, 38, 0, 2),
('create_time', '表创建时间', 0, 5, 38, 0, 3),
('storage_size', '存储大小', 0, 7, 38, 0, 4),
('recent_sync_time', '最近同步时间', 0, 5, 38, 0, 5),
('manager', '负责人', 1, 1, 38, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 38, 1, 2);

-- Phoenix预设字段模型属性
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 38, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 38, 0, 2 ),
( 'is_primary_key', '是否主键', 0, 6, 2, 38, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 38, 1, 1 );

-- 已有租户初始化元模型
-- Phoenix
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, NULL, 'namespace', '命名空间', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name ='namespace');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, NULL, 'create_time', '表创建时间', 5, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, NULL, 'storage_size', '存储大小', 7, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name ='storage_size');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name ='recent_sync_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name ='tb_name_cn');

-- 已有租户初始化字段元模型
-- Phoenix
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 0, 2, NULL, 'is_primary_key', '是否主键', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name='is_primary_key');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 38, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 38 and attribute_name='column_name_cn');


-- HBase1预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 8, 0, 1),
('namespace', '命名空间', 0, 6, 8, 0, 2),
('create_time', '表创建时间', 0, 5, 8, 0, 3),
('region_count', 'region数量', 0, 6, 8, 0, 4),
('storage_size', '存储大小', 0, 7, 8, 0, 5),
('recent_sync_time', '最近同步时间', 0, 5, 8, 0, 6),
('manager', '负责人', 1, 1, 8, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 8, 1, 2);

-- HBase1预设字段模型属性
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_family', '列族', 0, 6, 2, 8, 0, 1 ),
( 'column_family_cn', '列族中文名', 1, 2, 2, 8, 1, 1 );

-- 已有租户初始化元模型
-- HBase1
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, NULL, 'namespace', '命名空间', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='namespace');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, NULL, 'create_time', '表创建时间', 5, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, NULL, 'region_count', 'region数量', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='region_count');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, NULL, 'storage_size', '存储大小', 7, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='storage_size');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='recent_sync_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name ='tb_name_cn');

-- 已有租户初始化字段元模型
-- HBase1
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 0, 2, NULL, 'column_family', '列族', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name='column_family');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 8, 1, 2, NULL, 'column_family_cn', '列族中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 8 and attribute_name='column_family_cn');



-- Vertica预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 43, 0, 1),
('data_base', '数据库', 0, 6, 43, 0, 2),
('create_time', '表创建时间', 0, 5, 43, 0, 3),
('storage_size', '存储大小', 0, 7, 43, 0, 4),
('recent_sync_time', '最近同步时间', 0, 5, 43, 0, 5),
('manager', '负责人', 1, 1, 43, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 43, 1, 2);

-- Vertica预设字段模型属性
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 43, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 43, 0, 2 ),
( 'is_nullable', '是否可空', 0, 6, 2, 43, 0, 3 ),
( 'column_default', '默认值', 0, 6, 2, 43, 0, 4 ),
( 'column_comment', '字段注释', 0, 6, 2, 43, 0, 5 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 43, 1, 1 );

-- 已有租户初始化元模型
-- Vertica
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name ='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, NULL, 'create_time', '表创建时间', 5, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, NULL, 'storage_size', '存储大小', 7, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name ='storage_size');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name ='recent_sync_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name ='tb_name_cn');

-- 已有租户初始化字段元模型
-- Vertica
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, 2, NULL, 'is_nullable', '是否可空', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='is_nullable');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, 2, NULL, 'column_default', '默认值', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='column_default');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 0, 2, NULL, 'column_comment', '字段注释', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 43, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 43 and attribute_name='column_name_cn');


ALTER TABLE `assets_data_table_column`
    MODIFY COLUMN `column_type` varchar(255) NOT NULL DEFAULT '' COMMENT '字段类型';

CREATE TABLE `assets_external_data_source` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '创建人',
	`update_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '更新人',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
	`data_source_id` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '数据源',
	`external_data_source_id` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '外部数据源id',
	`app_type` TINYINT(1) NOT NULL COMMENT '应用id',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	PRIMARY KEY (`id`)
) COMMENT '外部数据源关联表' ENGINE=InnoDB DEFAULT CHARSET=utf8;