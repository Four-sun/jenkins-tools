
ALTER TABLE `assets_sync_job`
    ADD  `exec_start_time`  datetime  DEFAULT NULL COMMENT '任务开始时间' AFTER  `plan_date`,
    ADD  `exec_end_time` datetime DEFAULT NULL COMMENT '任务结束时间' AFTER `exec_start_time`;

update assets_sync_job set exec_start_time= create_at,exec_end_time= update_at;
