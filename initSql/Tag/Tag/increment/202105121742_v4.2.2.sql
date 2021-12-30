INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('syncTagValueJob', 'syncTagValueJob', 'syncTagValueJob', 'syncTagValueJob',
        'com.dtstack.tagapp.param.schedule.impl.TagValueSyncDataQuartz', '0 0 3 * * ?', 0, NULL, NULL, 'TAG', now(),
        now(), 0);
alter table dl_tag_tagsql
    modify column tagsql text;
alter table dl_tag_tagsql_temp
    modify column tagsql text;
alter table dl_tag_tagsql
    add temp_table_id int(11) DEFAULT 0 NULL COMMENT '临时表id';
alter table dl_tag_tagsql
    add column is_delete int(11) DEFAULT 0 NULL;
ALTER TABLE dl_tag_tagsql
    ADD annotate_tagsql varchar(255) DEFAULT NULL COMMENT '含有注释的sql';
ALTER TABLE dl_tag_tagsql
    ADD primary_key varchar(255) DEFAULT NULL COMMENT '当前sql的主键或者关联键';
ALTER TABLE dl_tag_tagsql
    ADD primary_table_name varchar(255) DEFAULT NULL COMMENT '需要关联的表';
alter table dl_tag_tagsql
    modify column annotate_tagsql text

