-- 增加角色
INSERT INTO `rdos_role`
    (`tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES
    (-1, -1, '租户管理员', 1, 6, '本项目内的全部权限，具有本租户内的最高权限，但不能对租户所有者操作', 0, '2020-08-31 16:15:22', '2020-08-31 16:15:22', 0);

-- 刷新已经有的角色表
DROP PROCEDURE IF EXISTS pr_auth_refresh_role;

DELIMITER //
create procedure pr_auth_refresh_role()
BEGIN
    DECLARE tenantId INT;
    DECLARE projectId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id ,tenant_id from rdos_project where is_deleted=0 and id != -1);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;

    FETCH cur INTO projectId,tenantId;
    WHILE ( stop is not null) DO
            INSERT INTO rdos_role (tenant_id, project_id, role_name, role_type, role_value, role_desc, modify_user_id, gmt_create, gmt_modified, is_deleted) VALUES (tenantId, projectId, '租户管理员', 1, 6, '本项目内的全部权限，具有本租户内的最高权限，但不能对租户所有者操作', 0, now(), now(), 0);
            FETCH cur INTO projectId,tenantId;
        END WHILE;
    CLOSE cur;
END; //
DELIMITER ;

CALL pr_auth_refresh_role();

-- 刷新角色权限表
DROP PROCEDURE IF EXISTS pr_auth_refresh_role_permission1;
DELIMITER //
create procedure pr_auth_refresh_role_permission1(IN roleId INT)
BEGIN
    DECLARE permissionId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select permission_id from rdos_role_permission where is_deleted=0 and role_id = 1);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;

    FETCH cur INTO permissionId;
    WHILE ( stop is not null) DO
            INSERT INTO rdos_role_permission (role_id, permission_id, gmt_create, gmt_modified, is_deleted) VALUES (roleId, permissionId, NOW(), NOW(),0);
            FETCH cur INTO permissionId;
        END WHILE;
    CLOSE cur;
END; //
DELIMITER ;

DROP PROCEDURE IF EXISTS pr_auth_refresh_role_permission;
DELIMITER //
create procedure pr_auth_refresh_role_permission()
BEGIN
    DECLARE roleId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id from rdos_role where is_deleted=0 and role_value = 6);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;

    FETCH cur INTO roleId;
    WHILE ( stop is not null) DO
            CALL pr_auth_refresh_role_permission1(roleId);
            FETCH cur INTO roleId;
        END WHILE;
    CLOSE cur;
END; //
DELIMITER ;

CALL pr_auth_refresh_role_permission();