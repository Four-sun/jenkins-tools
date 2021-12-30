-- 表添加Hive1数据源注释
ALTER TABLE `assets_model_attribute`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,27-TiDB,27-Hive1';

ALTER TABLE `assets_data_source`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,27-TiDB,27-Hive1';

ALTER TABLE `assets_check_record`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,27-TiDB,27-Hive1';

ALTER TABLE `assets_model_sub_management`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,27-TiDB,27-Hive1';

ALTER TABLE `assets_data_table_batch_manage`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,27-TiDB,27-Hive1';

ALTER TABLE `assets_preset_model_attribute`
    CHANGE COLUMN `data_source_type` `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,27-TiDB,27-Hive1';


-- Hive2预设模型属性脏数据处理
delete from assets_preset_model_attribute where data_source_type = 7;
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 7, 0, 1),
('data_base', '数据库', 0, 6, 7, 0, 2),
('create_time', '表创建时间', 0, 5, 7, 0, 3),
('ddl_update_time', 'DDL最后变更时间', 0, 5, 7, 0, 4),
('storage_location', '存储位置', 0, 6, 7, 0, 5),
('storage_size', '存储大小', 0, 7, 7, 0, 6),
('manager', '负责人', 1, 1, 7, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 7, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 7, 0, 3);

-- Hive1预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 27, 0, 1),
('data_base', '数据库', 0, 6, 27, 0, 2),
('create_time', '表创建时间', 0, 5, 27, 0, 3),
('ddl_update_time', 'DDL最后变更时间', 0, 5, 27, 0, 4),
('storage_location', '存储位置', 0, 6, 27, 0, 5),
('storage_size', '存储大小', 0, 7, 27, 0, 6),
('manager', '负责人', 1, 1, 27, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 27, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 27, 0, 3);

-- 初始化已有租户的Hive1元模型
-- 技术属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'table_name', '表名', 6, 0, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='table_name');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'data_base', '数据库', 6, 0, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name='data_base');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'create_time', '表创建时间', 5, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='create_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'ddl_update_time', 'DDL最后变更时间', 5, 0, 1, 4,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='ddl_update_time');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'storage_location', '存储位置', 6, 0, 1, 5,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='storage_location');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 0, NULL, 'storage_size', '存储大小', 7, 0, 1, 6,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='storage_size');

-- 通用属性
INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 1, NULL, 'manager', '负责人', 1, 1, 1, 1,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='manager');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 1, NULL, 'tb_name_cn', '表中文名', 2, 1, 1, 2,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='tb_name_cn');

INSERT INTO `assets_model_attribute`
(`create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`, `data_source_type`, `attribute_type`, `sub_model_id`, `attribute_name`, `attribute_name_cn`, `field_type`, `is_required`, `is_preset`, `sort_order`, `tenant_id`)
select now(), now(), 0, 0, 0, 27, 1, NULL, 'partition_life', '分区保留策略', 4, 0, 1, 3,id from assets_tenant where id not in (select DISTINCT(tenant_id) from assets_model_attribute where data_source_type = 27 and attribute_name ='partition_life');

-- data_source_json需要存储kerberos配置信息 修改字段类型为text
ALTER TABLE `assets_data_source` CHANGE COLUMN `data_source_json` `data_source_json` TEXT NULL DEFAULT NULL COMMENT '数据源配置信息';


-- 查询优化
-- db添加冗余字段

ALTER TABLE `assets_data_db`
ADD COLUMN `data_source_type`  TINYINT(1)  NULL DEFAULT NULL COMMENT '冗余source.data_source_type';

-- table添加冗余字段

ALTER TABLE `assets_data_table`
ADD COLUMN `data_source_type`  TINYINT(1)  NULL DEFAULT NULL COMMENT '冗余source.data_source_type',
ADD COLUMN `sub_model_id` BIGINT NULL DEFAULT NULL COMMENT '冗余db.sub_model_id';


-- column添加冗余字段

ALTER TABLE `assets_data_table_column`
ADD COLUMN `table_name`  VARCHAR(100)  NULL DEFAULT NULL COMMENT '冗余table.table_name',
ADD COLUMN `table_hot`  bigint(20)  NOT NULL DEFAULT 0 COMMENT '冗余table.table_hot',
ADD COLUMN `table_storage`  bigint(20) NOT NULL DEFAULT 0 COMMENT '冗余table.table_storage',
ADD COLUMN `table_create_at`  DATETIME NULL DEFAULT NULL COMMENT '冗余table.table_create_at',
ADD COLUMN `extra_attribute`  json  NULL DEFAULT NULL COMMENT '冗余table.extra_attribute',
ADD COLUMN `table_owner`  bigint(20)  NULL DEFAULT NULL COMMENT '冗余table.table_owner',
ADD COLUMN `data_source_type`  TINYINT(1)  NULL DEFAULT NULL COMMENT '冗余source.data_source_type',
ADD COLUMN `sub_model_id` BIGINT NULL DEFAULT NULL COMMENT '冗余db.sub_model_id';

-- 冗余数据

delimiter $$
DROP PROCEDURE IF EXISTS db_move;
CREATE PROCEDURE db_move()
BEGIN

  DECLARE maxid BIGINT(40);
	DECLARE cid BIGINT(40);
	DECLARE csize BIGINT(40);
  set cid = 1;
  set csize = 10000;
  set maxid  = (SELECT max(id) FROM assets_data_db);

    WHILE (cid<=maxid) DO
    -- 冗余源信息
    UPDATE assets_data_db a
        LEFT JOIN assets_data_source b
        ON b.id = a.data_source_id
        SET a.data_source_type = b.data_source_type
        WHERE a.id  BETWEEN cid and  cid +csize;

        SET cid = cid + csize;
    END WHILE;
END;
$$
call db_move();

DROP PROCEDURE IF EXISTS tb_move;
CREATE PROCEDURE tb_move()
BEGIN

  DECLARE maxid BIGINT(40);
	DECLARE cid BIGINT(40);
	DECLARE csize BIGINT(40);
  set cid = 1;
  set csize = 10000;
  set maxid  = (SELECT max(id) FROM assets_data_table);

    WHILE (cid<=maxid) DO
    -- 冗余库信息
    UPDATE assets_data_table a
        LEFT JOIN assets_data_db b
        ON b.id = a.db_id
        SET a.sub_model_id = b.sub_model_id
        WHERE a.id  BETWEEN cid and  cid +csize;

    -- 冗余源信息
    UPDATE assets_data_table a
        LEFT JOIN assets_data_source b
        ON b.id = a.data_source_id
        SET a.data_source_type = b.data_source_type
        WHERE a.id  BETWEEN cid and  cid +csize;

        SET cid = cid + csize;
    END WHILE;
END;
$$
call tb_move();

DROP PROCEDURE IF EXISTS col_move;
CREATE PROCEDURE col_move()
BEGIN

  DECLARE maxid BIGINT(40);
	DECLARE cid BIGINT(40);
	DECLARE csize BIGINT(40);
  set cid = 1;
  set csize = 10000;
  set maxid  = (SELECT max(id) FROM assets_data_table_column);

    WHILE (cid<=maxid) DO
    -- 冗余表信息
    UPDATE assets_data_table_column a
        LEFT JOIN assets_data_table b
        ON b.id = a.table_id
        SET a.table_hot = b.table_hot,
        a.table_name = b.table_name,
        a.table_owner = b.table_owner,
        a.table_create_at = b.table_create_at,
        a.table_storage = b.table_storage,
        a.extra_attribute = b.extra_attribute
        WHERE  a.id  BETWEEN cid and  cid +csize;

    -- 冗余库信息
    UPDATE assets_data_table_column a
        LEFT JOIN assets_data_db b
        ON b.id = a.db_id
        SET a.sub_model_id = b.sub_model_id
        WHERE a.id  BETWEEN cid and  cid +csize;

    -- 冗余源信息
    UPDATE assets_data_table_column a
        LEFT JOIN assets_data_source b
        ON b.id = a.data_source_id
        SET a.data_source_type = b.data_source_type
        WHERE a.id  BETWEEN cid and  cid +csize;

        SET cid = cid + csize;
    END WHILE;
END;
$$
call col_move();


-- 重建索引
ALTER TABLE `assets_data_table`
	ADD INDEX `idx_table_name` (`table_name`)  USING BTREE;
ALTER TABLE `assets_data_table`
	DROP INDEX `idx_ck_1`,
	ADD INDEX `idx_ck_1` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `table_hot`);
ALTER TABLE `assets_data_table`
	ADD INDEX `idx_ck_2` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `table_create_at`);
ALTER TABLE `assets_data_table`
	ADD INDEX `idx_ck_3` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `table_storage`);
ALTER TABLE `assets_data_table`
	ADD INDEX `idx_ck_4` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `update_at`);


ALTER TABLE `assets_data_table_column`
	ADD INDEX `idx_column_name` (`column_name`) USING BTREE;
ALTER TABLE `assets_data_table_column`
DROP INDEX `idx_ck_1`,
ADD INDEX `idx_ck_1` (`tenant_id`, `data_source_type`,`is_deleted`,`table_hot`) USING BTREE;
ALTER TABLE `assets_data_table_column`
ADD INDEX `idx_ck_2` (`tenant_id`, `data_source_type`,`is_deleted`,`table_create_at`) USING BTREE;
ALTER TABLE `assets_data_table_column`
ADD INDEX `idx_ck_3` (`tenant_id`, `data_source_type`,`is_deleted`,`table_storage`) USING BTREE;
ALTER TABLE `assets_data_table_column`
ADD INDEX `idx_ck_4` (`tenant_id`, `data_source_type`,`is_deleted`,`update_at`) USING BTREE;

-- 清除

DROP PROCEDURE db_move;
DROP PROCEDURE tb_move;
DROP PROCEDURE col_move;

-- 新增同步状态字段
ALTER TABLE `assets_data_source`
	ADD COLUMN `sync_status` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '1-同步结束，2-同步中';

UPDATE 	assets_data_source SET link_status = 1 WHERE link_status = 2;