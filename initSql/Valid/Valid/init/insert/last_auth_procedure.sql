DROP PROCEDURE IF EXISTS pr_auth_admin;

DELIMITER //
create procedure pr_auth_admin()
BEGIN
DECLARE authId INT;
DECLARE authCode VARCHAR(128);
DECLARE authPId INT;
DECLARE stop INT DEFAULT 0;
DECLARE cur CURSOR FOR (select id ,code ,parent_id from dq_permission where is_deleted=0 and type = 1);
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

OPEN cur;

    FETCH cur INTO authId,authCode,authPId;
    WHILE ( stop is not null) DO
    SET @p_count = (select count(1) p_count from dq_permission where parent_id = authId and is_deleted=0);
    IF @p_count=0 THEN
    INSERT INTO dq_role_permission(role_id,permission_id) VALUES ('1', authId);
    INSERT INTO dq_role_permission(role_id,permission_id) VALUES ('2', authId);
    INSERT INTO dq_role_permission(role_id,permission_id) VALUES ('3', authId);
    INSERT INTO dq_role_permission(role_id,permission_id) VALUES ('4', authId);
    INSERT INTO dq_role_permission(role_id,permission_id) VALUES ('5', authId);
    END IF;
    FETCH cur INTO authId,authCode,authPId;
    END WHILE;

CLOSE cur;

-- 数据开发
delete from dq_role_permission where role_id = (SELECT id FROM dq_role WHERE role_value = 4) and permission_id IN (
  SELECT id from dq_permission where type = 1 and code in (
    'system_member_edit',
    'datasource_edit'
  )
);

-- 访客
delete from dq_role_permission where role_id = (SELECT id FROM dq_role WHERE role_value = 3) and permission_id IN (
  SELECT id from dq_permission where type = 1 and code in (
    'datasource_edit',
    'system_member_edit',
    'system_role_edit',
    'rule_edit',
    'verify_edit',
    'message_edit',
    'monitor_delete'
  )
);


END;//

DELIMITER ;

CALL pr_auth_admin();
