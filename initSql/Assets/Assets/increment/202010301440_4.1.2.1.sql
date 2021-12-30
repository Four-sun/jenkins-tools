-- 角色管理页 数据开发修改文案
UPDATE assets_role SET role_desc = "具有维护/查询/订阅元数据、数据资源的功能权限" WHERE role_value = 3;

-- 增加订阅的数据、元数据质量、数据脱敏等三个权限
INSERT INTO assets_permission ( id, create_at, update_at, create_by, update_by, is_deleted, permission_code, permission_name, permission_display, parent_id, permission_type )
VALUES
( 45, now(), now(), 0, 0, 0, 'myData_subscribe', '我的数据_订阅的数据', '订阅的数据', 40, 1 ),
( 65, now(), now(), 0, 0, 0, 'metaDataMgr_metaDataQuality', '数据管理_元数据质量', '元数据质量', 60, 1 ),
( 66, now(), now(), 0, 0, 0, 'metaDataMgr_metaDataQuality_fillRate', '数据管理_元数据质量_完整度分析', '完整度分析', 65, 1 ),
( 67, now(), now(), 0, 0, 0, 'metaDataMgr_metaDataQuality_lineageStatistics', '数据管理_元数据质量_血缘分析', '血缘分析', 65, 1 ),
( 83, now(), now(), 0, 0, 0, 'securityMgr_dataDesensitization', '安全管理_数据脱敏', '数据脱敏', 80, 1 );

INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 80 FROM assets_role r WHERE role_value IN ( 3 );

INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 45 FROM assets_role r WHERE role_value IN ( 1, 2, 3 );
INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 60 FROM assets_role r WHERE role_value = 3;
INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 65 FROM assets_role r WHERE role_value IN ( 1, 2, 3 );
INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 66 FROM assets_role r WHERE role_value IN ( 1, 2, 3 );
INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 67 FROM assets_role r WHERE role_value IN ( 1, 2, 3 );
INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 83 FROM assets_role r WHERE role_value IN ( 1, 2, 3 );

CREATE TABLE `assets_alert`
(
    `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`      bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`      bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`      datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`      datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`     tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `meta_data_type` tinyint(1)          NOT NULL COMMENT '事件源 0-数据源',
    `meta_data_id`   bigint(20)          NOT NULL COMMENT '事件源ID',
    `event_type`     tinyint(1)          NOT NULL COMMENT '事件类型 1-周期同步未完成',
    `send_type`      varchar(100)                 DEFAULT '0' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
    `ding_webhook`   varchar(255)                 DEFAULT NULL COMMENT '钉钉Webhook',
    `users`          varchar(255)                 DEFAULT NULL COMMENT '要通知的用户信息',
    `tenant_id`      bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='告警表';


CREATE TABLE `assets_notify_record`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`    bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`    bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`   tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `app_type`     tinyint(1)          NOT NULL DEFAULT '9' COMMENT '应用类型 数据资产默认为9',
    `project_id`   bigint(20)          NOT NULL,
    `user_id`      bigint(20)                   DEFAULT NULL COMMENT '用户ID',
    `content_id`   bigint(20)          NOT NULL COMMENT '通知内容ID',
    `content`      varchar(255)        NOT NULL COMMENT '通知内容',
    `trigger_type` tinyint(1)                   DEFAULT NULL COMMENT '触发类型',
    `status`       tinyint(1)          NOT NULL DEFAULT '0',
    `read_status`  tinyint(1)          NOT NULL DEFAULT '0' COMMENT '是否已读',
    `tenant_id`    bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='通知记录表';

-- 元数据质量-完整度分析表
CREATE TABLE `assets_fill_rate_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `analysis_mode` tinyint(3) unsigned NOT NULL COMMENT '统计方式：0-数据源， 1-数据库，2-表负责人',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `table_owner_id` bigint(20) DEFAULT NULL,
  `table_owner_name` varchar(128) DEFAULT NULL,
  `data_source_id` bigint(20) DEFAULT NULL,
  `data_source_type` tinyint(8) unsigned DEFAULT NULL,
  `data_source_name` varchar(128) DEFAULT NULL,
  `db_id` bigint(20) DEFAULT NULL COMMENT '数据库id',
  `db_name` varchar(255) DEFAULT NULL COMMENT '数据库名称',
  `table_fill_rate` float NOT NULL DEFAULT '0' COMMENT '表填充率',
  `column_fill_rate` float NOT NULL DEFAULT '0' COMMENT '字段填充率',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='元数据质量-完整度分析表(按数据源、数据库、负责人统计)';

-- 元数据质量-业务属性完整度分析表
CREATE TABLE `assets_biz_attr_fill_rate_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `analysis_mode` tinyint(3) unsigned NOT NULL COMMENT '统计方式：3-业务属性',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` tinyint(8) unsigned DEFAULT NULL COMMENT '数据源类型',
  `meta_data_type` tinyint(3) unsigned NOT NULL COMMENT '元模型属性类型： 1-表，2-字段',
  `attribute_id` bigint(20) DEFAULT NULL COMMENT '属性id',
  `attribute_name` varchar(128) DEFAULT NULL COMMENT '属性名',
  `attribute_name_cn` varchar(128) DEFAULT NULL COMMENT '属性中文名',
  `fill_rate` float NOT NULL DEFAULT '0' COMMENT '填充率',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='元数据质量-完整度分析表(按业务属性统计)';

-- 元数据质量-质量统计表
CREATE TABLE `assets_fill_rate_total_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `meta_data_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '元数据类型 1-表 2-字段',
  `fill_rate` float NOT NULL DEFAULT '0' COMMENT '不同数据源类型下元模型填充率',
  `total_fill_rate` float NOT NULL DEFAULT '0' COMMENT '所有数据源类型下元模型填充率',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='质量统计表';

ALTER TABLE `assets_data_table`
ADD COLUMN `has_lineage` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有血缘' AFTER `affect_count`;

CREATE TABLE assets_db_lineage_statistics (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
	  `create_by` bigint(20) NOT NULL DEFAULT 0 COMMENT '创建人',
	  `update_by` bigint(20) NOT NULL DEFAULT 0 COMMENT '更新人',
	  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 未删除 1 已删除',
	  `db_id` BIGINT(20) NOT NULL COMMENT '数据库id',
    `db_name` VARCHAR(100) NOT NULL COMMENT '数据库名称',
    `data_source_type` tinyint(1) NOT NULL COMMENT '数据源类型',
    `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id',
    `table_total_count`  BIGINT(20)  DEFAULT 0 COMMENT '数据库表总数',
    `table_count_without_lineage`  BIGINT(20)  DEFAULT 0 COMMENT '无血缘的表总数',
	  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库血缘统计';


ALTER TABLE `assets_db_lineage_statistics`
	ADD UNIQUE INDEX `idx_db_id` (`db_id`);


INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES (11, 'dbLineageStatisticsJob', 'dbLineageStatisticsJobGroup', 'dbLineageStatisticsJobTrigger', 'dbLineageStatisticsJobGroup', 'com.dtstack.assets.service.schedule.job.DbLineageStatisticsJob', '0 0 3 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);

-- 统计业务属性填充率定时任务
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES (10, 'attributeFillRateStatisticJob', 'attributeFillRateStatisticJobGroup', 'attributeFillRateStatisticJobTrigger', 'attributeFillRateStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.AttributeFillRateStatisticJob', '0 50 23 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
