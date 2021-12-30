-- 更改标准化建表权限名称为规范建表
update dt_pub_service.auth_permission set name = '数据模型_规范建表', display = '规范建表' where app_type = 9 and code = 'dataModel_createTable';

-- 更改flink表权限为建表权限
update dt_pub_service.auth_permission set code = 'dataModel_createTable_createTable', name = '数据模型_规范建表_建表', display = '建表' where app_type = 9 and code = 'dataModel_createTable_flink';

-- 新增规范设计权限
insert into dt_pub_service.auth_permission(app_type, code, name, display, type)
values(9, 'dataModel_createTable_specificationDesign', '数据模型_规范建表_规范设计', '规范设计', 1);
-- 设置父节点id
update dt_pub_service.auth_permission set parent_id = (select id from ((select id from dt_pub_service.auth_permission where app_type = 9 and code = 'dataModel_createTable') tmp))
where app_type = 9 and code = 'dataModel_createTable_specificationDesign';
-- 新增权限与角色关联
insert into dt_pub_service.auth_role_permission(app_type, role_id, permission_id, dtuic_tenant_id)
select
    9,
    ar.id,
    ap.id,
    ar.dtuic_tenant_id
from dt_pub_service.auth_permission ap, dt_pub_service.auth_role ar
where ap.code = 'dataModel_createTable_specificationDesign' and ar.role_value in (1,2,3,5) and ap.app_type = 9 and ar.app_type = 9;

-- 数仓层级表
CREATE TABLE `assets_data_ware_house_level` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `data_ware_house_level_name` varchar(255) NOT NULL COMMENT '中文名称',
    `data_ware_house_level_name_en` varchar(255) NOT NULL COMMENT '英文名称',
    `bind_db_id` bigint(20) DEFAULT NULL COMMENT '绑定数据库id',
    `data_ware_house_level_desc` varchar(255) DEFAULT NULL COMMENT '说明',
    `model_element_id` varchar(255) DEFAULT NULL COMMENT '元素模型id',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数仓层级表';

-- 模型元素表
CREATE TABLE `assets_model_element` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `catalog_name` varchar(255) NOT NULL COMMENT '模型元素名',
    `type` int(11) NOT NULL DEFAULT '0' COMMENT '0正常 1隐藏 2隐藏可编辑表名',
    `click_able` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可选中,0不可，1可',
    `rename_able` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可重名,0不可，1可',
    `delete_able` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可删除,0不可，1可',
    `move_able` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可移动,0不可，1可',
    `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
    `child_id` bigint(20) DEFAULT NULL COMMENT '子节点id',
    `prev_id` bigint(20) DEFAULT NULL COMMENT '前一个节点id',
    `next_id` bigint(20) DEFAULT NULL COMMENT '后一个节点id',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模型元素表';

-- 元素模型内容表
CREATE TABLE `assets_model_element_content` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `catalog_name` varchar(255) NOT NULL COMMENT '中文名称',
    `catalog_name_en` varchar(255) NOT NULL COMMENT '英文缩写',
    `model_element_id` bigint(20) NOT NULL COMMENT '模型元素id',
    `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
    `child_id` bigint(20) DEFAULT NULL COMMENT '子节点id',
    `prev_id` bigint(20) DEFAULT NULL COMMENT '前一个节点id',
    `next_id` bigint(20) DEFAULT NULL COMMENT '后一个节点id',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='元素模型内容表';

-- hive表额外参数信息表
CREATE TABLE `assets_hive_table_param` (
   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
   `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
   `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
   `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
   `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
   `table_id` bigint(20) NOT NULL COMMENT 'hive表id',
   `db_id` bigint(20) NOT NULL COMMENT 'hive库id',
   `source_id` bigint(20) NOT NULL COMMENT 'hive源id',
   `data_ware_house_level_id` bigint(20) NOT NULL COMMENT '数仓层级id',
   `store_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:PARQUET 1:ORC 2:TEXTFILE',
   `life_cycle_id` bigint(20) DEFAULT NULL COMMENT '公共服务生命周期id',
   `life_cycle` int(11) NOT NULL DEFAULT '0' COMMENT '生命周期',
   `model_element_value` json DEFAULT NULL COMMENT '模型元素值 json字符串',
   `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='hive表额外参数信息表';

-- hive表模型元素选中值关联表
CREATE TABLE `assets_hive_table_model_element_value` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `table_id` bigint(20) DEFAULT NULL COMMENT '表id',
    `model_element_id` bigint(20) DEFAULT NULL COMMENT '模型元素id',
    `model_element_content_id` bigint(20) DEFAULT NULL COMMENT '模型元素内容id',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='hive表模型元素选中值关联表';

-- 模型元素模版值
insert into assets_model_element(id, catalog_name, click_able, rename_able, delete_able, move_able, prev_id, next_id, tenant_id, type)
values
(1, '业务系统', 1, 1, 1, 1, null, 2, -1, 0),
(2, '主题域', 1, 1, 1, 1, 1, 3, -1, 0),
(3, '自定义内容（固定项）', 0, 0, 0, 0, 2, 4, -1, 2),
(4, '更新方式（固定项）', 1, 0, 0, 0, 3, null, -1, 0);

-- 模型元素内容模版值
insert into assets_model_element_content(id, catalog_name, catalog_name_en, model_element_id, parent_id, child_id, prev_id, next_id, tenant_id)
values
(1, '综合业务处理系统', 'BU', 1, null, 2, null, 6, -1),
(2, '信贷业务模块', 'CREDIT', 1, 1, null, 1, 3, -1),
(3, '储蓄业务模块', 'SAVING', 1, 1, null, 2, 4, -1),
(4, '对公业务模块', 'CORP', 1, 1, null, 3, 5, -1),
(5, '结算业务模块', 'SETTLE', 1, 1, null, 4, null, -1),
(6, '客户管理系统', 'CRM', 1, null, null, 1, 7, -1),
(7, '支付系统', 'PAY', 1, null, null, 6, 8, -1),
(8, '风控系统', 'RISK', 1, null, null, 7, null, -1),

(9, '交易主题', 'TRAD', 2, null, 10, null, 15, -1),
(10, '储蓄业务', 'SAVING', 2, 9, null, 9, 11, -1),
(11, '信贷业务', 'CREDIT', 2, 9, 12, 10, null, -1),
(12, '订单主题', 'ORDER', 2, 11, null, 11, 13, -1),
(13, '还款主题', 'REPAY', 2, 11, null, 12, 14, -1),
(14, '逾期主题', 'OVERDUE', 2, 11, null, 13, null, -1),
(15, '用户主题', 'CUST', 2, null, null, 9, 16, -1),
(16, '风控主题', 'RISK', 2, null, null, 15, 17, -1),
(17, '渠道主题', 'CHNL', 2, null, null, 16, 18, -1),
(18, '产品主题', 'PROD', 2, null, null, 17, null, -1),

(19, '全量表', 'DF', 4, null, null, null, 20, -1),
(20, '快照表', 'DFP', 4, null, null, 19, 21, -1),
(21, '增量表', 'DI', 4, null, null, 20, 22, -1),
(22, '拉链表', 'DZ', 4, null, null, 21, null, -1);

-- 数仓层级预设模版
insert into assets_data_ware_house_level(id, data_ware_house_level_name, data_ware_house_level_name_en, data_ware_house_level_desc, model_element_id, tenant_id)
values
(1, '原始数据层', 'ODS', '采集业务库数据，做简单的数据清洗', '1,3,4', -1),
(2, '明细数据层', 'DWD', '维度退化至事实表，减少关联查询，提高明细表的易用性', '2,3,4', -1),
(3, '汇总数据层', 'DWS', '宽表化手段，构建公共指标数据层', '2,3,4', -1),
(4, '应用数据层', 'ADS', '面向业务层提供个性化的统计指标数据', '2,3,4', -1),
(5, '维度数据层', 'DIM', '存储时间、地域、商品、用户等维度信息', '2,3,4', -1);