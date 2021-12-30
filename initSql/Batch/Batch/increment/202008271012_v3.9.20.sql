-- 针对达摩接口慢优化sql
-- 4.0及以上版本没有rdos_engine_job、rdos_batch_job，不需要执行，只保留rdos_batch_task_version
alter table rdos_batch_task_version add index ind_taskId(task_id);