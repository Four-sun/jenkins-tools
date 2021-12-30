-- SQL 不可重复执行，有问题需要回滚数据库重新执行
BEGIN;
DROP PROCEDURE IF EXISTS refresh_user_tenant;
DELIMITER //
create procedure refresh_user_tenant()
BEGIN
DECLARE tableName VARCHAR(255);
DECLARE stop INT DEFAULT 0;
-- 获取当前库下面的所有业务表
DECLARE cur CURSOR FOR (SELECT table_name FROM information_schema.tables WHERE table_schema='streamapp' AND table_type = 'BASE TABLE' AND table_name LIKE 'rdos_%' AND table_name NOT IN ('rdos_user', 'rdos_tenant'));
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;
-- 判断表索引是否存在，存在则进行删除
IF EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema='streamapp' AND table_name = 'rdos_role_user' AND index_name = 'index_project_user_role') THEN
   ALTER TABLE rdos_role_user DROP index `index_project_user_role`;
END IF;
IF EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema='streamapp' AND table_name = 'rdos_project_stick' AND index_name = 'idx_project_user') THEN
   ALTER TABLE rdos_project_stick DROP index `idx_project_user`;
END IF;
OPEN cur;
    FETCH cur INTO tableName;
    WHILE ( stop is not null) DO
		set @column_count_sql = CONCAT("
        SELECT count(1) FROM information_schema.columns
        WHERE table_schema = 'streamapp'
        AND table_name = '", tableName, "'
        AND column_name = 'user_id' into @column_count");
		-- 执行查询 sql
		prepare stmt_count from @column_count_sql;EXECUTE stmt_count;deallocate prepare stmt_count;
        IF @column_count = 1 THEN
            set @column_update_sql = CONCAT("
            update ", tableName, " t
            INNER join rdos_user ru on ru.id=t.user_id and ru.is_deleted=0
            set t.user_id=ru.dtuic_user_id;");
            -- 执行更新 sql
            prepare stmt_update from @column_update_sql;EXECUTE stmt_update;deallocate prepare stmt_update;
        END IF;

        set @column_count_sql = CONCAT("
        SELECT count(1) FROM information_schema.columns
        WHERE table_schema = 'streamapp'
        AND table_name = '", tableName, "'
        AND column_name = 'create_user_id' into @column_count");
		-- 执行查询 sql
		prepare stmt_count from @column_count_sql;EXECUTE stmt_count;deallocate prepare stmt_count;
        IF @column_count = 1 THEN
            set @column_update_sql = CONCAT("
            update ", tableName, " t
            INNER join rdos_user ru on ru.id=t.create_user_id and ru.is_deleted=0
            set t.create_user_id=ru.dtuic_user_id;");
            -- 执行更新 sql
            prepare stmt_update from @column_update_sql;EXECUTE stmt_update;deallocate prepare stmt_update;
        END IF;

        set @column_count_sql = CONCAT("
        SELECT count(1) FROM information_schema.columns
        WHERE table_schema = 'streamapp'
        AND table_name = '", tableName, "'
        AND column_name = 'modify_user_id' into @column_count");
		-- 执行查询 sql
		prepare stmt_count from @column_count_sql;EXECUTE stmt_count;deallocate prepare stmt_count;
        IF @column_count = 1 THEN
            set @column_update_sql = CONCAT("
            update ", tableName, " t
            INNER join rdos_user ru on ru.id=t.modify_user_id and ru.is_deleted=0
            set t.modify_user_id=ru.dtuic_user_id;");
            -- 执行更新 sql
            prepare stmt_update from @column_update_sql;EXECUTE stmt_update;deallocate prepare stmt_update;
        END IF;

        set @column_count_sql = CONCAT("
        SELECT count(1) FROM information_schema.columns
        WHERE table_schema = 'streamapp'
        AND table_name = '", tableName, "'
        AND column_name = 'tenant_id' into @column_count");
		-- 执行查询 sql
		prepare stmt_count from @column_count_sql;EXECUTE stmt_count;deallocate prepare stmt_count;
        IF @column_count = 1 THEN
            set @column_update_sql = CONCAT("
            update ", tableName, " t
            INNER join rdos_tenant ru on ru.id=t.tenant_id and ru.is_deleted=0
            set t.tenant_id=ru.dtuic_tenant_id;");
            -- 执行更新 sql
            prepare stmt_update from @column_update_sql;EXECUTE stmt_update;deallocate prepare stmt_update;
        END IF;
    FETCH cur INTO tableName;
    END WHILE;
CLOSE cur;
END; //
DELIMITER ;
CALL refresh_user_tenant();

update rdos_stream_package a
    left join rdos_user c on c.id=a.publish_user_id and c.is_deleted=0
    set a.publish_user_id=c.dtuic_user_id
where a.is_deleted=0 and a.publish_user_id is not null;

-- 将索引加回来
ALTER TABLE rdos_project_stick ADD UNIQUE index `idx_project_user`(`project_id`, `create_user_id`) USING BTREE;

--  权限中心迁移 - 角色表
DELETE FROM `dt_pub_service`.`auth_role` WHERE app_type = 7 AND is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role`( `app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `create_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `old_role_id`)
SELECT 7, tenant_id, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `create_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `id`
FROM `streamapp`.`rdos_role`
WHERE is_deleted=0;

--  权限中心迁移 - 权限表
DELETE FROM `dt_pub_service`.`auth_permission` WHERE app_type=7 AND is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_permission`(`old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`)
SELECT `id`, 7, `code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`
FROM `streamapp`.`rdos_permission`
WHERE is_deleted=0;

--  更新权限表的parent_id，使用 inner join，因 root 没有 parent_id
UPDATE `dt_pub_service`.`auth_permission` a
INNER JOIN `dt_pub_service`.`auth_permission` b ON a.parent_id=b.old_permission_id AND b.app_type=7 AND b.is_deleted=0
SET a.parent_id = b.id
WHERE a.is_deleted = 0 AND a.app_type = 7;

--  权限中心迁移，用户角色表
DELETE FROM `dt_pub_service`.`auth_role_user` WHERE app_type=7 AND is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role_user`( `app_type`, `dtuic_tenant_id`, `project_id`, `role_id`, `dtuic_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `modify_user_id`, `create_user_id`)
SELECT 7, a.`tenant_id`, a.`project_id`, e.id AS role_id, a.`user_id`, a.`gmt_create`, a.`gmt_modified`, a.`is_deleted`, a.`modify_user_id`, a.`create_user_id`
FROM `streamapp`.`rdos_role_user` a
LEFT JOIN `dt_pub_service`.`auth_role` e ON e.old_role_id = a.role_id AND e.app_type=7 AND e.is_deleted=0
WHERE a.is_deleted=0;

--  权限中心迁移，角色权限表
DELETE FROM `dt_pub_service`.`auth_role_permission` WHERE app_type=7 AND is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role_permission`( `app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `modify_user_id`, `create_user_id`, `dtuic_tenant_id`, `project_id`)
SELECT 7, e.id AS role_id, f.id AS permission_id, a.`gmt_create`, a.`gmt_modified`, a.`is_deleted`, null, null, e.`dtuic_tenant_id`, e.`project_id`
FROM `streamapp`.`rdos_role_permission` a
LEFT JOIN `dt_pub_service`.`auth_role` e ON e.old_role_id = a.role_id AND e.app_type=7 AND e.is_deleted=0
LEFT JOIN `dt_pub_service`.`auth_permission` f ON f.old_permission_id = a.permission_id AND f.app_type=7 AND f.is_deleted=0
WHERE a.is_deleted=0 GROUP BY a.`role_id`, a.`permission_id`;

-- 迁移实时中的用户到业务中心，忽略已存在的用户
INSERT IGNORE INTO `dt_pub_service`.`ps_user` (
  `gmt_create`,
  `gmt_modified`,
  `create_user_id`,
  `modify_user_id`,
  `is_deleted`,
  `dtuic_user_id`,
  `user_name`,
  `user_email`,
  `user_status`,
  `phone_number`)
SELECT
  `gmt_create`,
  `gmt_modified`,
  null,
  null,
  `is_deleted`,
  `dtuic_user_id`,
  `user_name`,
  `email`,
  `status`,
  `phone_number`
FROM `streamapp`.`rdos_user`
WHERE is_deleted=0;

-- 迁移实时中的租户到业务中心，忽略已存在的租户
INSERT IGNORE INTO `dt_pub_service`.`ps_tenant` (
  `gmt_create`,
  `gmt_modified`,
  `create_user_id`,
  `modify_user_id`,
  `is_deleted`,
  `dtuic_tenant_id`,
  `tenant_name`,
  `tenant_desc`,
  `tenant_status`)
SELECT
  `gmt_create`,
  `gmt_modified`,
  null,
  null,
  `is_deleted`,
  `dtuic_tenant_id`,
  `tenant_name`,
  `tenant_desc`,
  `status`
FROM `streamapp`.`rdos_tenant`
WHERE is_deleted=0;
COMMIT;