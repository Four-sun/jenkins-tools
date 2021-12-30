alter table rdos_stream_task_resource add is_addition_resource tinyint(1) default 2 not null comment '是否属于附加资源;1:附加资源,2:非附加资源';
ALTER TABLE rdos_stream_task_resource DROP INDEX `index_project_task_resource_id`;
ALTER TABLE rdos_stream_task_resource ADD INDEX `index_project_task_resource_id_addition` (`project_id`,`task_id`,`resource_id`,`is_addition_resource`);