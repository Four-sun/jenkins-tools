ALTER TABLE dl_api MODIFY COLUMN group_id int(11) NULL COMMENT '群组id';

ALTER TABLE dl_project ADD api_data_source_id int(11) NULL COMMENT 'API访问数据源';
ALTER TABLE dl_project CHANGE api_data_source_id api_data_source_id int(11) NULL COMMENT 'API访问数据源' AFTER data_source_id;



INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('apiCallStatisticsJob', 'apiCallStatisticsJob', 'apiCallStatisticsJob', 'apiCallStatisticsJob',
        'com.dtstack.tagapp.param.schedule.impl.ApiCallStatisticsQuartz', '0 0 0 */1 * ?', 0, NULL, NULL, 'TAG', now(),
        now(), 0)
;


ALTER TABLE dl_project ADD data_source_api_id int(11) NULL COMMENT 'API访问数据源 在api中存储的id';

CREATE UNIQUE INDEX dl_api_call_statistic_count_tag_api_id_IDX USING BTREE ON dl_api_call_statistic_count (tag_api_id,tag_api_type,tag_id,business_time);