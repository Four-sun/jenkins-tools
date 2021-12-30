alter table rdos_batch_job drop key idx_jobKey;
alter table rdos_batch_job add unique idx_jobKey(`job_key`(255)) ;
