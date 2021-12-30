-- 增加数据迁移权限点
INSERT INTO `rdos_permission` VALUES (34,'package_transfer','任务迁移','任务迁移',1,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (35,'package_transfer_create','任务迁移_新建包','新建包',34,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (36,'package_transfer_view','任务迁移_查看包','查看包',34,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (37,'package_transfer_publish','任务迁移_发布包','发布包',34,1,now(),now(),0);

-- 刷新历史权限
DROP PROCEDURE IF EXISTS pr_auth_refresh_transfer;

DELIMITER //

create procedure pr_auth_refresh_transfer()
BEGIN
    DECLARE roleId INT;
    DECLARE roleValue INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id ,role_value from rdos_role where is_deleted=0 and project_id != -1);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;

    FETCH cur INTO roleId,roleValue;
    WHILE ( stop is not null) DO
            INSERT INTO rdos_role_permission(role_id,permission_id) VALUES (roleId, 34);
            INSERT INTO rdos_role_permission(role_id,permission_id) VALUES (roleId, 35);
            INSERT INTO rdos_role_permission(role_id,permission_id) VALUES (roleId, 36);
            INSERT INTO rdos_role_permission(role_id,permission_id) VALUES (roleId, 37);
            IF roleValue=4 THEN
                UPDATE rdos_role_permission SET is_deleted = 1 where role_id = roleId and permission_id = 35;
                UPDATE rdos_role_permission SET is_deleted = 1 where role_id = roleId and permission_id = 37;
            END IF;
            IF roleValue=5 THEN
                UPDATE rdos_role_permission SET is_deleted = 1 where role_id = roleId and permission_id = 37;
            END IF;
            FETCH cur INTO roleId,roleValue;
        END WHILE;

    CLOSE cur;
END; //

DELIMITER ;

CALL pr_auth_refresh_transfer();