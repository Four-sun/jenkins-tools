INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('hbaseJob', 'hbaseJob', 'hbaseJob', 'hbaseJob',
        'com.dtstack.tagapp.param.schedule.impl.HbaseQuartz', '0 0 0 * * ?', 0, NULL, NULL, 'TAG', now(),
        now(), 0);