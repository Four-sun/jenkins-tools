-- 表里新增周期类型
alter table rdos_batch_job add period_type tinyint(2) NOT NULL COMMENT '周期类型';
-- 同步老数据 更新周期类型
update  rdos_batch_job a left join rdos_batch_task_shade b on a.task_id =b.id
set a.period_type=b.period_type ;