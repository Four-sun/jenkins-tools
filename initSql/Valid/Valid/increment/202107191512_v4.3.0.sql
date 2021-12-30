-- 质量4.3.x版本升级
-- 从当前4.3版本起，不会再维护初始化sql
-- 更新规则类型
ALTER TABLE dq_monitor_rule ADD COLUMN is_custom tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为自定义sql规则：0-非自定义sql规则，1-自定义sql规则';
-- 删除原始回调策略MonitorDataSyncJob(单表回调)
delete from dt_center_cron_schedule where job_detail_name = 'monitorDataSyncJob';
delete from qrtz_cron_triggers where TRIGGER_NAME= 'monitorDataSyncTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'monitorDataSyncTrigger';
delete from qrtz_job_details where JOB_NAME= 'monitorDataSyncJob';
delete from qrtz_simprop_triggers where TRIGGER_NAME= 'monitorDataSyncTrigger';
delete from qrtz_simple_triggers where TRIGGER_NAME= 'monitorDataSyncTrigger';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'monitorDataSyncTrigger';
delete from qrtz_blob_triggers where TRIGGER_NAME= 'monitorDataSyncTrigger';
-- 删除原始回调策略StreamDataSyncJob(实时校验回调)
delete from dt_center_cron_schedule where job_detail_name = 'streamDataSyncJob';
delete from qrtz_cron_triggers where TRIGGER_NAME= 'streamDataSyncJobTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'streamDataSyncJobTrigger';
delete from qrtz_job_details where JOB_NAME= 'streamDataSyncJob';
delete from qrtz_simprop_triggers where TRIGGER_NAME= 'streamDataSyncJobTrigger';
delete from qrtz_simple_triggers where TRIGGER_NAME= 'streamDataSyncJobTrigger';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'streamDataSyncJobTrigger';
delete from qrtz_blob_triggers where TRIGGER_NAME= 'streamDataSyncJobTrigger';
-- 删除原始回调策略verifyLifecycleJob(无用)
delete from dt_center_cron_schedule where job_detail_name = 'verifyLifecycleJob';
delete from qrtz_cron_triggers where TRIGGER_NAME= 'verifyLifecycleJobTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'verifyLifecycleJobTrigger';
delete from qrtz_job_details where JOB_NAME= 'verifyLifecycleJob';
delete from qrtz_simprop_triggers where TRIGGER_NAME= 'verifyLifecycleJobTrigger';
delete from qrtz_simple_triggers where TRIGGER_NAME= 'verifyLifecycleJobTrigger';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'verifyLifecycleJobTrigger';
delete from qrtz_blob_triggers where TRIGGER_NAME= 'verifyLifecycleJobTrigger';
-- 删除原始回调策略VerifyReportJob(多表校验回调)
delete from dt_center_cron_schedule where job_detail_name = 'verifyReportJob';
delete from qrtz_cron_triggers where TRIGGER_NAME= 'verifyReportJobTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'verifyReportJobTrigger';
delete from qrtz_job_details where JOB_NAME= 'verifyReportJob';
delete from qrtz_simprop_triggers where TRIGGER_NAME= 'verifyReportJobTrigger';
delete from qrtz_simple_triggers where TRIGGER_NAME= 'verifyReportJobTrigger';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'verifyReportJobTrigger';
delete from qrtz_blob_triggers where TRIGGER_NAME= 'verifyReportJobTrigger';

-- 新增规则包表dq_monitor_package
CREATE TABLE IF NOT EXISTS `dq_monitor_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `monitor_id` int(11) NOT NULL COMMENT '调度规则id(当前规则id为主监控id)',
  `package_name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '规则包名称（默认规则包x）',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建用户id',
  `modify_user_id` int(11) DEFAULT NULL COMMENT '修改用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(2) DEFAULT '0' COMMENT '删除标志0-正常。1-删除',
  `sql_text` longtext COLLATE utf8_bin COMMENT 'sql结果',
  `relation_monitor_id` int(11) DEFAULT NULL COMMENT '关联的所属规则id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- dq_monitor 新增对应规则包个数
alter table dq_monitor add column `package_count` int(11)  comment '拼接规则表个数';

-- dq_monitor_record 新增package_id,flow_job_id,task_type字段
alter table dq_monitor_record add column `package_id` int(11)  comment '所属规则包id';
alter table dq_monitor_record add column `flow_job_id` VARCHAR(256)  comment 'flow_job_id值';
alter table dq_monitor_record add column `task_type` tinyint(4)  comment '所属引擎类型';

-- dq_monitor_rule新增对应所属规则包
alter table dq_monitor_rule add column `package_id` int(11)  comment '所属规则包id';

-- 新增回调scheduleCallBackStatusJob
INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('dq', '*/10 * * * * ?', 'scheduleCallBackStatusJob','scheduleCallBackStatusJobGroup','scheduleCallBackStatusJobTrigger','scheduleCallBackStatusJobTriggerGroup','com.dtstack.dq.schedule.job.ScheduleCallBackStatusJob','0',null,null,now(),now(),'0');

-- 新增dq_monitor_record job_key 普通索引
alter table `dq_monitor_record` ADD INDEX idx_job_key_index (`job_key`);
