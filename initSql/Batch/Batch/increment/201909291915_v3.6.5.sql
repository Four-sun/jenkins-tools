
alter table rdos_batch_table_table add task_id int default 0 not null comment '所属任务' after project_id;
