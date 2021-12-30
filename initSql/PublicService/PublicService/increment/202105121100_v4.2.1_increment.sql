-- -------------------
-- 【模型V1.1版本】
-- -------------------

-- 修改表名dm_model=>dm_model_version
ALTER TABLE `dt_pub_service`.`dm_model` RENAME TO dm_model_base_info;
-- 数据模型
CREATE TABLE `dm_model` (
`id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键（model_id）',
`model_name` VARCHAR ( 64 ) NOT NULL COMMENT '模型名称',
`model_en_name` VARCHAR ( 64 ) NOT NULL COMMENT '模型英文名称',
`latest_version` VARCHAR ( 16 ) NOT NULL DEFAULT 0 COMMENT '模型最新版本 0暂存 -> 1.0 -> 1.1 -> 1.2 -> ...',
`tenant_id` INT ( 11 ) COMMENT '租户ID',
`dtuic_tenant_id` INT ( 11 ) COMMENT 'dtuic租户ID',
`is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
`gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`create_user_id` INT ( 11 ) DEFAULT '0',
`modify_user_id` INT ( 11 ) DEFAULT '0',
PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '模型表';

-- dm_model_base_info增加租户ID字段
ALTER TABLE `dt_pub_service`.`dm_model_base_info`
ADD COLUMN `model_id` int(11) COMMENT '模型ID' AFTER `id`,
ADD COLUMN `model_version` varchar(32) COMMENT '模型版本 1.0->1.1->1.2' AFTER `model_id`;

-- dm_model_base_info增加发布下线信息
ALTER TABLE `dt_pub_service`.`dm_model_base_info`
ADD COLUMN `release_time` datetime COMMENT '发布时间' AFTER `model_status`,
ADD COLUMN `release_op_id` int(11) COMMENT '发布人员id' AFTER `release_time`,
ADD COLUMN `offline_time` datetime COMMENT '下线时间' AFTER `release_op_id`,
ADD COLUMN `offline_op_id` int(11) COMMENT '下线人员id' AFTER `offline_time`;

-- dm_table增加租户ID字段
ALTER TABLE `dt_pub_service`.`dm_table`
ADD COLUMN `model_version` varchar(32) COMMENT '模型版本 1.0->1.1->1.2' AFTER `model_id`;
-- dm_column增加租户ID字段
ALTER TABLE `dt_pub_service`.`dm_column`
ADD COLUMN `model_version` varchar(32) COMMENT '模型版本 1.0->1.1->1.2' AFTER `model_id`;
-- dm_table_join增加租户ID字段
ALTER TABLE `dt_pub_service`.`dm_table_join`
ADD COLUMN `model_version` varchar(32) COMMENT '模型版本 1.0->1.1->1.2' AFTER `model_id`;
-- dm_column_condition增加租户ID字段
ALTER TABLE `dt_pub_service`.`dm_column_condition`
ADD COLUMN `model_version` varchar(32) COMMENT '模型版本 1.0->1.1->1.2' AFTER `model_id`;

-- 初始化model_version
UPDATE `dt_pub_service`.`dm_column` a
LEFT JOIN `dt_pub_service`.`dm_model_base_info` b ON a.model_id = b.id
SET a.model_version = ( CASE WHEN b.model_status = 0 THEN '0' ELSE '1.0' END );

UPDATE `dt_pub_service`.`dm_column_condition` a
LEFT JOIN `dt_pub_service`.`dm_model_base_info` b ON a.model_id = b.id
SET a.model_version = ( CASE WHEN b.model_status = 0 THEN '0' ELSE '1.0' END );

UPDATE `dt_pub_service`.`dm_table` a
LEFT JOIN `dt_pub_service`.`dm_model_base_info` b ON a.model_id = b.id
SET a.model_version = ( CASE WHEN b.model_status = 0 THEN '0' ELSE '1.0' END );

UPDATE `dt_pub_service`.`dm_table_join` a
LEFT JOIN `dt_pub_service`.`dm_model_base_info` b ON a.model_id = b.id
SET a.model_version = ( CASE WHEN b.model_status = 0 THEN '0' ELSE '1.0' END );

UPDATE `dt_pub_service`.`dm_model_base_info`
SET model_id = id,
model_version = ( CASE WHEN model_status = 0 THEN '0' ELSE '1.0' END );

-- model发布下线信息迁移
UPDATE `dt_pub_service`.`dm_model_base_info`
SET release_time = ( CASE model_status WHEN 0 THEN NULL WHEN 1 THEN gmt_modified ELSE gmt_create END ),
release_op_id = ( CASE model_status WHEN 0 THEN NULL WHEN 1 THEN modify_user_id ELSE create_user_id END ),
offline_time = ( CASE model_status WHEN -1 THEN gmt_modified ELSE NULL END ),
offline_op_id = ( CASE model_status WHEN -1 THEN modify_user_id ELSE NULL END );

-- dm_model数据转移
INSERT `dt_pub_service`.`dm_model` SELECT
id,
model_name,
model_en_name,
model_version AS latest_version,
tenant_id,
dtuic_tenant_id,
is_deleted,
gmt_create,
gmt_modified,
create_user_id,
modify_user_id
FROM
    `dt_pub_service`.`dm_model_base_info`;


-- 事件注册表 cm: common server
CREATE TABLE `cm_event` (
`id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
`app_type` smallint ( 6 ) NOT NULL COMMENT 'app类型 1离线开发 2数据质量 3数据服务 4智能标签 5数据地图 6控制台 7实时开发 8算法开发 9数据资产 10指标平台',
`event_code` VARCHAR ( 32 ) NOT NULL COMMENT '事件编码',
`callback_url` VARCHAR ( 256 ) NOT NULL COMMENT '回调地址',
`is_active` TINYINT ( 1 ) NOT NULL DEFAULT 1 COMMENT '是否激活,默认激活 0不激活 1激活',
`remark` VARCHAR ( 64 ) COMMENT '备注',
`gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY ( `id` ),
UNIQUE KEY `unique_app_code_url` (`app_type`,`event_code`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '事件注册表';

-- 事件推送明细表
CREATE TABLE `cm_event_push_detail` (
`id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
`event_id` INT ( 11 ) NOT NULL COMMENT '事件id',
`app_type` smallint ( 6 ) NOT NULL COMMENT 'app类型 1离线开发 2数据质量 3数据服务 4智能标签 5数据地图 6控制台 7实时开发 8算法开发 9数据资产 10指标平台',
`event_code` VARCHAR ( 32 ) NOT NULL COMMENT '事件编码',
`callback_url` VARCHAR ( 256 ) NOT NULL COMMENT '回调地址',
`biz_type` smallint ( 6 ) NOT NULL COMMENT '业务实体类型, 1-模型',
`biz_id` INT ( 11 ) DEFAULT NULL COMMENT '业务实体id',
`is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除,0未删除',
`gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`create_user_id` INT ( 11 ) DEFAULT '0',
`modify_user_id` INT ( 11 ) DEFAULT '0',
PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '事件推送明细表';

-- 模型被引用记录表
CREATE TABLE `dm_model_reference` (
`id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键（model_id）',
`model_id` INT ( 11 ) NOT NULL COMMENT '模型ID',
`app_type` smallint ( 6 ) NOT NULL COMMENT 'app类型 1离线开发 2数据质量 3数据服务 4智能标签 5数据地图 6控制台 7实时开发 8算法开发 9数据资产 10指标平台',
`gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY ( `id` ),
UNIQUE KEY `unique_model_app` (`model_id`,`app_type`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '模型被引用记录表';