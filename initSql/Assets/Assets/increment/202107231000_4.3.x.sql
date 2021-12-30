-- 同步状态更新时间调整
update dt_center_cron_schedule set cron = '0 */2 * * * ?' where job_detail_name = 'dataSourceStatusJob';
update dt_center_cron_schedule set cron = '0 */5 * * * ?' where job_detail_name = 'dataSourceSyncStatusJob';

-- 删除原数据标准和标准映射权限
delete from assets_permission where id in (401, 402);
delete from assets_role_permission where permission_id in (401, 402);

-- 新增权限
insert into assets_permission(id,permission_code,permission_name,permission_display,parent_id,permission_type)
values
(401,'dataStandard_statistic','数据标准_标准统计','标准统计',400,1),
(402,'dataStandard_manager','数据标准_标准管理','标准管理', 400,1),
(403,'dataStandard_manager_definition','数据标准_标准管理_标准定义',"标准定义",402,1),
(404,'dataStandard_manager_mapping','数据标准_标准管理_标准映射',"标准映射",402,1),
(405,'dataStandard_basis','数据标准_标准基础',"标准基础",400,1),
(406,'dataStandard_basis_rootMgr','数据标准_标准基础_词根管理',"词根管理", 405, 1),
(407,'dataStandard_basis_codeMgr','数据标准_标准基础_码表管理', "码表管理",405, 1),
(408,'dataStandard_basis_industryTemplate','数据标准_标准基础_行业模板',"行业模板", 405, 1),
(409,'dataStandard_basis_dbCollect','数据标准_标准基础_数据库拾取', "数据库拾取",405, 1);

-- 角色权限关联
insert into assets_role_permission(role_id,permission_id)
select id, 401
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 402
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 403
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 404
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 405
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 406
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 407
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 408
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 409
from assets_role
where role_value in (1,2);

-- 词根表
CREATE TABLE `assets_standard_root` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `root_abbreviation` varchar(255) NOT NULL COMMENT '词根简称',
    `root_full_name` varchar(255) DEFAULT NULL COMMENT '词根全称',
    `root_cn` varchar(255) DEFAULT NULL COMMENT '词根中文名',
    `quote_count` bigint(20) DEFAULT '0' COMMENT '被引用数量',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='词根表';

-- 码表表
CREATE TABLE `assets_standard_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `code_name` varchar(255) NOT NULL COMMENT '代码名称',
  `code_number` varchar(255) NOT NULL COMMENT '代码编号',
  `catalog_id` bigint(20) NOT NULL COMMENT '代码目录id',
  `code_desc` varchar(255) DEFAULT NULL COMMENT '代码说明',
  `code_from` varchar(255) DEFAULT NULL COMMENT '代码来源',
  `code_content` json DEFAULT NULL COMMENT '代码内容 json字符串',
  `quote_count` bigint(20) DEFAULT '0' COMMENT '被引用数量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码表';

-- 码表版本记录表
CREATE TABLE `assets_code_version_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `code_id` bigint(20) NOT NULL COMMENT '代码ID',
  `version` int(10) DEFAULT '10' COMMENT '版本号 更新时自增1 以倒数第一位分隔',
  `snapshot` json NOT NULL COMMENT '更改快照',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码变更日志表';

-- 代码目录表
CREATE TABLE `assets_standard_code_catalog` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `catalog_name` varchar(255) NOT NULL COMMENT '目录名',
    `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
    `child_id` bigint(20) DEFAULT NULL COMMENT '子节点id',
    `prev_id` bigint(20) DEFAULT NULL COMMENT '前一个节点id',
    `next_id` bigint(20) DEFAULT NULL COMMENT '后一个节点id',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码目录表';

-- 引用统计定时任务
INSERT INTO `dt_center_cron_schedule` ( `id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted` ) VALUES( 16, 'quoteCountStatisticJob', 'quoteCountStatisticJobGroup', 'quoteCountStatisticJobTrigger', 'quoteCountStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.QuoteCountStatisticJob', '0 0 1 * * ?', 0, NULL, NULL, 'assets', '2020-11-17 19:56:40', '2020-11-17 19:56:40', 0 );

-- 标准新增字段
ALTER TABLE `assets_standard`
    ADD COLUMN `standard_name_abbreviation` varchar(255)  NOT NULL  DEFAULT '' COMMENT '标准缩写' AFTER `standard_name`,
    ADD COLUMN `standard_number` varchar(255) NULL COMMENT '标准编号' AFTER `standard_name`,
    ADD COLUMN `standard_from` varchar(255)  NULL COMMENT '标准来源' AFTER `standard_name`,
    ADD COLUMN `standard_code_id` BIGINT(20) NULL COMMENT '引用码表id' AFTER `standard_name`,
    ADD COLUMN `post_precision` INT(3)  NULL COMMENT '数据精度-小数点后' AFTER `standard_name`,
    ADD COLUMN `pre_precision` INT(3)  NULL COMMENT '数据精度-小数点前' AFTER `standard_name`,
    ADD COLUMN `data_length_operator` varchar(4) NULL COMMENT '数据长度-运算符' AFTER `standard_name`,
    ADD COLUMN `data_length` int(4) NULL COMMENT '数据长度' AFTER `standard_name`,
    ADD COLUMN `data_type_id` TINYINT(1) NULL COMMENT '默认数据类型' AFTER `standard_name`,
    ADD COLUMN `default_value` varchar(255)  NULL COMMENT '默认值' AFTER `standard_name`,
    CHANGE COLUMN `data_type` `data_type` varchar(100)  NULL COMMENT '数据类型';
-- 标准版本记录
CREATE TABLE `assets_standard_version_record` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `standard_id` bigint(20) NOT NULL COMMENT '标准ID',
    `version` int(10) DEFAULT '10' COMMENT '版本号 更新时自增1 以倒数第一位分隔',
    `snapshot` json NOT NULL COMMENT '更改快照',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码变更日志表';




