ALTER TABLE science_project ADD COLUMN jupyter_param text COMMENT 'jupyter 环境参数';
UPDATE science_project SET jupyter_param = '{"worker.memory": "512m","worker.cores": 1,"exclusive": false,"worker.num": 1}';

alter table science_project add column model_size int(11) not null default 0 COMMENT '已部署模型数量';

UPDATE science_project set schedule_status = 0;

delimiter //
CREATE PROCEDURE statistics_model_size()
BEGIN
    DECLARE pid, totalSize int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_project where is_deleted = 0 and status = 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set totalSize = 0;
    model_loop:loop
        fetch cur into pid;
        if done = 1 then
            leave model_loop;
        end if;
        SELECT count(1) into totalSize from science_model where project_id = pid and is_deleted = 0;
        update science_project set model_size = totalSize where id = pid;
    end loop;
    close cur;
END ;
//
delimiter ;
CALL statistics_model_size();
DROP PROCEDURE statistics_model_size;

insert into science_permission values(27,'project_create','创建权限','创建权限',2,1,now(),now(),0);
insert into science_permission values(28,'data','数据管理','数据管理',1,1,now(),now(),0);
insert into science_permission values(29,'data_query','数据管理_查看','数据管理_查看',28,1,now(),now(),0);
insert into science_permission values(30,'data_edit','数据管理_编辑','数据管理_编辑',28,1,now(),now(),0);
insert into science_permission values(31,'maintain_task_manager_query','任务管理_查看','任务管理_查看',19,1,now(),now(),0);
insert into science_permission values(32,'maintain_task_manager_control','任务管理_控制','任务管理_控制',19,1,now(),now(),0);
insert into science_permission values(33,'maintain_task_history','运行历史','运行历史',17,1,now(),now(),0);
insert into science_permission values(34,'maintain_task_history_query','运行历史_查看','运行历史_查看',33,1,now(),now(),0);
insert into science_permission values(35,'maintain_task_history_control','运行历史_控制','运行历史_控制',33,1,now(),now(),0);
insert into science_permission values(36,'maintain_task_alarm_record','告警记录','告警记录',17,1,now(),now(),0);
insert into science_permission values(37,'maintain_task_alarm_rule','告警规则','告警规则',17,1,now(),now(),0);
insert into science_permission values(38,'maintain_task_alarm_rule_query','告警规则_查看','告警规则_查看',37,1,now(),now(),0);
insert into science_permission values(39,'maintain_task_alarm_rule_edit','告警规则_编辑','告警规则_编辑',37,1,now(),now(),0);
insert into science_permission values(40,'notebook_edit','notebook_编辑','notebook_编辑',5,1,now(),now(),0);
insert into science_permission values(41,'lab_edit','实验_编辑','实验_编辑',9,1,now(),now(),0);
insert into science_permission values(42,'monitoring_alarm','监控告警','监控告警',17,1,now(),now(),0);
UPDATE science_permission p set p.parent_id = 42 where id in (36,37);
UPDATE science_permission p set p.name = '创建权限', p.display = '创建权限' WHERE id = 27;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 3;
UPDATE science_permission p set p.name = '编辑权限', p.display = '编辑权限' WHERE id = 4;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 29;
UPDATE science_permission p set p.name = '编辑权限', p.display = '编辑权限' WHERE id = 30;
UPDATE science_permission p set p.name = '运维概览', p.display = '运维概览' WHERE id = 18;
UPDATE science_permission p set p.name = '任务管理', p.display = '任务管理' WHERE id = 19;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 31;
UPDATE science_permission p set p.name = '任务控制', p.display = '任务控制' WHERE id = 32;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 34;
UPDATE science_permission p set p.name = '任务控制', p.display = '任务控制' WHERE id = 35;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 38;
UPDATE science_permission p set p.name = '编辑权限', p.display = '编辑权限' WHERE id = 39;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 6;
UPDATE science_permission p set p.name = '提交/发布', p.display = '提交/发布' WHERE id = 7;
UPDATE science_permission p set p.name = '模型在线部署', p.display = '模型在线部署' WHERE id = 8;
UPDATE science_permission p set p.name = '编辑权限', p.display = '编辑权限' WHERE id = 40;
UPDATE science_permission p set p.name = '查看权限', p.display = '查看权限' WHERE id = 10;
UPDATE science_permission p set p.name = '提交/发布', p.display = '提交/发布' WHERE id = 11;
UPDATE science_permission p set p.name = '模型在线部署', p.display = '模型在线部署' WHERE id = 12;
UPDATE science_permission p set p.name = '编辑权限', p.display = '编辑权限' WHERE id = 41;
UPDATE science_role SET role_name = '算法开发' WHERE role_name = '数据科学家';


-- 所有租户所有者角色增加权限
delimiter //
CREATE PROCEDURE insert_tenant_owner_permission()
BEGIN
    DECLARE role_id, total int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_role where role_value = 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set total = 0;
    role_loop:loop
        fetch cur into role_id;
        if done = 1 then
            leave role_loop;
        end if;
        insert into science_role_permission values (default, role_id, 2, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 4, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 5, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 9, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 13, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 14, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 17, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 21, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 24, now(), now(), 0);
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
CALL insert_tenant_owner_permission();
DROP PROCEDURE insert_tenant_owner_permission;

-- 所有项目所有者角色增加权限
delimiter //
CREATE PROCEDURE insert_project_owner_permission()
BEGIN
    DECLARE role_id, total int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_role where role_value = 2;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set total = 0;
    role_loop:loop
        fetch cur into role_id;
        if done = 1 then
            leave role_loop;
        end if;
        insert into science_role_permission values (default, role_id, 2, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 4, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 5, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 9, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 13, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 14, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 17, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 21, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 24, now(), now(), 0);
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
CALL insert_project_owner_permission();
DROP PROCEDURE insert_project_owner_permission;

-- 查询出所有项目管理员角色
delimiter //
CREATE PROCEDURE insert_project_admin_permission()
BEGIN
    DECLARE role_id, total int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_role where role_value = 3;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set total = 0;
    role_loop:loop
        fetch cur into role_id;
        if done = 1 then
            leave role_loop;
        end if;
        insert into science_role_permission values (default, role_id, 2, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 4, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 5, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 9, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 13, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 14, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 17, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 21, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 24, now(), now(), 0);
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
CALL insert_project_admin_permission();
DROP PROCEDURE insert_project_admin_permission;

-- 查询出所有数据科学家角色
delimiter //
CREATE PROCEDURE insert_data_scientist_permission()
BEGIN
    DECLARE role_id, total int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_role where role_value = 8;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set total = 0;
    role_loop:loop
        fetch cur into role_id;
        if done = 1 then
            leave role_loop;
        end if;
        insert into science_role_permission values (default, role_id, 2, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 5, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 9, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 13, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 14, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 17, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 21, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 24, now(), now(), 0);
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
CALL insert_data_scientist_permission();
DROP PROCEDURE insert_data_scientist_permission;

-- 所有访客角色新增权限
delimiter //
CREATE PROCEDURE insert_visitor_permission()
BEGIN
    DECLARE role_id, total int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select id from science_role where role_value = 4;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    open cur;
    set total = 0;
    role_loop:loop
        fetch cur into role_id;
        if done = 1 then
            leave role_loop;
        end if;
        insert into science_role_permission values (default, role_id, 2, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 5, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 9, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 13, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 14, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 17, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 21, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 24, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 28, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 29, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 31, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 33, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 34, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 36, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 37, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 38, now(), now(), 0);
        insert into science_role_permission values (default, role_id, 42, now(), now(), 0);
        set total = total + 1;
    end loop;
    close cur;
    SELECT total;
END ;
//
delimiter ;
CALL insert_visitor_permission();
DROP PROCEDURE insert_visitor_permission;

update science_permission set is_deleted = 1 where id = 20;
UPDATE science_role_permission set is_deleted = 1 WHERE permission_id = 20;
update science_role_permission rp left join science_role r on rp.role_id = r.id set rp.is_deleted = 1 WHERE r.role_value = 8 and rp.permission_id = 4;
UPDATE science_role_permission rp LEFT JOIN science_role r on rp.role_id = r.id set rp.is_deleted = 1 where r.role_value = 4 and rp.permission_id in (30,32,35,39,40,41)

