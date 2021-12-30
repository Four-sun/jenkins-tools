alter table science_project add column switch_gpu tinyint(4) default 0 comment '默认关闭，0为关闭 1 为开启';
alter table science_task add column gpu_params text comment 'gpu 参数';
update science_project set switch_gpu = 0;
update science_task set gpu_params = '## 每个worker所占的gpu核的数量,且该参数在该面板的位置不可修改
## worker.gcores=1' where task_type in (22,23,25);
UPDATE science_role_permission rp LEFT JOIN science_role r on rp.role_id = r.id set rp.is_deleted = 1 where r.role_value != 1 and rp.permission_id = 27;
