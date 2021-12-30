--  将select_sql表中的jobId和sqlId分离开
ALTER TABLE `rdos_batch_hive_select_sql` DROP INDEX `idx`;
ALTER TABLE `rdos_batch_hive_select_sql` ADD INDEX `idx`(`job_id`(128));
ALTER TABLE rdos_batch_hive_select_sql ADD COLUMN sql_id varchar(50) DEFAULT '' COMMENT 'sql任务多条运行时，没条sql有独立的id';

ALTER TABLE `rdos_datamask_parse_record` DROP INDEX `unique_job_id`;
ALTER TABLE `rdos_datamask_parse_record` ADD INDEX `job_id`(`job_id`);