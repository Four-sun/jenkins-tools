BEGIN;

alter table `rdos_stream_param_template`
    ADD COLUMN `template_name` varchar(255) NULL COMMENT '模版名称' after `task_type`;

alter table `rdos_stream_param_template`
    ADD COLUMN `project_id` int(11) NULL COMMENT '项目ID' after `task_type`;

alter table `rdos_stream_param_template`
    ADD COLUMN `create_user_id` int(11) COMMENT '新建的用户id';

alter table `rdos_stream_param_template`
    ADD COLUMN `modify_user_id` int(11) COMMENT '修改的用户id';

update `rdos_stream_param_template` set `project_id` = -1 where is_deleted = 0;

update `rdos_stream_param_template` set `template_name` = 'Flink参数模版_Flink1.8' where task_type = 1 and component_version = '1.8';
update `rdos_stream_param_template` set `template_name` = 'FlinkSQL参数模版_Flink1.8' where task_type = 0 and component_version = '1.8';
update `rdos_stream_param_template` set `template_name` = '实时采集参数模版_Flink1.8' where task_type = 11 and component_version = '1.8';
update `rdos_stream_param_template` set `template_name` = 'Flink参数模版_Flink1.10' where task_type = 1 and component_version = '1.10';
update `rdos_stream_param_template` set `template_name` = 'FlinkSQL参数模版_Flink1.10' where task_type = 0 and component_version = '1.10';
update `rdos_stream_param_template` set `template_name` = '实时采集参数模版_Flink1.10' where task_type = 11 and component_version = '1.10';
update `rdos_stream_param_template` set `template_name` = 'Flink参数模版_Flink1.12' where task_type = 1 and component_version = '1.12';
update `rdos_stream_param_template` set `template_name` = 'FlinkSQL参数模版_Flink1.12' where task_type = 0 and component_version = '1.12';
update `rdos_stream_param_template` set `template_name` = '实时采集参数模版_Flink1.12' where task_type = 11 and component_version = '1.12';



insert into `rdos_stream_param_template`(
    `template_name`,
    `task_type`,
    `component_version`,
    `param`,
    `gmt_create`,
    `gmt_modified`,
    `is_deleted`,
    `create_user_id`,
    `modify_user_id`,
    `project_id`)
select t.template_name,
       t.task_type,
       t.component_version,
       t.param,
       now(),
       now(),
       0,
       -1,
       -1,
       p.id as project_id
from rdos_project  p, rdos_stream_param_template t;
COMMIT;