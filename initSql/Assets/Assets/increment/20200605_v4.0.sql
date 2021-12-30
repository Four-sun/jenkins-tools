-- 数据源管理表->新增hive服务类型字段，新增版本号字段,数据源类型新增greeplum/tidb
ALTER TABLE `assets_data_source`
ADD COLUMN `hive_server_type` TINYINT(1) NULL COMMENT 'hive服务类型 1-Spark Thrift Server,2-Hive Server2' AFTER `data_source_type`,
ADD COLUMN `data_source_version` TINYINT(1) NULL COMMENT '数据源版本号 1-hive2.x(apache),2-hive2.x(cdh)' AFTER `data_source_type`,
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型 字典里 1-hive,2-hbase,3-mysql,4-oracle,5-es,6-ck,7-greenplum,31-tidb' ;

-- 表创建时间重命名
ALTER TABLE `assets_data_table`
  CHANGE COLUMN `hive_create_date` `table_create_at` DATETIME NULL DEFAULT NULL COMMENT '表创建时间';

-- 业务属性管理表->数据源类型新增tidb
ALTER TABLE `assets_model_attribute`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-hive,2-hbase,3-mysql,4-oracle,5-es,6-ck,7-greenplum,31-tidb' ;

-- 子模型管理表->数据源类型新增tidb
ALTER TABLE `assets_model_sub_management`
CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '元模型类型  1-hive,2-hbase,3-mysql,4-oracle,5-es,6-ck,7-greenplum,31-tidb' ;

-- 数据源字典表->新增数据源类型
INSERT INTO `assets_sys_dict` (`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `dict_type`, `dict_name`, `dict_value`, `dict_name_cn`, `dict_sort`)
VALUES
    (now(), now(), 0, 0, 0, 1, 'hive', 1, 'Hive', 1),
    (now(), now(), 0, 0, 0, 1, 'greenplum', 7, 'GreenPlum', 2);

-- 数据表批量管理表
CREATE TABLE `assets_data_table_batch_manage` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` INT(11) NOT NULL DEFAULT 0 COMMENT '创建的用户',
  `update_by` INT(11) NOT NULL DEFAULT 0 COMMENT '修改的用户',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除,1-删除,0-未删除',
  `data_table_id` BIGINT(20) NOT NULL COMMENT '数据表ID',
  `tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`))
  COMMENT = '数据表批量管理表';

-- 数据表批量管理表->新增数据源类型字段
ALTER TABLE `assets_data_table_batch_manage`
ADD COLUMN `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型 字典里 1-hive,2-hbase,3-mysql,4-oracle,5-es,6-ck,7-greenplum' AFTER `is_deleted`;

-- 数据源表->更新连接状态字段注释
ALTER TABLE `assets_data_source`
CHANGE COLUMN `link_status` `link_status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0-连接失败,1-连接成功,2-同步中,3-初始化' ;

-- 数据表表->新增schemaName字段
ALTER TABLE `assets_data_table`
ADD COLUMN `schema_name` VARCHAR(100) NULL COMMENT 'GP数据源的结构为database-schema-table' AFTER `db_id`;

-- 业务属性管理表->更新字段类型注释
ALTER TABLE `assets_model_attribute`
CHANGE COLUMN `field_type` `field_type` TINYINT(1) NULL DEFAULT NULL COMMENT '字段属性,1-枚举,2-string类型文本,3-树形目录,4-bigint文本框,5-日期类型,6-varchar类型,7-存储大小' ;


-- 字段名称语义化
ALTER TABLE `assets_data_table_partition`
	CHANGE COLUMN `total_size` `partition_size` BIGINT(20) NULL DEFAULT NULL COMMENT '分区大小,单位byte';

-- 分区表信息字段添加
ALTER TABLE `assets_data_table_partition`
	ADD COLUMN `partition_create_time` DATETIME NULL DEFAULT NULL COMMENT '分区创建时间',
	ADD COLUMN `partition_update_time` DATETIME NULL DEFAULT NULL COMMENT '分区更新时间',
	ADD COLUMN `row_count` BIGINT(20) NOT NULL COMMENT '分区数据行数';

-- 初始化已有租户的TiDB元模型	
-- 技术属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, NULL, 'row_count', '表行数', 4, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='row_count');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, NULL, 'create_time', '创建时间', 5, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, NULL, 'total_size', '存储大小', 7, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='total_size');

-- 通用属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name ='tb_name_cn');

-- 已有的hive源版本类型统一改为cdh2
update assets_data_source set data_source_version = 2 where data_source_type =1 and data_source_version is null;