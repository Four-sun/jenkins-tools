-- 数据价值排行
CREATE TABLE `assets_data_value_rank` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
  `table_id` bigint(20) unsigned NOT NULL COMMENT '表ID',
  `column_id` bigint(20) DEFAULT NULL COMMENT '列ID',
  `obj_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '对象类型 0-表 1-字段',
  `obj_attr_1` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '对象属性1',
  `obj_attr_2` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '对象属性2',
  `view_count` bigint(20) DEFAULT '0' COMMENT '查看次数',
  `use_count` bigint(20) DEFAULT '0' COMMENT '使用次数',
  `affect_count` bigint(20) DEFAULT '0' COMMENT '影响表数',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据价值排行表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 已接入数据统计表
CREATE TABLE `assets_data_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `data_source_count` bigint(10) DEFAULT NULL COMMENT '数据源数量',
  `database_count` bigint(10) DEFAULT NULL COMMENT '数据库数量',
  `data_table_count` bigint(20) DEFAULT NULL COMMENT '数据表数量',
  `table_increment` bigint(20) DEFAULT NULL COMMENT '数据表增量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据预览表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 表存储排行数据
CREATE TABLE `assets_data_statistic_table_storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `table_rank` tinyint(1) NOT NULL COMMENT '表存储容量排名',
  `table_id` bigint(10) NOT NULL COMMENT '表主键',
  `table_name` varchar(100) NOT NULL COMMENT '表名称',
  `database_name` varchar(100) NOT NULL COMMENT '所属数据库名称',
  `table_storage` bigint(20) NOT NULL COMMENT '表存储大小',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据表存储大小排行前10' ENGINE=InnoDB  DEFAULT CHARSET=utf8;
-- 库存储排行数据
CREATE TABLE `assets_data_statistic_database_storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `db_rank` tinyint(1) NOT NULL COMMENT '数据库存储容量排名',
  `db_id` bigint(10) NOT NULL COMMENT '数据库主键',
  `db_name` varchar(100) NOT NULL COMMENT '数据库名称',
  `db_storage` bigint(20) NOT NULL COMMENT '数据库存储大小',
  `db_source_storage` bigint(20) NOT NULL COMMENT '该数据源下所有数据库存储大小总和',
  `db_storage_ratio` varchar(100) NOT NULL COMMENT '该数据库存储大小占该数据源数据库存储大小总和的占比',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据库存储大小排行前10' ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据分布表
CREATE TABLE `assets_data_distribution` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
    `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
    `attribute_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '属性ID',
    `attribute_name_cn` varchar(100) NOT NULL COMMENT '属性中文名',
    `attribute_value` VARCHAR (255) NOT NULL COMMENT '属性值',
    `table_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '表数量',
    `ratio` VARCHAR(10) NOT NULL DEFAULT '0%' COMMENT '表占比',
    `tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '数据分布' ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 表级血缘表
CREATE TABLE `assets_lineage_table` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '更新的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1-删除,0-未删除',
	`is_manual` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否手动维护,1-是,0-否',
	`table_id` BIGINT(20) NULL DEFAULT NULL COMMENT '数据表ID',
	`table_name` VARCHAR(100) NOT NULL COMMENT '数据表名称',
	`db_name` VARCHAR(100) NOT NULL COMMENT '数据库名称',
	`data_source_name` VARCHAR(100) NOT NULL COMMENT '数据源名称',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
	PRIMARY KEY (`id`)
)
COMMENT='血缘表表'  ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 血缘字段表
CREATE TABLE `assets_lineage_column` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '更新的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1-删除,0-未删除',
	`is_manual` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否手动维护,1-是,0-否',
	`lineage_table_id` BIGINT(20) NOT NULL COMMENT '血缘表ID',
	`column_id` BIGINT(20) NULL DEFAULT NULL COMMENT '字段ID',
	`column_name` VARCHAR(100) NOT NULL COMMENT '字段名称',
	`table_name` VARCHAR(100) NOT NULL COMMENT '数据表名称',
	`db_name` VARCHAR(100) NOT NULL COMMENT '数据库名称',
	`data_source_name` VARCHAR(100) NOT NULL COMMENT '数据库名称',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
	PRIMARY KEY (`id`)
)
COMMENT='血缘字段表'  ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 表血缘关系表
CREATE TABLE `assets_table_lineage` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '更新的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1-删除,0-未删除',
	`is_manual` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否手动维护,1-是,0-否',
	`lineage_table_id` BIGINT(20) NOT NULL COMMENT '血缘表id',
	`input_table_id` BIGINT(20) NOT NULL COMMENT '输入表id',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
	PRIMARY KEY (`id`)
)
COMMENT='表血缘关系表'  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 字段血缘关系表
CREATE TABLE `assets_column_lineage`(
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by`  INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by`  INT(11) NOT NULL DEFAULT '0' COMMENT '更新的用户',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1-删除,0-未删除',
  `is_manual`TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否手动维护,1-是,0-否',
  `lineage_column_id` BIGINT(20) NOT NULL COMMENT '血缘字段id',
  `input_column_id` BIGINT(20) NOT NULL COMMENT '输入字段id',
  `tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
  PRIMARY KEY (`id`)
)COMMENT = '字段血缘关系表'  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- assets_data_table 新增use_count、affect_count字段
ALTER TABLE `assets_data_table`
    ADD  `use_count`  BIGINT(20)  DEFAULT 0 COMMENT '使用次数' AFTER `table_hot`,
    ADD  `affect_count` BIGINT(20) DEFAULT 0 COMMENT '影响表数' AFTER `use_count`;

-- assets_data_table_column 新增affect_count字段
ALTER TABLE `assets_data_table_column`
    ADD  `affect_count` BIGINT(20) DEFAULT 0 COMMENT '影响字段数';

ALTER TABLE `assets_lineage_table`
	ADD UNIQUE INDEX `uk_name` (`table_name`, `db_name`, `data_source_name`, `tenant_id`);

ALTER TABLE `assets_lineage_column`
	ADD UNIQUE INDEX `uk_name` (`column_name`, `table_name`, `db_name`, `data_source_name`, `tenant_id`);

-- 新增统计已接入数据、表存储排行、数据库存储排行、数据价值排行、数据分布情况定时任务
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (6, 'dataStatisticJob', 'dataStatisticJobGroup', 'dataStatisticJobTrigger', 'dataStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.DataStatisticJob', '0 30 23 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);

-- 增加元数据管理员权限
insert into
assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
SELECT now(),now(),0,0,0,id,41 FROM  assets_role WHERE role_name = '元数据管理员';

-- 同步周期任务实例
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (7, 'syncPeriodTaskJob', 'syncPeriodTaskJobGroup', 'syncPeriodTaskJobTrigger', 'syncPeriodTaskJobGroup', 'com.dtstack.assets.service.schedule.job.SyncPeriodTaskJob', '0 0 23 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);

-- 表字段影响数统计
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (8, 'affectCountStatisticJob', 'affectCountStatisticJobGroup', 'affectCountStatisticJobTrigger', 'affectCountStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.AffectCountStatisticJob', '0 0 18 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
