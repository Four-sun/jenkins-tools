-- 删除旧权限
delete from assets_permission;
-- 新增权限
insert into assets_permission(id,permission_code,permission_name,permission_display,parent_id,permission_type)
values
(1,'root','root','root',0,1),
(100,'inventory','资产盘点','资产盘点',1,1),
(200,'metaData','元数据','元数据',1,1),
(201,'metaData_dmap','元数据_数据地图','数据地图',200,1),
(202,'metaData_dmap_center','元数据_数据地图_元数据中心','元数据中心',201,1),
(203,'metaData_dmap_center_search','元数据_数据地图_元数据中心_搜索查询','搜索查询',202,1),
(204,'metaData_dmap_center_batchMgr','元数据_数据地图_元数据中心_批量管理','批量管理',202,1),
(205,'metaData_dmap_center_batchMgr_clean','元数据_数据地图_元数据中心_批量管理_清空','批量管理清空',204,1),
(206,'metaData_dmap_center_batchMgr_edit','元数据_数据地图_元数据中心_批量管理_编辑','批量管理编辑',204,1),
(207,'metaData_dmap_center_batchMgr_subscribe','元数据_数据地图_元数据中心_批量管理_订阅','批量管理订阅',204,1),
(208,'metaData_dmap_center_dataLineage_edit','元数据_数据地图_元数据中心_血缘_编辑','血缘编辑',202,1),
(209,'metaData_dmap_center_metaDataExport','元数据_数据地图_元数据中心_元数据导出','元数据导出',202,1),
(210,'metaData_metaModelMgr','元数据_元模型管理','元模型管理',200,1),
(211,'metaData_metaDataMgr','元数据_元数据管理','元数据管理',200,1),
(212,'metaData_metaDataMgr_managerEdit','元数据_元数据管理_负责人编辑','负责人编辑',211,1),
(213,'metaData_subscribe','元数据_订阅的数据','订阅的数据',200,1),
(214,'metaData_metaDataQuality','元数据_元数据质量','元数据质量',200,1),
(215,'metaData_metaDataQuality_fillRate','元数据_元数据质量_完整度分析','完整度分析',214,1),
(216,'metaData_metaDataQuality_lineageStatistics','元数据_元数据质量_血缘分析','血缘分析',214,1),
(300,'dataResource','数据资源','数据资源',1,1),
(301,'dataResource_resource','数据资源_数据资源','数据资源',300,1),
(302,'dataResource_resourceDirectoryMgr','数据资源_资源目录管理','资源目录管理',300,1),
(303,'dataResource_dataResourceManager','数据资源_数据资源管理','数据资源管理',300,1),
(400,'dataStandard','数据标准','数据标准',1,1),
(401,'dataStandard_standard','数据标准_数据标准','数据标准',400,1),
(402,'dataStandard_mapping','数据标准_标准映射','标准映射',400,1),
(500,'platformMgr','平台管理','平台管理',1,1),
(501,'platformMgr_dataSourceMgr','平台管理_数据源管理','数据源管理',500,1),
(502,'platformMgr_dataDesensitization','平台管理_数据脱敏管理','数据脱敏管理',500,1),
(503,'platformMgr_userRoleMgr','平台管理_用户角色管理','用户角色管理',500,1),
(504,'platformMgr_userRoleMgr_userMgr','平台管理_用户角色管理_用户管理','用户管理',503,1),
(505,'platformMgr_userRoleMgr_roleMgr','平台管理_用户角色管理_角色管理','角色管理',503,1),
(600,'indexLocation','首页定位','首页定位',1,1),
(601,'indexLocation_index2dataResource','首页定位_至数据资源','至数据资源',600,1),
(602,'indexLocation_index2dmap','首页定位_至数据地图','至数据地图',600,1);

-- 清除原有的角色权限关联信息
delete from assets_role_permission;

-- 新增用户角色权限关联
insert into assets_role_permission(role_id,permission_id)
select id, 1
from assets_role
where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select id, 100
from assets_role
where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select id, 200
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 201
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 202
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 203
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 204
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 205
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 206
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 207
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 208
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 209
from assets_role
where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select id, 210
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 211
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 212
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 213
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 214
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 215
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 216
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 300
from assets_role
where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select id, 301
from assets_role
where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select id, 302
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 303
from assets_role
where role_value in (1,2,3);

insert into assets_role_permission(role_id,permission_id)
select id, 400
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 401
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 402
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 500
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 501
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 502
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 503
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 504
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 505
from assets_role
where role_value in (1,2);

insert into assets_role_permission(role_id,permission_id)
select id, 600
from assets_role
where role_value in (1,2,3,4);

insert into assets_role_permission(role_id,permission_id)
select id, 601
from assets_role
where role_value in (4);

insert into assets_role_permission(role_id,permission_id)
select id, 602
from assets_role
where role_value in (1,2,3);


-- 更新角色描述信息
update assets_role
set role_desc = '具有资产盘点、元数据和数据资源模块的部分权限'
where role_value = 3;

update assets_role
set role_desc = '具有资产盘点和数据资源模块的部分权限'
where role_value = 4;

-- 数据标准表
CREATE TABLE `assets_standard` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`standard_name_cn` varchar(255) NOT NULL COMMENT '标准中文名',
`standard_name` varchar(255) NOT NULL COMMENT '标准名称',
`data_type` varchar(100) NOT NULL COMMENT '数据类型',
`catalog_id` bigint(100) NOT NULL COMMENT '标准目录id',
`business_definition` varchar(255) DEFAULT NULL COMMENT '业务定义',
`custom_attribute` json DEFAULT NULL COMMENT '自定义属性 json字符串',
`standard_status` tinyint(1) NOT NULL COMMENT '发布状态,0待发布,1已发布',
`hit_count` bigint(100) NOT NULL DEFAULT '0' COMMENT '命中数量',
`match_count` bigint(100) NOT NULL DEFAULT '0' COMMENT '匹配数量',
`mapping_status` tinyint(1) NOT NULL COMMENT '映射状态,-1初始化状态,0映射中,1映射结束',
`mapping_date` datetime DEFAULT NULL COMMENT '最近映射时间',
`publish_date` datetime DEFAULT NULL COMMENT '最近发布时间',
`nullable` tinyint(1) DEFAULT NULL COMMENT '允许为空 0不可空 1可空',
`repeatable` tinyint(1) DEFAULT NULL COMMENT '允许重复 0不允许 1允许',
`value_range` json DEFAULT NULL COMMENT '取值范围 json字符串',
`enum_range` json DEFAULT NULL COMMENT '枚举范围 json字符串',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据标准表';

-- 标准目录表
CREATE TABLE `assets_standard_catalog` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`catalog_name` varchar(255) NOT NULL COMMENT '目录名称',
`parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
`child_id` bigint(20) DEFAULT NULL COMMENT '子节点id',
`prev_id` bigint(20) DEFAULT NULL COMMENT '前一个节点id',
`next_id` bigint(20) DEFAULT NULL COMMENT '后一个节点id',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标准目录表';

-- 标准映射表
CREATE TABLE `assets_standard_mapping` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`column_id` bigint(100) NOT NULL COMMENT '字段id',
`standard_id` bigint(100) NOT NULL COMMENT '标准id',
`data_source_type` int(11) NOT NULL COMMENT '数据源类型',
`match_status` tinyint(1) NOT NULL COMMENT '匹配状态 1字段名匹配，字段中文名不匹配 2字段中文名匹配，字段名不匹配 3字段名称均匹配，其他属性不匹配 4完全匹配',
`bind_status` tinyint(1) NOT NULL COMMENT '绑定状态,0未绑定,1已绑定',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`),
KEY `idx_column_id` (`column_id`) USING BTREE,
KEY `idx_standard_id` (`standard_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标准映射表';
