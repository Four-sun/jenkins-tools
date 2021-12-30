ALTER TABLE `rdos_stream_task_shade`
    ADD COLUMN `create_model` tinyint(1) COMMENT '任务模式 0 向导模式  1 脚本模式';

update
 `rdos_stream_task_shade`
set
 `create_model` = 1
 where
 `task_id`
 in
 (select `task_id` from (select ts.`task_id` from `rdos_stream_task_shade` as ts
  join `rdos_stream_task` as t on ts.`task_id` = t.`task_id` and t.`create_model` = 1) as tmp);
