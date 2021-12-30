DROP PROCEDURE IF EXISTS pr_auth_admin;

DELIMITER //

create procedure pr_auth_admin()
BEGIN
DECLARE authId INT;
DECLARE authCode VARCHAR(128);
DECLARE authPId INT;
DECLARE stop INT DEFAULT 0;
DECLARE cur CURSOR FOR (select id ,code ,parent_id from rdos_permission where is_deleted=0 and type = 1);
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

OPEN cur;

    FETCH cur INTO authId,authCode,authPId;
    WHILE ( stop is not null) DO
    SET @p_count = (select count(1) p_count from rdos_permission where parent_id = authId and is_deleted=0);
    IF @p_count=0 THEN
    INSERT INTO rdos_role_permission(role_id,permission_id) VALUES ('1', authId);
    INSERT INTO rdos_role_permission(role_id,permission_id) VALUES ('2', authId);
    INSERT INTO rdos_role_permission(role_id,permission_id) VALUES ('3', authId);
    INSERT INTO rdos_role_permission(role_id,permission_id) VALUES ('4', authId);
    INSERT INTO rdos_role_permission(role_id,permission_id) VALUES ('5', authId);
    INSERT INTO rdos_role_permission(role_id,permission_id) VALUES ('6', authId);
    END IF;
    FETCH cur INTO authId,authCode,authPId;
    END WHILE;

CLOSE cur;
END; //

DELIMITER ;

CALL pr_auth_admin();

-- 项目管理员
UPDATE rdos_role_permission SET is_deleted=1 where role_id = (select min(id) from rdos_role WHERE role_value = 3) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'project_edit'
  )
);

-- 访客
UPDATE rdos_role_permission SET is_deleted=1 where role_id = (select min(id) from rdos_role WHERE role_value = 4) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'project_edit',
    'project_configure_edit',
    'project_configure_delete',
    'project_member_edit',
    'project_member_remove',
    'project_strategy_edit',
    'project_strategy_delete',
    'project_role_edit',
    'datasource_manager_edit',
    'datasource_manager_delete',
    'datadevelop_resourcemanager_query',
    'datadevelop_resourcemanager_edit',
    'datadevelop_resourcemanager_delete',
    'datadevelop_functionmanager_query',
    'datadevelop_functionmanager_edit',
    'datadevelop_functionmanager_delete',
    'datadevelop_taskmanager_edit',
    'datadevelop_taskmanager_run',
    'datadevelop_taskpublish_create',
    'datadevelop_taskpublish_query',
    'datadevelop_taskpublish_download',
    'datadevelop_taskpublish_publish',
    'maintenance_alarm_custom_edit',
    'maintenance_alarm_custom_delete'
  )
);

-- 数据开发
UPDATE rdos_role_permission SET is_deleted=1 where role_id = (select min(id) from rdos_role WHERE role_value = 5) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'project_edit',
    'project_configure_delete',
    'project_member_edit',
    'project_member_remove',
    'project_strategy_edit',
    'project_strategy_delete',
    'project_role_edit',
    'datasource_manager_edit',
    'datasource_manager_delete',
    'datadevelop_taskpublish_create',
    'datadevelop_taskpublish_query',
    'datadevelop_taskpublish_download',
    'datadevelop_taskpublish_publish'
  )
);
