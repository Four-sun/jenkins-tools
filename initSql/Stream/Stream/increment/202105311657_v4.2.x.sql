alter table `rdos_stream_task` add column `component_version` varchar(255) null comment '组件版本';
alter table `rdos_stream_task_shade` add column `component_version` varchar(255) null comment '组件版本';
alter table `rdos_stream_task_version` add column `component_version` varchar(255) null comment '组件版本';
update `rdos_stream_task` set `component_version` = '1.10' where is_deleted = 0;
update `rdos_stream_task_shade` set `component_version` = '1.10' where is_deleted = 0;
update `rdos_stream_task_version` set `component_version` = '1.10' where is_deleted = 0;