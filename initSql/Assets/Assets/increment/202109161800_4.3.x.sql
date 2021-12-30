-- 数据源同步任务全局配置
CREATE TABLE `assets_sync_config_global` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `data_source_id` bigint(20) NOT NULL COMMENT '对应数据源id',
  `config` text COMMENT '对应数据源全局配置json',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据源同步任务全局配置';

-- 新增字段预设属性
-- Hive1
INSERT INTO `assets_preset_model_attribute`
( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'precision', '数据精度', 0, 6, 0, 27, 0, 3 ),
( 'digital', '小数点后长度', 0, 6, 0, 27, 0, 4 );
-- Hive2
INSERT INTO `assets_preset_model_attribute`
( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'precision', '数据精度', 0, 6, 0, 7, 0, 3 ),
( 'digital', '小数点后长度', 0, 6, 0, 7, 0, 4 );

-- Mysql
INSERT INTO `assets_preset_model_attribute`
( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'precision', '数据精度', 0, 6, 0, 1, 0, 3 ),
( 'digital', '小数点后长度', 0, 6, 0, 1, 0, 4 );

-- Oracle
INSERT INTO `assets_preset_model_attribute`
( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'precision', '数据精度', 0, 6, 0, 2, 0, 3 ),
( 'digital', '小数点后长度', 0, 6, 0, 2, 0, 4 );

-- SQLServer
INSERT INTO `assets_preset_model_attribute`
( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'precision', '数据精度', 0, 6, 0, 3, 0, 3 ),
( 'digital', '小数点后长度', 0, 6, 0, 3, 0, 4 );

-- TiDB
INSERT INTO `assets_preset_model_attribute`
( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'precision', '数据精度', 0, 6, 0, 31, 0, 3 ),
( 'digital', '小数点后长度', 0, 6, 0, 31, 0, 4 );

-- 已有租户字段属性处理
-- Hive1
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, 2, NULL, 'precision', '数据精度', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='precision');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, 2, NULL, 'digital', '小数点后长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='digital');

-- Hive2
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, 2, NULL, 'precision', '数据精度', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='precision');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, 2, NULL, 'digital', '小数点后长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='digital');

-- Mysql
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'precision', '数据精度', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='precision');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 1, 0, 2, NULL, 'digital', '小数点后长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 1 and attribute_name='digital');

-- Oracle
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'precision', '数据精度', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='precision');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 2, 0, 2, NULL, 'digital', '小数点后长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 2 and attribute_name='digital');

-- SQLServer
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'precision', '数据精度', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='precision');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 3, 0, 2, NULL, 'digital', '小数点后长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 3 and attribute_name='digital');

-- TiDB
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'precision', '数据精度', 6, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='precision');
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 31, 0, 2, NULL, 'digital', '小数点后长度', 6, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 31 and attribute_name='digital');


-- 插入预设模型新属性“存储格式”
-- 插入的数据源按data_source_type从小到大如下
-- Hive2, Hive1, SparkThrift
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('store_type', '存储格式', 0, 6, 7, 0, 1),
('store_type', '存储格式', 0, 6, 27, 0, 1),
('store_type', '存储格式', 0, 6, 45, 0, 1);

-- 已有租户初始化元模型中“存储格式”
-- Hive2
INSERT INTO `assets_model_attribute`(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 7, 0, 1, NULL, 'store_type', '存储格式', 6, 0, 1, 1, id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 7 and attribute_name='store_type');

-- Hive1
INSERT INTO `assets_model_attribute`(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, 1, NULL, 'store_type', '存储格式', 6, 0, 1, 1, id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='store_type');

-- SparkThrift
INSERT INTO `assets_model_attribute`(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `meta_data_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 45, 0, 1, NULL, 'store_type', '存储格式', 6, 0, 1, 1, id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 45 and attribute_name='store_type');

-- 删除预设属性中 分区保留策略属性 此表无is_deleted字段
DELETE FROM assets_preset_model_attribute WHERE attribute_name = "partition_life";
-- 删除已有属性 分区保留策略属性
UPDATE assets_model_attribute SET is_deleted = 1 WHERE attribute_name = "partition_life";

-- 删除分区保留策略相关定时任务
DELETE FROM qrtz_cron_triggers WHERE TRIGGER_NAME = 'dropHivePartitionTrigger';
DELETE FROM qrtz_fired_triggers WHERE TRIGGER_NAME = 'dropHivePartitionTrigger';
DELETE FROM qrtz_triggers WHERE TRIGGER_NAME = 'dropHivePartitionTrigger';
DELETE FROM qrtz_job_details WHERE JOB_NAME = 'dropHivePartitionJob';
DELETE FROM dt_center_cron_schedule WHERE job_detail_name = 'dropHivePartitionJob';


-- 删除索引
DROP PROCEDURE IF EXISTS sp_dropindex;
DELIMITER //
CREATE PROCEDURE sp_dropindex
(
   IN    databasename             VARCHAR(50)   ,
   IN    tablename                VARCHAR(50)   ,
   IN    indexname                VARCHAR(50)
)
proc:BEGIN
    DECLARE   str       VARCHAR(512)  DEFAULT NULL;
    DECLARE   cnt       INT           DEFAULT 0;
    SET @str = CONCAT(' drop index ',indexname,' on ',databasename,'.',tablename);

    SELECT COUNT(*) INTO cnt FROM information_schema.statistics
        WHERE TABLE_SCHEMA=databasename AND TABLE_NAME=tablename
        AND INDEX_NAME=indexname;

    IF cnt > 0 THEN
    PREPARE stmt FROM @str;
    EXECUTE stmt;
    END IF;
    LEAVE proc;
END
//
DELIMITER ;

CALL sp_dropindex('assets','assets_tenant','index_tenant_name');