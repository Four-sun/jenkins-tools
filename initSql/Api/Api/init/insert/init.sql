INSERT INTO `da_role` VALUES ('1', '-1', '租户所有者', '1', '1', '本项目内的全部权限，具有本租户内的最高权限', '0', now(), now(), '0',-1);
INSERT INTO `da_role` VALUES ('2', '-1', 'API管理员', '1', '2', 'API管理者，可进行API创建、发布、导入导出、管理、授权审批、用户管理，但不具备项目配置权限', '0', now(), now(), '0',-1);
INSERT INTO `da_role` VALUES ('4', '-1', '访客', '1', '3', '可查看概览、API市场、我的API模块', '0', now(), now(), '0',-1);
INSERT INTO `da_role` VALUES ('3', '-1', '应用开发', '1', '4', 'API的使用者，可查看概览（仅看到自己的API）、API市场、我的API模块，不能创建/编辑API，不能对用户进行管理', '0', now(), now(), '0',-1);
-- 增加数据开发角色 （数据开发的api管理权限中，查看、编辑权限都有。但数据开发只能编辑、发布、禁用、启用自己创建的api，不能修改和管理他人的API，但可查看他人的API信息）
INSERT INTO `da_role` VALUES ('5', '-1', '数据开发', '1', '5', '可进行API生成、发布、申请，但不具备API管理、授权审批、用户管理权限', '0', now(), now(), '0',-1);
INSERT INTO da_role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id,project_id)
VALUES (6,-1, '项目所有者', 1, 6, '项目空间创建者，拥有项目空间内的最高权限，可对项目空间中的全部资源和项目成员进行管理', 0,-1);
INSERT INTO da_role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id,project_id)
VALUES (7,-1, '项目管理员', 1, 7, '项目空间管理员，可对项目空间中所有数据源、API、项目成员进行管理。项目管理员不能对项目所有者操作', 0,-1);
-- 增加租户管理员，权限与租户所有者相同
INSERT INTO da_role (id, tenant_id, role_name, role_value, role_desc, modify_user_id, is_deleted, project_id) VALUES (8, -1, '租户管理员', 8, '本项目内的全部权限，具有本租户内的全部权限，但不能对租户所有者操作', 0, 0, -1);

-- 增加数据源类型
INSERT INTO `da_dict` VALUES ('1', '1', 'MySQL', '1', 'MySQL', 'MySQL', '1', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('2', '1', 'Oracle', '2', 'Oracle', 'Oracle', '2', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('3', '1', 'SQLServer', '3', 'SQLServer', 'SQLServer', '3', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('4', '1', 'AnalyticDB', '15', 'AnalyticDB', 'AnalyticDB', '4', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('5', '1', 'PostgreSQL', '4', 'PostgreSQL', 'PostgreSQL', '5', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('6', '1', 'Impala', '29', 'Impala', 'Impala', '6', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('8', '1', 'DB2', '19', 'DB2', 'DB2', '8', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('9', '1', 'Kylin', '23', 'Kylin', 'Kylin', '9', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('10', '1', 'TiDB', '31', 'TiDB', 'TiDB', '10', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('11', '1', 'MongoDB', '13', 'MongoDB', 'MongoDB', '11', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('12', '1', 'ElasticSearch7', '11', 'ElasticSearch7', 'ElasticSearch7', '12', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('13', '1', 'ElasticSearch6', '33', 'ElasticSearch6', 'ElasticSearch6', '13', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('14', '1', 'HBase1.x', '8', 'HBase1.x', 'HBase1.x', '14', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('15', '1', 'HBase2.x', '39', 'HBase2.x', 'HBase2.x', '15', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('16', '1', 'KingbaseES8', '40', 'KingbaseES8', 'KingbaseES8', '16', now(), now(), '0');

-- 无法插入id为0的记录，手动将初始化记录的id更新为0
INSERT INTO `da_api_catalogue`(tenant_id, pid, node_name, order_val, level, gmt_create, gmt_modified, is_deleted) VALUES ('0' , '-1', 'API管理', '0', '0', now(), now(), '0');
UPDATE da_api_catalogue SET id=0 WHERE id=(SELECT id FROM (SELECT MAX(id) AS id FROM da_api_catalogue) AS temp);

-- 定时调度任务
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (1, 'apiInvokeCalculateJob', 'apiInvokeCalculateJob', 'apiInvokeCalculateJobTrigger', 'apiInvokeCalculateJobTriggerGroup', 'com.dtstack.da.schedule.job.InvokeCalculateJob', '1 * * * * ?', 0, NULL, NULL, 'api', now(), now(), 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (3, 'apiDataSourceJob', 'apiDataSourceJob', 'apiDataSourceJobTrigger', 'apiDataSourceJobTriggerGroup', 'com.dtstack.da.schedule.job.ApiDataSourceJob', '*/10 * * * * ?', 0, NULL, NULL, 'api', now(), now(), 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (5, 'apiCacheJob', 'apiCacheJob', 'apiCacheJobTrigger', 'apiCacheJobTriggerGroup', 'com.dtstack.da.schedule.job.ApiCacheJob', '0 * * * * ? *', 0, NULL, NULL, 'api', now(), now(), 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (7, 'apiInvokeCountDayJob', 'apiInvokeCountDayJob', 'apiInvokeCountDayJobTrigger', 'apiInvokeCountDayJobTriggerGroup', 'com.dtstack.da.schedule.job.InvokeCountDayJob', '1 0 0 * * ? ', 0, NULL, NULL, 'api', now(), now(), 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (8, 'alarmJob', 'alarmJob', 'alarmJobTrigger', 'alarmJobTriggerGroup', 'com.dtstack.da.schedule.job.AlarmJob', '0 * * * * ? ', 0, NULL, NULL, 'api', now(), now(), 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (9, 'sendAlarmJob', 'sendAlarmJob', 'sendAlarmJobTrigger', 'sendAlarmJobTriggerGroup', 'com.dtstack.da.schedule.job.SendAlarmJob', '0 * * * * ? ', 0, NULL, NULL, 'api', now(), now(), 0);

