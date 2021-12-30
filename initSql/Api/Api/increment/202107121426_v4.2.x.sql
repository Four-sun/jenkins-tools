-- 删除API管理员的项目编辑权限
DELETE da_role_permission
FROM da_role_permission
INNER JOIN da_role ON da_role.id = da_role_permission.role_id
WHERE role_value = 2 and permission_id = 97;


-- 删除访客权限 project_member_edit project_role_edit  project_config_edit
DELETE da_role_permission
FROM da_role_permission
INNER JOIN da_role ON da_role.id = da_role_permission.role_id
WHERE role_value = 3 and permission_id in (97, 24, 30);


-- *******************************************
-- 更新添加告警权限
DROP PROCEDURE IF EXISTS pr_alarm_check;
delimiter //
create procedure pr_alarm_check()
BEGIN
-- 如果role_permission表中没有告警相关的权限 则需要添加进去
SET @p_count = (select count(1) from da_role_permission rp left join da_role r on r.id = rp.role_id where r.role_value != 3  and permission_id in (98,99,100,101,102));
IF @p_count=0 THEN
    -- 添加API告警 role_user关系
    INSERT INTO da_role_permission (role_id, permission_id) select id,98 from da_role where role_value != 3;
    INSERT INTO da_role_permission (role_id, permission_id) select id,99 from da_role where role_value != 3;
    INSERT INTO da_role_permission (role_id, permission_id) select id,100 from da_role where role_value != 3;
    INSERT INTO da_role_permission (role_id, permission_id) select id,101 from da_role where role_value != 3;
    INSERT INTO da_role_permission (role_id, permission_id) select id,102 from da_role;
END IF;
END;//
delimiter ;
CALL pr_alarm_check();

-- *******************************************




-- *******************************************
-- 给数据开发及以上的角色赋予权限 api、函数管理
DROP PROCEDURE IF EXISTS pr_api_func_permission_check;
delimiter //
create procedure pr_api_func_permission_check()
BEGIN
DECLARE roleId INT;
DECLARE stop INT DEFAULT 0;
-- 除访客和应用开发之外的角色
DECLARE cur CURSOR FOR (select id from da_role where is_deleted=0 and role_value in (1,2,5,8,6,7));
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;
-- 如果role_permission表中没有API、函数管理相关的权限，则需要添加进去
SET @p_count = (select count(1) from da_role_permission rp left join da_role r on r.id = rp.role_id where r.role_value in(1,2,5,8,6,7) and permission_id in (103,105,106,107,108));
IF @p_count=0 THEN
    OPEN cur;
        FETCH cur INTO roleId;
        WHILE ( stop is not null) DO
        INSERT INTO da_role_permission(role_id, permission_id) VALUES (roleId, 103),(roleId, 105),(roleId, 106),(roleId, 107),(roleId, 108);
        FETCH cur INTO roleId;
        END WHILE;

    CLOSE cur;
END IF;

END;//

delimiter ;
CALL pr_api_func_permission_check();

-- *******************************************
