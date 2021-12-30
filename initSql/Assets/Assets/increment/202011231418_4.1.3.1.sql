ALTER TABLE `assets_data_statistic`
    ADD COLUMN `meta_data_change` BIGINT(20) DEFAULT 0 COMMENT '元数据变更次数' AFTER `table_increment`;

ALTER TABLE `assets_data_statistic`
    ADD COLUMN `storage` BIGINT(20) DEFAULT 0 COMMENT '数据源存储容量' AFTER `meta_data_change`;

ALTER TABLE `assets_data_statistic_database_storage`
    ADD COLUMN `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id' AFTER `db_rank`;

ALTER TABLE `assets_data_statistic_database_storage`
    ADD COLUMN `data_source_name` VARCHAR(255) NOT NULL COMMENT '数据源名称' AFTER `data_source_id`;

ALTER TABLE `assets_data_statistic_table_storage`
    ADD COLUMN `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id' AFTER `table_rank`;

ALTER TABLE `assets_data_statistic_table_storage`
    ADD COLUMN `data_source_name` VARCHAR(255) NOT NULL COMMENT '数据源名称' AFTER `data_source_id`;

-- 资产盘点-数据资源分布
CREATE TABLE `assets_data_resource_distribution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `catalog_id` bigint(100) NOT NULL COMMENT '资源目录id',
  `catalog_name` varchar(100) NOT NULL COMMENT '目录名称',
  `data_source_count` bigint(10) DEFAULT NULL COMMENT '数据源数量',
  `database_count` bigint(10) DEFAULT NULL COMMENT '数据库数量',
  `data_table_count` bigint(20) DEFAULT NULL COMMENT '数据表数量',
  `data_table_total_count` bigint(20) DEFAULT NULL COMMENT '目录下所有数据表数量',
  `data_table_ratio` float DEFAULT '0' COMMENT '表数量占比',
  `storage` bigint(20) DEFAULT '0' COMMENT '目录下数据源存储容量',
  `total_storage` bigint(20) DEFAULT NULL COMMENT '目录下数据存储容量',
  `storage_ratio` float DEFAULT '0' COMMENT '目录下存储容量占比',
  `child_catalog_count` varchar(256) DEFAULT NULL COMMENT '一级目录下的子集数量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产盘点数据质量分布';

-- 资产盘点-资产查询趋势表
CREATE TABLE `assets_search_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `search_count` bigint(10) DEFAULT NULL COMMENT '查询次数',
  `login_count` bigint(10) DEFAULT NULL COMMENT '登录人次',
  `login_user_count` bigint(20) DEFAULT NULL COMMENT '登录人数',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产盘点-资产查询趋势';

CREATE TABLE `assets_resource_display`(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `create_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`    int(11)             NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`    int(11)             NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`   tinyint(1)          NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `tenant_id`    bigint(20)          NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
    `user_id`      bigint(20)          NOT NULL COMMENT '用户ID',
    `key_property` TINYINT(1)          NULL     DEFAULT 0 COMMENT '主键信息，0优先显示英文名 1优先显示中文名',
    `tech_attrs`   VARCHAR(10)         NULL     DEFAULT '1,1,1,1' COMMENT '资源技术属性是否选中',
    `biz_attrs`    VARCHAR(255)        NULL COMMENT '业务属性选中的ID',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT ='资源用户显示项表';

ALTER TABLE `assets_resource_display` ADD UNIQUE (`user_id`);

INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (15, 'syncUserJob', 'syncUserJobGroup', 'syncUserJobTrigger', 'syncUserJobGroup', 'com.dtstack.assets.service.schedule.job.SyncUserJob', '0 0 5 * * ?', 0, NULL, NULL, 'assets', '2020-11-17 19:56:40', '2020-11-17 19:56:40', 0);