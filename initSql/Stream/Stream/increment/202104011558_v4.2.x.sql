BEGIN;
-- project 添加修改人
alter table `rdos_project` add column `modify_user_id` int(11) not null comment '修改人';
update `rdos_project` set `modify_user_id` = `create_user_id`;

-- role 添加创建人
alter table `rdos_role` add column `create_user_id` int(11) null comment '创建人';

-- role_user 添加新建人、修改人
alter table `rdos_role_user` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_role_user` add column `modify_user_id` int(11) null comment '修改人';

-- notify 添加修改人
alter table `rdos_notify` add column `modify_user_id` int(11) not null comment '修改人';
update `rdos_notify` set `modify_user_id` = `create_user_id`;

-- notify_user 添加新建人、修改人
alter table `rdos_notify_user` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_notify_user` add column `modify_user_id` int(11) null comment '修改人';

-- project_stick 添加新建人、修改人
alter table `rdos_project_stick` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_project_stick` add column `modify_user_id` int(11) null comment '修改人';

-- stream_alarm_receive_user 添加新建人、修改人
alter table `rdos_stream_alarm_receive_user` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_stream_alarm_receive_user` add column `modify_user_id` int(11) null comment '修改人';

-- stream_catalogue 添加修改人
alter table `rdos_stream_catalogue` add column `modify_user_id` int(11) not null comment '修改人';
update `rdos_stream_catalogue` set `modify_user_id` = `create_user_id`;

-- stream_job 添加新建人、修改人
alter table `rdos_stream_job` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_stream_job` add column `modify_user_id` int(11) null comment '修改人';

-- stream_task_retry 添加新建人、修改人
alter table `rdos_stream_task_retry` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_stream_task_retry` add column `modify_user_id` int(11) null comment '修改人';

-- stream_task_operation_log 添加新建人、修改人
alter table `rdos_stream_task_operation_log` add column `create_user_id` int(11) null comment '创建人';
alter table `rdos_stream_task_operation_log` add column `modify_user_id` int(11) null comment '修改人';
COMMIT;