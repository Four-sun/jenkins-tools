-- 更新 Notebook 任务锁类型
update science_read_write_lock set type = 'SCIENCE_NOTEBOOK'
where relation_id in (select id from science_task where component_type = 0 and flow_id = 0);

-- 更新 算法实验 任务锁类型
update science_read_write_lock set type = 'SCIENCE_LAB'
where relation_id in (select id  from science_task where task_type = 14 and flow_id = 0);

-- 更新 组件 任务锁类型
update science_read_write_lock set type = 'SCIENCE_COMPONENT'
where type = 'BATCH_TASK';

alter table science_read_write_lock add index idx_project_relation_type(project_id, type, is_deleted, relation_id);

create table science_task_save_version(
id int(11) unsigned auto_increment primary key comment '主键 id',
task_id int(11) unsigned not null comment '任务 id',
sql_text text comment '代码文本/画布内容',
exe_args text comment '运行参数',
task_params text comment '任务参数',
schedule_conf text comment '调度配置',
task_version int(11) unsigned comment '版本号',
gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
create_user_id int(11) NOT NULL COMMENT '创建人id',
modify_user_id int(11) DEFAULT '0' COMMENT '修改人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务保存版本';
alter table science_task_save_version add unique index idx_task_version_is_deleted(task_id, task_version, is_deleted);