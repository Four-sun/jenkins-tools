ALTER TABLE `dl_tag`
    ADD COLUMN `status_update_time` datetime NULL COMMENT '标签状态更新时间';

ALTER TABLE `dl_tag`
    ADD COLUMN `tag_update_status_before` tinyint(1)  NULL COMMENT '前一次标签的更新状态 0 初始化 1未更新,2 更新中 3 更新完成 4 更新失败';

ALTER TABLE `dl_group`
    ADD COLUMN `group_current_partition` varchar(128) NULL COMMENT '当前可用分区';

ALTER TABLE `dl_group`
    ADD COLUMN `personalized` tinyint(1) default 0  NOT NULL COMMENT '是否应用群组个性化模版 0 未应用 1应用';

CREATE TABLE `dl_task_temp_job`
(
    `id`         int(11)                              NOT NULL AUTO_INCREMENT,
    `tenant_id`  int(11)                              NOT NULL COMMENT '租户id',
    `project_id` int(11)                              NOT NULL COMMENT '项目id',
    `entity_id`  int(11)                              NOT NULL COMMENT '实体id',
    `task_id`    int(11)                              NOT NULL COMMENT '任务id',
    `job_id`     varchar(255)                         NULL COMMENT '调度jobId',
    `partition_value`   varchar(255)                  NULL COMMENT '分区值',
    `fill_task_name`  varchar(255)                    NULL COMMENT '补数据的调度任务名',
    `type`       int(11)                              NOT NULL COMMENT '调度类型,0:补数据，1:临时',
    `create_at`  datetime   default CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    `update_at`  datetime   default CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`  int(11)    default 0                 NOT NULL comment '创建的用户',
    `update_by`  int(11)    default 0                 NOT NULL COMMENT '修改的用户',
    `is_deleted` tinyint(1) default 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='临时任务表';

INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('tagUpdateStatusJob', 'tagUpdateStatusJob', 'tagUpdateStatusJob', 'tagUpdateStatusJob',
        'com.dtstack.tagapp.param.schedule.impl.TagUpdateStatusQuartz', '0 0/10 * * * ?', 0, NULL, NULL, 'TAG', now(),
        now(), 0);