-- 订阅权限
INSERT INTO assets_permission ( id, create_at, update_at, create_by, update_by, is_deleted, permission_code, permission_name, permission_display, parent_id, permission_type )
VALUES
(27,now(),now(),0,0,0,'dmap_center_batchMgr_subscribe','数据地图_元数据中心_批量管理_订阅','批量管理订阅',23,1);

INSERT INTO assets_role_permission ( create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id )
SELECT now(), now(), 0, 0, 0, r.id, 27 FROM assets_role r WHERE role_value IN ( 1, 2, 3 );
-- 数据脱敏 - 脱敏规则表
CREATE TABLE `assets_data_masking_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `masking_rule_name` varchar(128) DEFAULT NULL COMMENT '脱敏规则名称',
  `masking_type` tinyint(4) DEFAULT NULL COMMENT '脱敏效果，0-部分脱敏，1-全部脱敏',
  `replace_char` varchar(32) DEFAULT NULL COMMENT '替换字符',
  `start_position` tinyint(4) DEFAULT NULL COMMENT '字段替换开始位置',
  `sample_data` varchar(128) DEFAULT NULL COMMENT '样例数据',
  `end_position` tinyint(4) DEFAULT NULL COMMENT '替换结束位置',
  `masking_table_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直接脱敏表数量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='脱敏规则表';

-- 数据脱敏 - 脱敏应用表
create table assets_data_masking_table
(
    id bigint unsigned auto_increment,
    tenant_id bigint unsigned not null,
    masking_rule_id bigint unsigned not null comment '脱敏规则id',
    table_id bigint unsigned not null comment '脱敏表的table_id,对应元数据的表id，如果是血缘脱敏表，此id就是其直接脱敏表的元数据id',
    lineage_table_id bigint unsigned null comment '血缘表id',
    table_name varchar(64) not null comment '脱敏表名',
    column_id bigint unsigned not null comment '脱敏字段column_id,对应元数据的字段id，如果是血缘脱敏表，此id就是其直接脱敏表的元数据id',
    lineage_column_id bigint unsigned null comment '血缘字段id',
    column_name varchar(128) not null comment '脱敏字段名称',
    db_id bigint unsigned null comment '数据库id',
    db_name varchar(128) not null comment '数据库名称',
    data_source_type tinyint unsigned not null comment '数据源类型',
    data_source_id bigint unsigned null comment '数据源id',
    data_source_name varchar(128) not null comment '数据源名称',
    lineage_table_count int default 0 not null comment '血缘脱敏表总数',
    create_at datetime default current_timestamp not null,
    update_at datetime default current_timestamp not null,
    create_by bigint unsigned default 0 not null,
    update_by bigint unsigned default 0 null,
    lineage_status tinyint default 1 not null comment '0-血缘未启用， 1-血缘已启用',
    is_direct tinyint default 1 not null comment '0-不是直接脱敏表，1-是直接脱敏表',
    is_deleted tinyint default 0 not null comment '0 未删除 1 已删除',
    constraint assets_data_masking_table_pk
        primary key (id)
)ENGINE=InnoDB
    comment '数据脱敏应用表';
-- 创建联合索引
ALTER TABLE `assets_data_masking_table`
    ADD INDEX `idx_ds_db_table_col_name` (`data_source_name`, `db_name`, `table_name`, `column_name`);


DROP TABLE IF EXISTS `assets_subscribe`;
CREATE TABLE `assets_subscribe`
(
    `id`                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`         bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`         bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`         datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`         datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`        tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `user_id`           bigint(20)          NOT NULL COMMENT '订阅人ID',
    `meta_data_type`    tinyint(1)          NOT NULL COMMENT '订阅对象 1-表',
    `meta_data_id`      bigint(20)          NOT NULL COMMENT '订阅对象ID',
    `meta_data_name`    varchar(255)        NOT NULL COMMENT '订阅对象名',
    `meta_data_name_cn` varchar(255)        NULL COMMENT '订阅对象中文名',
    `event_type`        tinyint(1)          NOT NULL COMMENT '事件类型 2-元数据变动',
    `send_type`         varchar(100)        NOT NULL DEFAULT '0' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
    `ding_webhook`      varchar(255)                 DEFAULT NULL COMMENT '钉钉Webhook',
    `tenant_id`         bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='订阅表';

CREATE TABLE `assets_version_record`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`  bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`  bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`  datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`  datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `table_id`   bigint(20)          NOT NULL COMMENT '表ID',
    `change_by`  varchar(100)        NOT NULL COMMENT '操作人',
    `version`    int(10)                      DEFAULT '10' COMMENT '版本号 更新时自增1 以倒数第一位分隔',
    `snapshot`   json                NOT NULL COMMENT '更改快照',
    `tenant_id`  bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='变更日志表';

ALTER TABLE `assets_version_record`
	ADD  INDEX `idx_table_id` (`table_id`);

ALTER TABLE `assets_model_column_attribute`
	ADD  INDEX `idx_table_id` (`table_id`);

-- 增加脱敏表血缘字段定时同步任务
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (12, 'dataMaskingLineageSyncJob', 'dataMaskingLineageSyncJobGroup', 'dataMaskingLineageSyncJobTrigger', 'dataMaskingLineageSyncJobGroup', 'com.dtstack.assets.service.schedule.job.DataMaskingLineageSyncJob', '0 0 4 * * ?', 0, NULL, NULL, 'assets', '2020-11-17 19:56:40', '2020-11-17 19:56:40', 0);
