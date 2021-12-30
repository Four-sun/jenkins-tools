alter table rdos_stream_task
    ADD COLUMN `create_model` tinyint(1) COMMENT '任务模式 0 向导模式  1 脚本模式' after `side_params`;