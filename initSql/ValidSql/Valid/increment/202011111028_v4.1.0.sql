-- 给定时任务表中添加monitorDataSyncDayJob和verifyDataSyncDayJob定时任务
INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('dq', '* * 2 * * ?', 'monitorDataSyncDayJob','monitorDataSyncDayJob','monitorDataSyncDayJobTrigger','monitorDataSyncDayJobTriggerGroup','com.dtstack.dq.schedule.job.MonitorDataSyncDayJob','0',null,null,now(),now(),'0'),
('dq', '* * 2 * * ?', 'verifyDataSyncDayJob','verifyDataSyncDayJob','verifyDataSyncDayJobTrigger','verifyDataSyncDayJobTriggerGroup','com.dtstack.dq.schedule.job.VerifyDataSyncDayJob','0',null,null,now(),now(),'0');

-- 修改dq_data_source中data_json字段类型
alter table dq_data_source modify data_json longtext COMMENT '链接数据源信息需要加密 json格式';

-- 删除dt_center_cron_schedule中monitorJob和verifyJob,monitorTriggerJob
delete from dt_center_cron_schedule where job_detail_name = 'monitorJob' and job_detail_group = 'MonitorJobGroup';
delete from dt_center_cron_schedule where job_detail_name = 'verifyJob' and job_detail_group = 'verifyJobGroup';
delete from dt_center_cron_schedule where job_detail_name = 'monitorTriggerJob' and job_detail_group = 'monitorTriggerJobGroup';