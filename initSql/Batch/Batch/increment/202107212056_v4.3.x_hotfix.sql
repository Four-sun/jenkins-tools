-- 删除task_task 历史伪删除记录
delete from rdos_batch_task_task where is_deleted = 1;

-- 删除tasktask不适合的索引
ALTER TABLE`rdos_batch_task_task`
DROP INDEX `index_batch_task_task`;

-- 新增加索引
ALTER TABLE`rdos_batch_task_task`
ADD UNIQUE INDEX `index_batch_task_task`(`task_id`, `parent_task_id`, `parent_apptype`) USING BTREE;