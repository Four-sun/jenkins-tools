INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified, is_deleted)
VALUES ('batchDeleteProjectJob', 'batchDeleteProjectJobGroup', 'batchDeleteProjectJobTrigger', 'batchDeleteProjectJobTriggerGroup',
    'com.dtstack.batch.job.BatchDeleteProjectJob', '0 0 0/12 * * ?', 0, NULL, NULL, 'rdos', now(), now(), 0);