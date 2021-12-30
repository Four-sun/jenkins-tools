-- 添加角色模版
insert into assets_role(tenant_id, role_name, role_type, role_value, role_desc)
VALUES(-1, '租户管理员', 1, 5, '具有产品内所有功能权限');

-- 已有租户添加租户管理员角色
insert into assets_role(tenant_id, role_name, role_type, role_value, role_desc)
select id,
       '租户管理员',
       1,
       5,
       '具有产品内所有功能权限'
from assets_tenant
where is_deleted = 0;

-- 角色权限关联
insert into assets_role_permission(role_id, permission_id)
select t1.id as role_id, t2.id as permission_id
from assets_role t1, assets_permission t2
where t1.role_value = 5 and t2.id != 601;

-- SparkThrift预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 45, 0, 1),
('data_base', '数据库', 0, 6, 45, 0, 2),
('create_time', '表创建时间', 0, 5, 45, 0, 3),
('ddl_update_time', 'DDL最后变更时间', 0, 5, 45, 0, 4),
('storage_location', '存储位置', 0, 6, 45, 0, 5),
('storage_size', '存储大小', 0, 7, 45, 0, 6),
('recent_sync_time', '最近同步时间', 0, 5, 45, 0, 7),
('manager', '负责人', 1, 1, 45, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 45, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 45, 0, 3);

-- 字段预设模型属性
-- SparkThrift
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 45, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 45, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 45, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 45, 1, 1 );

-- 初始化已有租户的SparkThrift元模型
-- 技术属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'create_time', '表创建时间', 5, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'ddl_update_time', 'DDL最后变更时间', 5, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='ddl_update_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'storage_location', '存储位置', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='storage_location');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'storage_size', '存储大小', 7, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='storage_size');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, NULL, 'recent_sync_time', '最近同步时间', 5, 0, 1, 7,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='recent_sync_time');

-- 已有租户初始化字段元模型
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='tb_name_cn');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 1, NULL, 'partition_life', '分区保留策略', 4, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name ='partition_life');

-- 已有租户初始化字段元模型
-- SparkThrift
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, 2, NULL, 'column_name', '字段名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='column_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, 2, NULL, 'data_type', '数据类型', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='data_type');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, 2, NULL, 'column_comment', '注释', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='column_comment');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 1, 2, NULL, 'column_name_cn', '字段中文名', 2, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='column_name_cn');
