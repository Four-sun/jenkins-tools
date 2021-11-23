ALTER TABLE dl_tag_tagsql_temp
    ADD column project_id int(11) DEFAULT NULL;
ALTER TABLE dl_tag_tagsql_temp
    ADD column is_deleted int(255) default 0 null comment '临时表删除标记';
INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('cleanTempTableJob', 'cleanTempTableJob', 'cleanTempTableJob', 'cleanTempTableJob',
        'com.dtstack.tagapp.param.schedule.impl.CleanTempTableQuartz', '0 0 3 * * ?', 0, NULL, NULL, 'TAG', now(),
        now(), 0);
