ALTER TABLE dl_table_sync ADD cancel_delayed int(2) DEFAULT 0 COMMENT '延时任务是否需要 0 false，1 true';

ALTER TABLE dl_task_temp_job ADD parent_temp_task_ids varchar(255) DEFAULT NULL COMMENT '临时任务的上游临时任务ids';
ALTER TABLE dl_task_temp_job ADD temp_task_submit_status int(2) DEFAULT NULL COMMENT '当前任务的提交状态';


INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('tagTaskFillDataJob', 'tagTaskFillDataJob', 'tagTaskFillDataJob', 'tagTaskFillDataJob',
        'com.dtstack.tagapp.param.schedule.impl.TagTaskFillDataQuartz', '0 0/3 * * * ?', 0, NULL, NULL, 'TAG', now(),
        now(), 0);


update dt_pub_service.`dsc_info` set data_type_code = 48 where data_type = 'Presto';


ALTER TABLE dl_tag_tagsql ADD task_name varchar(255) DEFAULT NULL COMMENT '自定义sql任务名称';

update dl_task_temp_job set temp_task_submit_status = 1;