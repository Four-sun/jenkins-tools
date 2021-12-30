-- 增加索引，如果索引增加失败，则说明当前客户同一个项目下面存在多个同名的任务，看 SQL 提示修改对应的任务
ALTER TABLE `rdos_stream_task`
DROP INDEX `index_name`,
ADD UNIQUE INDEX `index_name`(`project_id`, `name`(128)) USING BTREE;