ALTER TABLE dl_tag ADD tag_update_status TINYINT(1) DEFAULT '1' COMMENT '更新状态 1 初始化 2 更新中 3 更新完成 4 更新失败';
ALTER TABLE dl_tag CHANGE tag_update_status tag_update_status TINYINT(1) DEFAULT '1' COMMENT '更新状态 1 初始化 2 更新中 3 更新完成 4 更新失败' AFTER tag_type;

INSERT INTO `dt_center_cron_schedule` ( `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES ('entityDataTimeOutDeleteJob', 'entityDataTimeOutDeleteJob', 'entityDataTimeOutDeleteJob', 'entityDataTimeOutDeleteJob', 'com.dtstack.tagapp.param.schedule.impl.EntityDataTimeOutDeleteQuartz', '0 0 1 * * ?', '0', 'TAG', '2020-11-02 10:34:57', '2021-01-13 13:43:10', '0');
