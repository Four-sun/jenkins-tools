alter table science_project
    add is_switch_jupyter tinyint(4) default 0 comment '是否开启jupyterlab,默认0,关闭';
alter table science_project
    add jupyter_url varchar(1000) default '' comment 'jupyter地址信息';
alter table science_project
    add jupyter_status tinyint(4) null comment 'jupyter运行状态';
alter table science_project
    add job_id varchar(32) null comment 'jupyter对应的jobid';
update science_project
set is_switch_jupyter = 0
where is_switch_jupyter = null;