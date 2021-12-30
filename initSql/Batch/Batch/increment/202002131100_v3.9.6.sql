ALTER TABLE `rdos_batch_job_job` ADD INDEX `idx_parent_job_key`(`parent_job_key`(255));
ALTER TABLE `rdos_batch_job` ADD INDEX `idx_flow_job_key`(flow_job_id(255));