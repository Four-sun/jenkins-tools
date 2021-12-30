alter table rdos_batch_task_resource add column resource_type int(11);
alter table rdos_batch_task_resource_shade add column resource_type int(11);

update rdos_batch_task_resource set resource_type = 1;
update rdos_batch_task_resource_shade set resource_type = 1;