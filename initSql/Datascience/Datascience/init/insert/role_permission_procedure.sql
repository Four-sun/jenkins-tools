DROP PROCEDURE IF EXISTS pr_auth_admin;

DELIMITER //

create procedure pr_auth_admin()
BEGIN
    DECLARE authId INT;
    DECLARE authCode VARCHAR(128);
    DECLARE authPId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id, code, parent_id from science_permission where is_deleted = 0 and type = 1);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;

    FETCH cur INTO authId,authCode,authPId;
    WHILE (stop is not null)
        DO
            SET @p_count =
                    (select count(1) p_count from science_permission where parent_id = authId and is_deleted = 0);
            IF @p_count = 0 THEN
                INSERT INTO science_role_permission(role_id, permission_id) VALUES ('1', authId);
                INSERT INTO science_role_permission(role_id, permission_id) VALUES ('2', authId);
                INSERT INTO science_role_permission(role_id, permission_id) VALUES ('3', authId);
                INSERT INTO science_role_permission(role_id, permission_id) VALUES ('4', authId);
                INSERT INTO science_role_permission(role_id, permission_id) VALUES ('5', authId);
                INSERT INTO science_role_permission(role_id, permission_id) VALUES ('6', authId);
            END IF;
            FETCH cur INTO authId,authCode,authPId;
        END WHILE;

    CLOSE cur;
END;
//

DELIMITER ;

CALL pr_auth_admin();

-- 访客
UPDATE science_role_permission
SET is_deleted=1
where role_id = (select min(id) from science_role WHERE role_value = 4)
  and permission_id IN (
    SELECT id
    from science_permission
    where type = 1
      and code in (
                   'project_edit',
                   'notebook_schedule',
                   'notebook_deploy',
                   'project_role_edit',
                   'lab_schedule',
                   'lab_deploy',
                   'model_edit',
                   'member_manager_edit',
                   'role_manager_edit'
        )
);

-- 数据科学家
UPDATE science_role_permission
SET is_deleted=1
where role_id = (select min(id) from science_role WHERE role_value = 8)
  and permission_id IN (
    SELECT id
    from science_permission
    where type = 1
      and code in (
                   'project_edit',
                   'member_manager_edit',
                   'role_manager_edit'
        )
);

-- 租户所有者
insert into science_role_permission values (default, 1, 2, now(), now(), 0);
insert into science_role_permission values (default, 1, 5, now(), now(), 0);
insert into science_role_permission values (default, 1, 9, now(), now(), 0);
insert into science_role_permission values (default, 1, 13, now(), now(), 0);
insert into science_role_permission values (default, 1, 14, now(), now(), 0);
insert into science_role_permission values (default, 1, 17, now(), now(), 0);
insert into science_role_permission values (default, 1, 21, now(), now(), 0);
insert into science_role_permission values (default, 1, 24, now(), now(), 0);
insert into science_role_permission values (default, 1, 27, now(), now(), 0);
insert into science_role_permission values (default, 1, 28, now(), now(), 0);
insert into science_role_permission values (default, 1, 29, now(), now(), 0);
insert into science_role_permission values (default, 1, 30, now(), now(), 0);
insert into science_role_permission values (default, 1, 31, now(), now(), 0);
insert into science_role_permission values (default, 1, 32, now(), now(), 0);
insert into science_role_permission values (default, 1, 33, now(), now(), 0);
insert into science_role_permission values (default, 1, 34, now(), now(), 0);
insert into science_role_permission values (default, 1, 35, now(), now(), 0);
insert into science_role_permission values (default, 1, 36, now(), now(), 0);
insert into science_role_permission values (default, 1, 37, now(), now(), 0);
insert into science_role_permission values (default, 1, 38, now(), now(), 0);
insert into science_role_permission values (default, 1, 39, now(), now(), 0);
insert into science_role_permission values (default, 1, 40, now(), now(), 0);
insert into science_role_permission values (default, 1, 41, now(), now(), 0);

-- 项目所有者
insert into science_role_permission values (default, 2, 2, now(), now(), 0);
insert into science_role_permission values (default, 2, 5, now(), now(), 0);
insert into science_role_permission values (default, 2, 9, now(), now(), 0);
insert into science_role_permission values (default, 2, 13, now(), now(), 0);
insert into science_role_permission values (default, 2, 14, now(), now(), 0);
insert into science_role_permission values (default, 2, 17, now(), now(), 0);
insert into science_role_permission values (default, 2, 21, now(), now(), 0);
insert into science_role_permission values (default, 2, 24, now(), now(), 0);
insert into science_role_permission values (default, 2, 28, now(), now(), 0);
insert into science_role_permission values (default, 2, 29, now(), now(), 0);
insert into science_role_permission values (default, 2, 30, now(), now(), 0);
insert into science_role_permission values (default, 2, 31, now(), now(), 0);
insert into science_role_permission values (default, 2, 32, now(), now(), 0);
insert into science_role_permission values (default, 2, 33, now(), now(), 0);
insert into science_role_permission values (default, 2, 34, now(), now(), 0);
insert into science_role_permission values (default, 2, 35, now(), now(), 0);
insert into science_role_permission values (default, 2, 36, now(), now(), 0);
insert into science_role_permission values (default, 2, 37, now(), now(), 0);
insert into science_role_permission values (default, 2, 38, now(), now(), 0);
insert into science_role_permission values (default, 2, 39, now(), now(), 0);
insert into science_role_permission values (default, 2, 40, now(), now(), 0);
insert into science_role_permission values (default, 2, 41, now(), now(), 0);

-- 项目管理员
insert into science_role_permission values (default, 3, 2, now(), now(), 0);
insert into science_role_permission values (default, 3, 5, now(), now(), 0);
insert into science_role_permission values (default, 3, 9, now(), now(), 0);
insert into science_role_permission values (default, 3, 13, now(), now(), 0);
insert into science_role_permission values (default, 3, 14, now(), now(), 0);
insert into science_role_permission values (default, 3, 17, now(), now(), 0);
insert into science_role_permission values (default, 3, 21, now(), now(), 0);
insert into science_role_permission values (default, 3, 24, now(), now(), 0);
insert into science_role_permission values (default, 3, 28, now(), now(), 0);
insert into science_role_permission values (default, 3, 29, now(), now(), 0);
insert into science_role_permission values (default, 3, 30, now(), now(), 0);
insert into science_role_permission values (default, 3, 31, now(), now(), 0);
insert into science_role_permission values (default, 3, 32, now(), now(), 0);
insert into science_role_permission values (default, 3, 33, now(), now(), 0);
insert into science_role_permission values (default, 3, 34, now(), now(), 0);
insert into science_role_permission values (default, 3, 35, now(), now(), 0);
insert into science_role_permission values (default, 3, 36, now(), now(), 0);
insert into science_role_permission values (default, 3, 37, now(), now(), 0);
insert into science_role_permission values (default, 3, 38, now(), now(), 0);
insert into science_role_permission values (default, 3, 39, now(), now(), 0);
insert into science_role_permission values (default, 3, 40, now(), now(), 0);
insert into science_role_permission values (default, 3, 41, now(), now(), 0);

-- 数据科学家
insert into science_role_permission values (default, 5, 2, now(), now(), 0);
insert into science_role_permission values (default, 5, 5, now(), now(), 0);
insert into science_role_permission values (default, 5, 9, now(), now(), 0);
insert into science_role_permission values (default, 5, 13, now(), now(), 0);
insert into science_role_permission values (default, 5, 14, now(), now(), 0);
insert into science_role_permission values (default, 5, 17, now(), now(), 0);
insert into science_role_permission values (default, 5, 21, now(), now(), 0);
insert into science_role_permission values (default, 5, 24, now(), now(), 0);
insert into science_role_permission values (default, 5, 28, now(), now(), 0);
insert into science_role_permission values (default, 5, 29, now(), now(), 0);
insert into science_role_permission values (default, 5, 30, now(), now(), 0);
insert into science_role_permission values (default, 5, 31, now(), now(), 0);
insert into science_role_permission values (default, 5, 32, now(), now(), 0);
insert into science_role_permission values (default, 5, 33, now(), now(), 0);
insert into science_role_permission values (default, 5, 34, now(), now(), 0);
insert into science_role_permission values (default, 5, 35, now(), now(), 0);
insert into science_role_permission values (default, 5, 36, now(), now(), 0);
insert into science_role_permission values (default, 5, 37, now(), now(), 0);
insert into science_role_permission values (default, 5, 38, now(), now(), 0);
insert into science_role_permission values (default, 5, 39, now(), now(), 0);
insert into science_role_permission values (default, 5, 40, now(), now(), 0);
insert into science_role_permission values (default, 5, 41, now(), now(), 0);

-- 访客
insert into science_role_permission values (default, 6, 2, now(), now(), 0);
insert into science_role_permission values (default, 6, 5, now(), now(), 0);
insert into science_role_permission values (default, 6, 9, now(), now(), 0);
insert into science_role_permission values (default, 6, 13, now(), now(), 0);
insert into science_role_permission values (default, 6, 14, now(), now(), 0);
insert into science_role_permission values (default, 6, 17, now(), now(), 0);
insert into science_role_permission values (default, 6, 21, now(), now(), 0);
insert into science_role_permission values (default, 6, 24, now(), now(), 0);
insert into science_role_permission values (default, 6, 28, now(), now(), 0);
insert into science_role_permission values (default, 6, 29, now(), now(), 0);
insert into science_role_permission values (default, 6, 31, now(), now(), 0);
insert into science_role_permission values (default, 6, 33, now(), now(), 0);
insert into science_role_permission values (default, 6, 34, now(), now(), 0);
insert into science_role_permission values (default, 6, 36, now(), now(), 0);
insert into science_role_permission values (default, 6, 37, now(), now(), 0);
insert into science_role_permission values (default, 6, 38, now(), now(), 0);

update science_permission set is_deleted = 1 where id = 20;
UPDATE science_role_permission set is_deleted = 1 WHERE permission_id = 20;
update science_role_permission rp left join science_role r on rp.role_id = r.id set rp.is_deleted = 1 WHERE r.role_value = 8 and rp.permission_id = 4;
UPDATE science_role_permission rp LEFT JOIN science_role r on rp.role_id = r.id set rp.is_deleted = 1 where r.role_value = 4 and rp.permission_id in (27,30,32,35,39,40,41);
UPDATE science_role_permission rp LEFT JOIN science_role r on rp.role_id = r.id set rp.is_deleted = 1 where r.role_value != 1 and rp.permission_id = 27;

insert into science_role_permission values (default, 4, 1, now(), now(), 0);
insert into science_role_permission values (default, 4, 2, now(), now(), 0);
insert into science_role_permission values (default, 4, 3, now(), now(), 0);
insert into science_role_permission values (default, 4, 4, now(), now(), 0);
insert into science_role_permission values (default, 4, 5, now(), now(), 0);
insert into science_role_permission values (default, 4, 6, now(), now(), 0);
insert into science_role_permission values (default, 4, 7, now(), now(), 0);
insert into science_role_permission values (default, 4, 8, now(), now(), 0);
insert into science_role_permission values (default, 4, 9, now(), now(), 0);
insert into science_role_permission values (default, 4, 10, now(), now(), 0);
insert into science_role_permission values (default, 4, 11, now(), now(), 0);
insert into science_role_permission values (default, 4, 12, now(), now(), 0);
insert into science_role_permission values (default, 4, 13, now(), now(), 0);
insert into science_role_permission values (default, 4, 14, now(), now(), 0);
insert into science_role_permission values (default, 4, 15, now(), now(), 0);
insert into science_role_permission values (default, 4, 16, now(), now(), 0);
insert into science_role_permission values (default, 4, 17, now(), now(), 0);
insert into science_role_permission values (default, 4, 18, now(), now(), 0);
insert into science_role_permission values (default, 4, 19, now(), now(), 0);
insert into science_role_permission values (default, 4, 21, now(), now(), 0);
insert into science_role_permission values (default, 4, 22, now(), now(), 0);
insert into science_role_permission values (default, 4, 23, now(), now(), 0);
insert into science_role_permission values (default, 4, 24, now(), now(), 0);
insert into science_role_permission values (default, 4, 25, now(), now(), 0);
insert into science_role_permission values (default, 4, 26, now(), now(), 0);
insert into science_role_permission values (default, 4, 27, now(), now(), 0);
insert into science_role_permission values (default, 4, 28, now(), now(), 0);
insert into science_role_permission values (default, 4, 29, now(), now(), 0);
insert into science_role_permission values (default, 4, 30, now(), now(), 0);
insert into science_role_permission values (default, 4, 31, now(), now(), 0);
insert into science_role_permission values (default, 4, 32, now(), now(), 0);
insert into science_role_permission values (default, 4, 33, now(), now(), 0);
insert into science_role_permission values (default, 4, 34, now(), now(), 0);
insert into science_role_permission values (default, 4, 35, now(), now(), 0);
insert into science_role_permission values (default, 4, 36, now(), now(), 0);
insert into science_role_permission values (default, 4, 37, now(), now(), 0);
insert into science_role_permission values (default, 4, 38, now(), now(), 0);
insert into science_role_permission values (default, 4, 39, now(), now(), 0);
insert into science_role_permission values (default, 4, 40, now(), now(), 0);
insert into science_role_permission values (default, 4, 41, now(), now(), 0);
insert into science_role_permission values (default, 4, 42, now(), now(), 0);

