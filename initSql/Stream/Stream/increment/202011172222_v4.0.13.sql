-- 数据处理 只能执行一次数据处理 SQL
UPDATE `rdos_stream_task` SET `name` = CONCAT(`name`, '_', `id`)
where `is_deleted` = 1;