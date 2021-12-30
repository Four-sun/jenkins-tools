UPDATE rdos_batch_task_resource
SET is_deleted=1 WHERE task_id IN (
    SELECT id FROM rdos_batch_task WHERE is_deleted=1) AND is_deleted=0;