-- 新增任务提交记录表字段及索引
alter table science_task_version add column exe_args text comment '任务参数';
alter table science_task_version add column component_type int(11) default 0 not null comment '组件类型';
alter table science_task_version add column custom_params text comment 'Notebook 自定义参数';
alter table science_task_version add index idx_project_task_version(is_deleted, project_id, task_id,version, period_type);
alter table science_task_version add index idx_task_create_time(is_deleted, task_id,gmt_create);
update science_task_version set version = 0 where is_deleted = 0;
update science_task_version set custom_params = '[]';
update dt_center_cron_schedule set cron = '*/10 * * * * ?' where job_detail_name = 'dataScienceCheckConnJob';

-- 填充默认值
delimiter //
CREATE PROCEDURE update_version_component_type()
BEGIN
    DECLARE taskId int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select distinct tv.task_id as taskId from science_task_version tv;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    start transaction;
    open cur;
    version_loop : loop
        fetch cur into taskId;
        if done = 1 then
            leave version_loop;
        end if;
        update science_task_version set component_type = (select distinct component_type from science_task where id = taskId),
                                        exe_args = (select distinct exe_args from science_task where id = taskId),
                                        sql_text = (select distinct sql_text from science_task where id = task_id) where task_id = taskId;
    end loop;
    close cur;
    commit;
END ;
//
delimiter ;
call update_version_component_type();
DROP PROCEDURE update_version_component_type;

delimiter //
CREATE PROCEDURE update_submit_task_version()
BEGIN
    DECLARE versionId int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select max(stv.id) from science_task_version stv group by stv.task_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    start transaction;
    open cur;
    version_loop : loop
        fetch cur into versionId;
        if done = 1 then
            leave version_loop;
        end if;
        update science_task_version set version = 1 where id = versionId;
    end loop;
    close cur;
    commit;
END ;
//
delimiter ;
call update_submit_task_version();
DROP PROCEDURE update_submit_task_version;

-- 新增租户管理员角色
ALTER TABLE science_role add column role_order tinyint(4) default 0 not null comment '角色排序';
INSERT INTO `science_role` VALUES (4, '-1', '-1', '租户管理员', '1', '5', '本项目内的全部权限，具有本项目内的最高权限', '0', now(), now(),'0',1);
update science_role set role_order = 0 where role_value = 1;
update science_role set role_order = 1 where role_value = 5;
update science_role set role_order = 2 where role_value = 2;
update science_role set role_order = 3 where role_value = 3;
update science_role set role_order = 4 where role_value = 8;
update science_role set role_order = 5 where role_value = 4;

-- 新增项目角色
delimiter //
create procedure insert_role_project()
BEGIN
    declare projectId, modifyUserId,tenantId int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id,create_user_id,tenant_id from science_project where is_deleted = 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    start transaction;
    open cur;
    project_loop : loop
        fetch cur into projectId, modifyUserId,tenantId;
        if done = 1 then
            leave project_loop;
        end if;
        INSERT INTO science_role(id, tenant_id, project_id, role_name, role_type, role_value, role_desc,modify_user_id,is_deleted,role_order) VALUES (default, tenantId, projectId, '租户管理员', 1, 5, '本项目内的全部权限，具有本项目内的最高权限', modifyUserId, 0, 1);
    end loop;
    close cur;
    commit;
END ;
//
delimiter ;
call insert_role_project();
drop procedure insert_role_project;

-- 所有租户管理员角色增加权限
delimiter //
CREATE PROCEDURE insert_tenant_admin_permission()
BEGIN
    DECLARE role_id, total int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_role where role_value = 5;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set total = 0;
    role_loop:loop
        fetch cur into role_id;
        if done = 1 then
            leave role_loop;
        end if;
        insert into science_role_permission values (default, role_id, 1, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 2, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 3, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 4, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 5, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 6, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 7, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 8, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 9, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 10, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 11, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 12, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 13, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 14, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 15, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 16, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 17, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 18, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 19, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 21, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 22, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 23, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 24, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 25, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 26, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 27, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 28, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 29, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 30, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 31, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 32, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 33, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 34, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 35, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 36, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 37, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 38, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 39, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 40, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 41, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 42, now(), now(), 0);
        set total = total + 1;
    end loop;
    close cur;
    SELECT total;
END ;
//
delimiter ;
CALL insert_tenant_admin_permission();
DROP PROCEDURE insert_tenant_admin_permission;


