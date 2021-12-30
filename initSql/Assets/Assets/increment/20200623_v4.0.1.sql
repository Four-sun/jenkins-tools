
-- 和com.dtstack.dtcenter.common.enums.DataSourceType数据源枚举值一致
update assets_model_attribute set data_source_type = 7 where data_source_type = 1;
update assets_data_source set data_source_type = 7 where data_source_type = 1;
update assets_check_record set data_source_type = 7 where data_source_type = 1;
update assets_model_sub_management set data_source_type = 7 where data_source_type = 1;
update assets_data_table_batch_manage set data_source_type = 7 where data_source_type = 1;

ALTER TABLE `assets_model_attribute`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB';

ALTER TABLE `assets_data_source`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB';

ALTER TABLE `assets_check_record`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB';

ALTER TABLE `assets_model_sub_management`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB';

ALTER TABLE `assets_data_table_batch_manage`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB';

-- 预设模型属性表
CREATE TABLE `assets_preset_model_attribute` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`attribute_name` VARCHAR(100) NOT NULL COMMENT '元模型中 属性名',
	`attribute_name_cn` VARCHAR(100) NOT NULL COMMENT '元模型中 属性中文名',
	`attribute_type` TINYINT(1) NOT NULL COMMENT '元模型属性类型,0表示技术属性 1表示`通用业务属性`,2表示`个性业务属性`',
	`field_type` TINYINT(1) NOT NULL COMMENT '字段属性,1-枚举,2-string类型文本,3-树形目录,4-bigint文本框,5-日期类型,6-varchar类型,7-存储大小',
	`data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
	`is_required` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否必填项，0非必填，1必填',
	`sort_order` TINYINT(1) NOT NULL COMMENT '排序字段',
	PRIMARY KEY (`id`),
	INDEX `idx_sourcetype` (`data_source_type`) USING BTREE,
	INDEX `idx_attributetype` (`attribute_type`) USING BTREE
)
COMMENT='预设模型属性'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
ROW_FORMAT=DYNAMIC
;

-- 插入预设模型属性数据
-- Mysql预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 1, 0, 1),
('data_base', '数据库', 0, 6, 1, 0, 2),
('engine', '引擎', 0, 6, 1, 0, 4),
('row_format', '行格式', 0, 6, 1, 0, 5),
('row_count', '表行数', 0, 6, 1, 0, 6),
('total_size', '存储大小', 0, 7, 1, 0, 7),
('create_time', '创建时间', 0, 5, 1, 0, 8),
('manager', '负责人', 1, 1, 1, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 1, 1, 2);
-- Oracle预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 2, 0, 1),
('data_base', '数据库', 0, 6, 2, 0, 2),
('row_count', '表行数', 0, 6, 2, 0, 4),
('total_size', '存储大小', 0, 7, 2, 0, 5),
('create_time', '创建时间', 0, 5, 2, 0, 6),
('manager', '负责人', 1, 1, 2, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 2, 1, 2);
-- Hive预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('data_base', '数据库', 0, 6, 7, 0, 1),
('create_time', '表创建时间', 0, 5, 7, 0, 2),
('ddl_update_time', 'DDL最后变更时间', 0, 5, 7, 0, 3),
('storage_location', '存储位置', 0, 6, 7, 0, 4),
('storage_size', '存储大小', 0, 7, 7, 0, 5),
('manager', '负责人', 1, 1, 7, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 7, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 7, 0, 3);
-- TiDB预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 31, 0, 1),
('data_base', '数据库', 0, 6, 31, 0, 2),
('row_count', '表行数', 0, 6, 31, 0, 3),
('create_time', '创建时间', 0, 5, 31, 0, 4),
('total_size', '存储大小', 0, 6, 31, 0, 5),
('manager', '负责人', 1, 1, 31, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 31, 1, 2);


-- 已有租户元模型属性处理
-- mysql技术属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'engine', '引擎', 6, 0, 1, 4,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='engine');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'row_format', '行格式', 6, 0, 1, 5,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='row_format');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'row_count', '表行数', 6, 0, 1, 6,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='row_count');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'total_size', '存储大小', 7, 0, 1, 7,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='total_size');


INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, NULL, 'create_time', '创建时间', 5, 0, 1, 8,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='create_time');

-- mysql通用属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name ='tb_name_cn');

-- Oracle技术属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, NULL, 'row_count', '表行数', 6, 0, 1, 4,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='row_count');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, NULL, 'total_size', '存储大小', 7, 0, 1, 5,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='total_size');


INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, NULL, 'create_time', '创建时间', 5, 0, 1, 6,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='create_time');

-- Oracle通用属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in
(select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name ='tb_name_cn');

-- 表索引表
CREATE TABLE `assets_data_table_index` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` INT(11) NOT NULL DEFAULT 0 COMMENT '创建的用户',
  `update_by` INT(11) NOT NULL DEFAULT 0 COMMENT '修改的用户',
  `index_name` VARCHAR (100) NULL COMMENT '索引名称',
  `column_name` VARCHAR (100) NULL COMMENT '索引列名',
  `index_type` VARCHAR (100) NULL COMMENT '索引类型',
  `comment` VARCHAR (100) NULL COMMENT '索引注释',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除,1-删除,0-未删除',
  `db_id` BIGINT (20) NULL COMMENT '数据库id',
  `table_id` BIGINT (20) NULL COMMENT '表id',
  `data_source_id` BIGINT(20) NOT NULL COMMENT '应数据源id',
  `tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
  PRIMARY KEY (`id`)
  )COMMENT = '索引表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `assets_data_table_index`
  ADD INDEX `idx_table_id` (`table_id`) USING BTREE;
-- 数据库批量管理表
CREATE TABLE `assets_data_db_batch_manage` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` INT(11) NOT NULL DEFAULT 0 COMMENT '创建的用户',
  `update_by` INT(11) NOT NULL DEFAULT 0 COMMENT '修改的用户',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除,1-删除,0-未删除',
  `db_id` BIGINT(20) NOT NULL COMMENT '数据库ID',
  `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
  `tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`))
  COMMENT = '数据库批量管理表';


-- permission update
-- 1. 将新权限元数据导出插入到权限表中
-- id= 63, permission_code= 'metaDataMgr_export'，permission_name= '元数据管理_元数据导出', permission_display= '元模型管理'
insert into assets_permission(id, create_at, update_at, create_by, update_by, is_deleted, permission_code,
                              permission_name, permission_display, parent_id, permission_type)
values (24,now(),now(),0,0,0,'dmap_center_batchMgr_clean','数据地图_元数据中心_批量管理_清空','批量管理清空',23,1),
       (25,now(),now(),0,0,0,'dmap_center_batchMgr_edit','数据地图_元数据中心_批量管理_编辑','批量管理编辑',23,1),
       (63, now(), now(), 0, 0, 0, 'metaDataMgr_metaDataExport', '元数据管理_元数据导出', '元数据导出', 60, 1);
-- 2. 给所有已存在的数据（租户管理员、元数据管理员和数据开发角色）补全权限
-- permission_id= 63
insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 63
from assets_role r
where role_value in (1, 2, 3);
insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 24
from assets_role r
where role_value in (1, 2, 3);
insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 25
from assets_role r
where role_value in (1, 2);
-- 23-批量管理
insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 23
from assets_role r
where role_value in (3);
-- 修改用色描述信息
update assets_role set role_desc = '负责元数据管理、负责人分配、元数据编辑/导出'
where role_value = 2;
update assets_role set role_desc = '查询/导出元数据、维护自己负责的元数据' where role_value = 3;
-- sql optimize
create index idx_ck_1
	on assets_data_table (is_deleted, tenant_id, sync_status, data_source_id);
create index idx_ck_1
    on assets_data_table_column (is_deleted, tenant_id);
create index idx_ck_1
    on assets_data_db (is_deleted, tenant_id, data_source_id);
create index idx_tenant_id
    on assets_data_source (tenant_id);

-- 库、表、字段名称搜索大小写敏感
ALTER TABLE `assets_data_table`
	CHANGE COLUMN `table_name` `table_name` VARCHAR(100) NOT NULL COMMENT '表名称' COLLATE 'utf8_bin';

ALTER TABLE `assets_data_table`
	CHANGE COLUMN `table_name_cn` `table_name_cn` VARCHAR(100) NULL DEFAULT NULL COMMENT '表中文名' COLLATE 'utf8_bin';

ALTER TABLE `assets_data_table_column`
	CHANGE COLUMN `column_name` `column_name` VARCHAR(100) NOT NULL COMMENT '名称' COLLATE 'utf8_bin';

ALTER TABLE `assets_data_table_column`
	CHANGE COLUMN `column_name_cn` `column_name_cn` VARCHAR(100) NULL DEFAULT NULL COMMENT '中文名称' COLLATE 'utf8_bin';

ALTER TABLE `assets_data_db`
	CHANGE COLUMN `db_name` `db_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '数据库名称' COLLATE 'utf8_bin';

ALTER TABLE `assets_data_db`
	CHANGE COLUMN `db_name_cn` `db_name_cn` VARCHAR(100) NULL DEFAULT NULL COMMENT '数据库中文名' COLLATE 'utf8_bin';



-- assets_sync_job jobId添加唯一索引
-- 先删除脏数据
DELETE FROM assets_sync_job WHERE job_id
IN (SELECT job_id FROM (SELECT job_id FROM  assets_sync_job GROUP BY job_id HAVING count(*) > 1) AS a);

ALTER TABLE `assets_sync_job`
  ADD UNIQUE INDEX `uk_job_id` (`job_id`) USING BTREE;