INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('stream', '*/10 * * * * ?', 'streamAlarmJob', 'StreamAlarmJobGroup', 'StreamAlarmTrigger', 'StreamAlarmTriggerGroup', 'com.dtstack.streamapp.quartz.job.StreamAlarmJob', '0', null, null, now(), now(), '0'),
('stream', '0 0/1 * * * ?', 'streamStrategyJob', 'streamStrategyJob', 'streamStrategyJobTrigger', 'streamStrategyJobTriggerGroup', 'com.dtstack.streamapp.quartz.job.StreamStrategyJob', '0', null, null, now(), now(), '0'),
('stream', '0 0 0 */1 * ?', 'StreamResourceCleanUpJob', 'StreamResourceCleanUpJob', 'StreamResourceCleanUpJobTrigger', 'StreamResourceCleanUpJobTriggerGroup', 'com.dtstack.streamapp.quartz.job.StreamResourceCleanUpJob', '0', null, null, now(), now(), '0');