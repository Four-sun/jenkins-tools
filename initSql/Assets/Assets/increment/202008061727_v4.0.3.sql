-- 预设模型
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 3, 0, 1),
('data_base', '数据库', 0, 6, 3, 0, 2),
('table_schema', '表架构', 0, 6, 3, 0, 3),
('row_count', '表行数', 0, 6, 3, 0, 4),
('total_size', '存储大小', 0, 7, 3, 0, 5),
('create_time', '创建时间', 0, 5, 3, 0, 6),
('manager', '负责人', 1, 1, 3, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 3, 1, 2);

-- 初始化已有租户的SQL Server元模型
-- 技术属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'table_schema', '表架构', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='table_schema');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'row_count', '表行数', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='row_count');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'total_size', '存储大小', 7, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='total_size');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, NULL, 'create_time', '创建时间', 5, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='create_time');

-- 通用属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name ='tb_name_cn');

-- 表添加SQL Server数据源注释
ALTER TABLE `assets_model_attribute`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SqlServer';

ALTER TABLE `assets_data_source`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SqlServer';

ALTER TABLE `assets_check_record`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SqlServer';

ALTER TABLE `assets_model_sub_management`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SqlServer';

ALTER TABLE `assets_data_table_batch_manage`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SqlServer';

ALTER TABLE `assets_preset_model_attribute`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SqlServer';

-- 分区表新增文件组名称字段
ALTER TABLE assets_data_table_partition ADD `file_group_name` varchar(100) DEFAULT NULL COMMENT '文件组名称' AFTER `part_name`;


-- 解决预设模型和子模型 field_type类型不正常问题
UPDATE assets_preset_model_attribute SET field_type = 6  WHERE attribute_name = 'row_count';
UPDATE assets_preset_model_attribute  SET field_type = 5  WHERE attribute_name = 'create_time';
UPDATE assets_model_attribute SET field_type = 6 WHERE attribute_name = 'row_count';
UPDATE assets_model_attribute  SET field_type = 5  WHERE attribute_name = 'create_time';

-- SQL Server统计添加schema_count
ALTER TABLE assets_data_db ADD COLUMN `schema_count` bigint(20) NULL DEFAULT '0' COMMENT 'SQL Server架构数量' AFTER table_count;

-- 用户邮箱可以为空
ALTER TABLE `assets_user` CHANGE COLUMN `user_email` `user_email` VARCHAR(100) NULL COMMENT '用户邮箱' AFTER `user_name`;