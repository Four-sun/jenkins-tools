-- 更新之前因为update而导致的submitStatus=0的bug
update  rdos_batch_task set submit_status = 1
where submit_status = 0 and is_deleted = 0 and id in (select id from rdos_batch_task_shade where is_deleted = 0)