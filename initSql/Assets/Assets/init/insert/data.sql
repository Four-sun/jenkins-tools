-- 权限
INSERT INTO assets_role(id, create_at, update_at, create_by, update_by, is_deleted, tenant_id, role_name, role_type, role_value, role_desc)values
(1,now(),now(),0,0,0,-1,'租户所有者',1,1,'具有本租户内的最高权限'),
(2,now(),now(),0,0,0,-1,'管理员',1,2,'具有产品内所有功能权限'),
(3,now(),now(),0,0,0,-1,'数据开发',1,3,'具有资产盘点、元数据、数据资源和数据模型模块的部分权限'),
(4,now(),now(),0,0,0,-1,'访客',1,4,'具有资产盘点和数据资源模块的部分权限'),
(5,now(),now(),0,0,0,-1,'租户管理员',1,5,'具有产品内所有功能权限');

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
(506,'platformMgr_dataAuthMgr','平台管理_数据权限管理','数据权限管理',500,1),
(600,'indexLocation','首页定位','首页定位',1,1),
(601,'indexLocation_index2dataResource','首页定位_至数据资源','至数据资源',600,1),
(602,'indexLocation_index2dmap','首页定位_至数据地图','至数据地图',600,1),
(700,'dataModel','数据模型','数据模型',1,1),
(701,'dataModel_createTable','数据模型_标准化建表','标准化建表',700,1),
(702,'dataModel_createTable_flink','数据模型_标准化建表_Flink表','Flink表',701,1);

INSERT INTO assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id) values
(now(),now(),0,0,0,1,1),
(now(),now(),0,0,0,1,100),
(now(),now(),0,0,0,1,200),
(now(),now(),0,0,0,1,201),
(now(),now(),0,0,0,1,202),
(now(),now(),0,0,0,1,203),
(now(),now(),0,0,0,1,204),
(now(),now(),0,0,0,1,205),
(now(),now(),0,0,0,1,206),
(now(),now(),0,0,0,1,207),
(now(),now(),0,0,0,1,208),
(now(),now(),0,0,0,1,209),
(now(),now(),0,0,0,1,210),
(now(),now(),0,0,0,1,211),
(now(),now(),0,0,0,1,212),
(now(),now(),0,0,0,1,213),
(now(),now(),0,0,0,1,214),
(now(),now(),0,0,0,1,215),
(now(),now(),0,0,0,1,216),
(now(),now(),0,0,0,1,300),
(now(),now(),0,0,0,1,301),
(now(),now(),0,0,0,1,302),
(now(),now(),0,0,0,1,303),
(now(),now(),0,0,0,1,400),
(now(),now(),0,0,0,1,401),
(now(),now(),0,0,0,1,402),
(now(),now(),0,0,0,1,500),
(now(),now(),0,0,0,1,501),
(now(),now(),0,0,0,1,502),
(now(),now(),0,0,0,1,503),
(now(),now(),0,0,0,1,504),
(now(),now(),0,0,0,1,505),
(now(),now(),0,0,0,1,506),
(now(),now(),0,0,0,1,600),
(now(),now(),0,0,0,1,602),
(now(),now(),0,0,0,1,700),
(now(),now(),0,0,0,1,701),
(now(),now(),0,0,0,1,702),

(now(),now(),0,0,0,2,1),
(now(),now(),0,0,0,2,100),
(now(),now(),0,0,0,2,200),
(now(),now(),0,0,0,2,201),
(now(),now(),0,0,0,2,202),
(now(),now(),0,0,0,2,203),
(now(),now(),0,0,0,2,204),
(now(),now(),0,0,0,2,205),
(now(),now(),0,0,0,2,206),
(now(),now(),0,0,0,2,207),
(now(),now(),0,0,0,2,208),
(now(),now(),0,0,0,2,209),
(now(),now(),0,0,0,2,210),
(now(),now(),0,0,0,2,211),
(now(),now(),0,0,0,2,212),
(now(),now(),0,0,0,2,213),
(now(),now(),0,0,0,2,214),
(now(),now(),0,0,0,2,215),
(now(),now(),0,0,0,2,216),
(now(),now(),0,0,0,2,300),
(now(),now(),0,0,0,2,301),
(now(),now(),0,0,0,2,302),
(now(),now(),0,0,0,2,303),
(now(),now(),0,0,0,2,400),
(now(),now(),0,0,0,2,401),
(now(),now(),0,0,0,2,402),
(now(),now(),0,0,0,2,500),
(now(),now(),0,0,0,2,501),
(now(),now(),0,0,0,2,502),
(now(),now(),0,0,0,2,503),
(now(),now(),0,0,0,2,504),
(now(),now(),0,0,0,2,505),
(now(),now(),0,0,0,2,506),
(now(),now(),0,0,0,2,600),
(now(),now(),0,0,0,2,602),
(now(),now(),0,0,0,2,700),
(now(),now(),0,0,0,2,701),
(now(),now(),0,0,0,2,702),

(now(),now(),0,0,0,3,1),
(now(),now(),0,0,0,3,100),
(now(),now(),0,0,0,3,200),
(now(),now(),0,0,0,3,201),
(now(),now(),0,0,0,3,202),
(now(),now(),0,0,0,3,203),
(now(),now(),0,0,0,3,204),
(now(),now(),0,0,0,3,205),
(now(),now(),0,0,0,3,206),
(now(),now(),0,0,0,3,207),
(now(),now(),0,0,0,3,208),
(now(),now(),0,0,0,3,209),
(now(),now(),0,0,0,3,211),
(now(),now(),0,0,0,3,213),
(now(),now(),0,0,0,3,300),
(now(),now(),0,0,0,3,301),
(now(),now(),0,0,0,3,303),
(now(),now(),0,0,0,3,600),
(now(),now(),0,0,0,3,602),
(now(),now(),0,0,0,3,700),
(now(),now(),0,0,0,3,701),
(now(),now(),0,0,0,3,702),

(now(),now(),0,0,0,4,1),
(now(),now(),0,0,0,4,100),
(now(),now(),0,0,0,4,209),
(now(),now(),0,0,0,4,300),
(now(),now(),0,0,0,4,301),
(now(),now(),0,0,0,4,600),
(now(),now(),0,0,0,4,601),

(now(),now(),0,0,0,5,1),
(now(),now(),0,0,0,5,100),
(now(),now(),0,0,0,5,200),
(now(),now(),0,0,0,5,201),
(now(),now(),0,0,0,5,202),
(now(),now(),0,0,0,5,203),
(now(),now(),0,0,0,5,204),
(now(),now(),0,0,0,5,205),
(now(),now(),0,0,0,5,206),
(now(),now(),0,0,0,5,207),
(now(),now(),0,0,0,5,208),
(now(),now(),0,0,0,5,209),
(now(),now(),0,0,0,5,210),
(now(),now(),0,0,0,5,211),
(now(),now(),0,0,0,5,212),
(now(),now(),0,0,0,5,213),
(now(),now(),0,0,0,5,214),
(now(),now(),0,0,0,5,215),
(now(),now(),0,0,0,5,216),
(now(),now(),0,0,0,5,300),
(now(),now(),0,0,0,5,301),
(now(),now(),0,0,0,5,302),
(now(),now(),0,0,0,5,303),
(now(),now(),0,0,0,5,400),
(now(),now(),0,0,0,5,401),
(now(),now(),0,0,0,5,402),
(now(),now(),0,0,0,5,500),
(now(),now(),0,0,0,5,501),
(now(),now(),0,0,0,5,502),
(now(),now(),0,0,0,5,503),
(now(),now(),0,0,0,5,504),
(now(),now(),0,0,0,5,505),
(now(),now(),0,0,0,5,506),
(now(),now(),0,0,0,5,600),
(now(),now(),0,0,0,5,602),
(now(),now(),0,0,0,5,700),
(now(),now(),0,0,0,5,701),
(now(),now(),0,0,0,5,702);


-- 插入预设模型属性数据
-- SparkThrift预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 45, 0, 1),
('data_base', '数据库', 0, 6, 45, 0, 2),
('create_time', '表创建时间', 0, 5, 45, 0, 3),
('ddl_update_time', 'DDL最后变更时间', 0, 5, 45, 0, 4),
('storage_location', '存储位置', 0, 6, 45, 0, 5),
('storage_size', '存储大小', 0, 7, 45, 0, 6),
('recent_sync_time', '最近同步时间', 0, 5, 45, 0, 7),
('manager', '负责人', 1, 1, 45, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 45, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 45, 0, 3);
-- Mysql预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 1, 0, 1),
('data_base', '数据库', 0, 6, 1, 0, 2),
('engine', '引擎', 0, 6, 1, 0, 3),
('row_format', '行格式', 0, 6, 1, 0, 4),
('row_count', '表行数', 0, 6, 1, 0, 5),
('storage_size', '存储大小', 0, 7, 1, 0, 6),
('create_time', '创建时间', 0, 5, 1, 0, 7),
('recent_sync_time', '最近同步时间', 0, 5, 1, 0, 8),
('manager', '负责人', 1, 1, 1, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 1, 1, 2);
-- Oracle预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 2, 0, 1),
('data_base', '数据库', 0, 6, 2, 0, 2),
('row_count', '表行数', 0, 6, 2, 0, 4),
('storage_size', '存储大小', 0, 7, 2, 0, 5),
('create_time', '创建时间', 0, 5, 2, 0, 6),
('recent_sync_time', '最近同步时间', 0, 5, 2, 0, 7),
('manager', '负责人', 1, 1, 2, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 2, 1, 2);
-- Hive2预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 7, 0, 1),
('data_base', '数据库', 0, 6, 7, 0, 2),
('create_time', '表创建时间', 0, 5, 7, 0, 3),
('ddl_update_time', 'DDL最后变更时间', 0, 5, 7, 0, 4),
('storage_location', '存储位置', 0, 6, 7, 0, 5),
('storage_size', '存储大小', 0, 7, 7, 0, 6),
('recent_sync_time', '最近同步时间', 0, 5, 7, 0, 7),
('manager', '负责人', 1, 1, 7, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 7, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 7, 0, 3);
-- TiDB预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 31, 0, 1),
('data_base', '数据库', 0, 6, 31, 0, 2),
('row_count', '表行数', 0, 6, 31, 0, 3),
('create_time', '创建时间', 0, 5, 31, 0, 4),
('storage_size', '存储大小', 0, 7, 31, 0, 5),
('recent_sync_time', '最近同步时间', 0, 5, 31, 0, 6),
('manager', '负责人', 1, 1, 31, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 31, 1, 2);

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
('recent_sync_time', '最近同步时间', 0, 5, 27, 0, 7),
('manager', '负责人', 1, 1, 27, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 27, 1, 2),
('partition_life', '分区保留策略(个)', 1, 4, 27, 0, 3);

-- SQL Server预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 3, 0, 1),
('data_base', '数据库', 0, 6, 3, 0, 2),
('table_schema', '表架构', 0, 6, 3, 0, 3),
('row_count', '表行数', 0, 6, 3, 0, 4),
('storage_size', '存储大小', 0, 7, 3, 0, 5),
('create_time', '创建时间', 0, 5, 3, 0, 6),
('recent_sync_time', '最近同步时间', 0, 5, 3, 0, 7),
('manager', '负责人', 1, 1, 3, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 3, 1, 2);

-- Phoenix预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 38, 0, 1),
('namespace', '命名空间', 0, 6, 38, 0, 2),
('create_time', '表创建时间', 0, 5, 38, 0, 3),
('storage_size', '存储大小', 0, 7, 38, 0, 4),
('recent_sync_time', '最近同步时间', 0, 5, 38, 0, 5),
('manager', '负责人', 1, 1, 38, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 38, 1, 2);

-- HBase1预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 8, 0, 1),
('namespace', '命名空间', 0, 6, 8, 0, 2),
('create_time', '表创建时间', 0, 5, 8, 0, 3),
('region_count', 'region数量', 0, 6, 8, 0, 4),
('storage_size', '存储大小', 0, 7, 8, 0, 5),
('recent_sync_time', '最近同步时间', 0, 5, 8, 0, 6),
('manager', '负责人', 1, 1, 8, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 8, 1, 2);

-- Vertica预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 43, 0, 1),
('data_base', '数据库', 0, 6, 43, 0, 2),
('create_time', '表创建时间', 0, 5, 43, 0, 3),
('storage_size', '存储大小', 0, 7, 43, 0, 4),
('recent_sync_time', '最近同步时间', 0, 5, 43, 0, 5),
('manager', '负责人', 1, 1, 43, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 43, 1, 2);

INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (1, 'dataSourceStatusJob', 'dataSourceStatusJobGroup', 'dataSourceStatusTrigger', 'dataSourceStatusJobGroup', 'com.dtstack.assets.service.schedule.job.DataSourceStatusJob', '0 */30 * * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (3, 'dataSourceDataSyncJob', 'dataSourceDataSyncJobGroup', 'dataSourceDataSyncTrigger', 'dataSourceDataSyncJobGroup', 'com.dtstack.assets.service.schedule.job.DataSourceDataSyncJob', '0 0 1 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (4, 'dropHivePartitionJob', 'dropHivePartitionJobGroup', 'dropHivePartitionTrigger', 'dropHivePartitionJobGroup', 'com.dtstack.assets.service.schedule.job.DropHivePartitionJob', '0 0 0 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (5, 'dataSourceSyncStatusJob', 'dataSourceSyncStatusJobGroup', 'dataSourceSyncStatusJobTrigger', 'dataSourceSyncStatusJobGroup', 'com.dtstack.assets.service.schedule.job.DataSourceSyncStatusJob', '0 */5 * * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (6, 'dataStatisticJob', 'dataStatisticJobGroup', 'dataStatisticJobTrigger', 'dataStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.DataStatisticJob', '0 30 23 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (7, 'syncPeriodTaskJob', 'syncPeriodTaskJobGroup', 'syncPeriodTaskJobTrigger', 'syncPeriodTaskJobGroup', 'com.dtstack.assets.service.schedule.job.SyncPeriodTaskJob', '0 0 23 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (8, 'affectCountStatisticJob', 'affectCountStatisticJobGroup', 'affectCountStatisticJobTrigger', 'affectCountStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.AffectCountStatisticJob', '0 0 18 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (10, 'attributeFillRateStatisticJob', 'attributeFillRateStatisticJobGroup', 'attributeFillRateStatisticJobTrigger', 'attributeFillRateStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.AttributeFillRateStatisticJob', '0 50 23 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (11, 'dbLineageStatisticsJob', 'dbLineageStatisticsJobGroup', 'dbLineageStatisticsJobTrigger', 'dbLineageStatisticsJobGroup', 'com.dtstack.assets.service.schedule.job.DbLineageStatisticsJob', '0 0 3 * * ?', 0, NULL, NULL, 'assets', '2020-07-16 19:56:40', '2020-07-16 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (12, 'dataMaskingLineageSyncJob', 'dataMaskingLineageSyncJobGroup', 'dataMaskingLineageSyncJobTrigger', 'dataMaskingLineageSyncJobGroup', 'com.dtstack.assets.service.schedule.job.DataMaskingLineageSyncJob', '0 0 4 * * ?', 0, NULL, NULL, 'assets', '2020-11-17 19:56:40', '2020-11-17 19:56:40', 0);
INSERT INTO `dt_center_cron_schedule` (`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (15, 'syncUserJob', 'syncUserJobGroup', 'syncUserJobTrigger', 'syncUserJobGroup', 'com.dtstack.assets.service.schedule.job.SyncUserJob', '0 0 5 * * ?', 0, NULL, NULL, 'assets', '2020-11-17 19:56:40', '2020-11-17 19:56:40', 0);

-- 字段预设模型属性
-- SparkThrift
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 45, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 45, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 45, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 45, 1, 1 );
-- Hive2
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 7, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 7, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 7, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 7, 1, 1 );
-- Hive1
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 27, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 27, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 27, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 27, 1, 1 );
-- MySQL
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 1, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 1, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 1, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 1, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 1, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 1, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 1, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 1, 1, 1 );
-- Oracle
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 2, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 2, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 2, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 2, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 2, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 2, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 2, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 2, 1, 1 );
-- SQL Server
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 3, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 3, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 3, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 3, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 3, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 3, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 3, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 3, 1, 1 );
-- TiDB
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 31, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 31, 0, 2 ),
( 'column_comment', '注释', 0, 6, 2, 31, 0, 3 ),
( 'data_length', '字段最大长度', 0, 6, 2, 31, 0, 4 ),
( 'column_key', '主键标识Y/N', 0, 6, 2, 31, 0, 5 ),
( 'is_nullable', '可空标识Y/N', 0, 6, 2, 31, 0, 6 ),
( 'column_default', '默认值', 0, 6, 2, 31, 0, 7 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 31, 1, 1 );

-- Phoenix预设字段模型属性
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 38, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 38, 0, 2 ),
( 'is_primary_key', '是否主键', 0, 6, 2, 38, 0, 3 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 38, 1, 1 );

-- HBase1预设字段模型属性
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_family', '列族', 0, 6, 2, 8, 0, 1 ),
( 'column_family_cn', '列族中文名', 1, 2, 2, 8, 1, 1 );

-- Vertica预设字段模型属性
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 43, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 43, 0, 2 ),
( 'is_nullable', '是否可空', 0, 6, 2, 43, 0, 3 ),
( 'column_default', '默认值', 0, 6, 2, 43, 0, 4 ),
( 'column_comment', '字段注释', 0, 6, 2, 43, 0, 5 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 43, 1, 1 );

-- Kafka2.x预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('topic', 'topic名称', 0, 6, 37, 0, 1),
('partition_count', '分区数量', 0, 6, 37, 0, 2),
('replication', '副本量', 0, 6, 37, 0, 3),
('manager', '负责人', 1, 1, 37, 1, 1),
('topic_cn', 'topic中文名', 1, 2, 37, 1, 2);

-- Kafka0.10预设模型属性
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('topic', 'topic名称', 0, 6, 17, 0, 1),
('partition_count', '分区数量', 0, 6, 17, 0, 2),
('replication', '副本量', 0, 6, 17, 0, 3),
('manager', '负责人', 1, 1, 17, 1, 1),
('topic_cn', 'topic中文名', 1, 2, 17, 1, 2);

-- Flink预设模型属性
-- 添加Flink表预设元模型
INSERT INTO `assets_preset_model_attribute`
(`attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `data_source_type`, `is_required`, `sort_order`)
VALUES
('table_name', '表名', 0, 6, 201, 0, 1),
('data_base', '数据库', 0, 6, 201, 0, 2),
('mapping_type', '映射数据源类型', 0, 6, 201, 0, 3),
('mapping_resource', '映射数据源', 0, 6, 201, 0, 4),
('mapping_table', '映射表(Topic)', 0, 6, 201, 0, 5),
('create_time', '创建时间', 0, 5, 201, 0, 6),
('manager', '负责人', 1, 1, 201, 1, 1),
('tb_name_cn', '表中文名', 1, 2, 201, 1, 2);

-- 添加Flink字段预设元模型
INSERT INTO `assets_preset_model_attribute` ( `attribute_name`, `attribute_name_cn`, `attribute_type`, `field_type`, `meta_data_type`, `data_source_type`, `is_required`, `sort_order` )
VALUES
( 'column_name', '字段名', 0, 6, 2, 201, 0, 1 ),
( 'data_type', '数据类型', 0, 6, 2, 201, 0, 2 ),
( 'column_name_cn', '字段中文名', 1, 2, 2, 201, 1, 3 ),
( 'key', 'flink源表结构key', 0, 6, 2, 201, 0, 4 );
