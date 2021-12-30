ALTER TABLE `rdos_stream_task_version`
ADD COLUMN `modify_user_id` INT(11) NULL COMMENT '最后修改task的用户',
ADD COLUMN `task_desc` varchar(255) NULL,
ADD COLUMN `exe_args` text NULL,
ADD COLUMN `source_params` text NULL COMMENT '输入源',
ADD COLUMN `sink_params` text NULL COMMENT '输出源',
ADD COLUMN `side_params` text NULL COMMENT '维表',
ADD COLUMN `create_model` tinyint(1) NULL COMMENT '任务模式 0 向导模式  1 脚本模式',
ADD COLUMN `operator_jsons` longtext NULL COMMENT '算子化组件信息';