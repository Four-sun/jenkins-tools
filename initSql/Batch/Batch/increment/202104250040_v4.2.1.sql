-- 删除一部分历史is_deleted = 1 角色为平台管理员、租户所有者、租户管理员、访客数据
delete from rdos_role_user where is_deleted = 1 and role_id in (select id from rdos_role where role_value in (1,4,8,9));

-- 添加角色以及角色对应的规则（平台管理员、租户管理员）
DROP PROCEDURE IF EXISTS add_role_to_old_project;
delimiter //
create procedure add_role_to_old_project(in projectId int)
 begin
    DECLARE tenantId INT;
    DECLARE modifyUserId INT;
    -- 新增默认角色
    select tenant_id, project_id, modify_user_id from rdos_role where project_id = projectId and is_deleted = 0 limit 1 into tenantId, projectId, modifyUserId;
    -- 判断平台管理员是否已经添加
    SET @app_amin_role_count = (select count(1) from rdos_role where project_id = projectId and role_type = 1 and role_value = 8 and is_deleted = 0);
    IF  @app_amin_role_count = 0 THEN
        insert into rdos_role (tenant_id, project_id, role_name, role_type, role_value, role_desc,  modify_user_id)
        values (tenantId, projectId, '平台管理员', 1, 8,'本项目内的全部权限，所有租户的管理权限；', modifyUserId);
        -- 查询租户所有者角色ID
        set @tenant_owner_role_id = (select id from rdos_role where  project_id = projectId and role_type = 1 and role_value = 1 and is_deleted = 0);
        -- 查询平台管理员角色ID
        set @app_admin_role_id = (select id from rdos_role where  project_id = projectId and role_type = 1 and role_value = 8 and is_deleted = 0);
        insert into rdos_role_permission (role_id, permission_id)
            select @app_admin_role_id, permission_id from rdos_role_permission where role_id = @tenant_owner_role_id;
        END iF;

    -- 判断租户管理员是否已经添加
    SET @tenant_amin_role_count = (select count(1) from rdos_role where project_id = projectId and role_type = 1 and role_value = 9 and is_deleted = 0);
    IF  @tenant_amin_role_count = 0 THEN
        insert into rdos_role (tenant_id, project_id, role_name, role_type, role_value, role_desc,  modify_user_id)
        values  (tenantId, projectId, '租户管理员', 1, 9,'本项目内的全部权限，所有租户的管理权限；', modifyUserId);
        -- 查询租户所有者角色ID
        set @tenant_owner_role_id = (select id from rdos_role where  project_id = projectId and role_type = 1 and role_value = 1 and is_deleted = 0);
        -- 查询租户管理员角色ID
        set @tenant_admin_role_id = (select id from rdos_role where  project_id = projectId and role_type = 1 and role_value = 9 and is_deleted = 0);
        insert into rdos_role_permission (role_id, permission_id)
            select @tenant_admin_role_id, permission_id from rdos_role_permission where role_id = @tenant_owner_role_id;
    end if;
 end //
delimiter ;

-- 为历史项目增加平台管理员、租户管理者角色
DROP PROCEDURE IF EXISTS add_new_role_main;
delimiter //
create procedure add_new_role_main()
 begin
    DECLARE stop INT DEFAULT 0;
    DECLARE projectId INT;
    DECLARE  id_cur CURSOR  FOR  SELECT id FROM rdos_project where is_deleted = 0 and status = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;
    OPEN   id_cur;
     FETCH id_cur INTO projectId;
     WHILE ( stop is not null) DO
        call add_role_to_old_project(projectId);
       FETCH id_cur INTO projectId;
     END WHILE;
    CLOSE id_cur;
 end //
delimiter ;

-- 添加默认角色
call add_role_to_old_project(-1);
-- 为历史项目增加角色
call add_new_role_main();

drop procedure  add_role_to_old_project;
drop procedure  add_new_role_main;


-- 添加超级管理员到离线中
DROP PROCEDURE IF EXISTS add_amin_user_role_to_project;
delimiter //
create procedure add_amin_user_role_to_project()
begin
    DECLARE stopFlag INT DEFAULT 0;
    DECLARE projectId INT;
    DECLARE tenantId INT;
    DECLARE adminUserId INT;
    DECLARE adminUserName varchar(256);
    DECLARE adminUserPhone varchar(256);
    -- 查询所有的超级管理员用户
    DECLARE admin_user_id_cur CURSOR FOR SELECT id, username, phone
                                         from dtuic.uic_user
                                         where is_deleted = 'N'
                                           and is_root = 'Y';
    DECLARE project_cur CURSOR FOR SELECT id, tenant_id from rdos_project where is_deleted = 0 and status = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stopFlag = 1;
    OPEN admin_user_id_cur;
    FETCH admin_user_id_cur INTO adminUserId, adminUserName, adminUserPhone;
    WHILE (stopFlag <> 1)
        DO
            -- 判断该用户是否已经添加过
            SET @userId = (select id from rdos_user where dtuic_user_id = adminUserId and is_deleted = 0);
            IF @userId is null THEN
                insert into rdos_user (dtuic_user_id, user_name, email, phone_number, status)
                values (adminUserId, adminUserName, adminUserName, adminUserPhone, 0);
                select id from rdos_user where dtuic_user_id = adminUserId and is_deleted = 0 limit 1 into @userId;
            end if;
            -- 向所有的项目中添加平台管理员
            OPEN project_cur;
            FETCH project_cur INTO projectId, tenantId;
            WHILE (stopFlag <> 1)
                DO
                    SET @appAdminRoleId = (select id
                                           from rdos_role
                                           where project_id = projectId
                                             and role_type = 1
                                             and role_value = 8
                                             and is_deleted = 0);
                    -- 判断该项目是否已经有该用户且角色为平台管理员
                    SET @hasAppAdminRole = (select id
                                            from rdos_role_user
                                            where project_id = projectId
                                              and role_id = @appAdminRoleId
                                              and user_id = @userId);
                    IF @hasAppAdminRole is null THEN
                        insert into rdos_role_user (project_id, role_id, user_id, tenant_id)
                        values (projectId, @appAdminRoleId, @userId, tenantId);
                    END IF;

                     -- 判断是否有访客角色，没有的话则新增
                    SET @memberRoleId = (select id
                                   from rdos_role
                                   where project_id = projectId
                                     and role_type = 1
                                     and role_value = 4
                                     and is_deleted = 0);
                    IF @memberRoleId is not null THEN
                        SET @hasMemberRoleFlag = (select id
                                            from rdos_role_user
                                            where project_id = projectId
                                              and role_id = @memberRoleId
                                              and user_id = @userId
                                              and is_deleted = 0
                                            limit 1);
                        IF @hasMemberRoleFlag is null THEN
                            insert into rdos_role_user (project_id, role_id, user_id, tenant_id)
                            values (projectId, @memberRoleId, @userId, tenantId);
                        end if;
                    end if;

                    FETCH project_cur INTO projectId, tenantId;
                END WHILE;
            CLOSE project_cur;
            SET stopFlag = 0;

            FETCH admin_user_id_cur INTO adminUserId, adminUserName, adminUserPhone;
        END WHILE;
    close admin_user_id_cur;
end //
delimiter ;
call add_amin_user_role_to_project();
drop procedure add_amin_user_role_to_project;


-- 添加用户到项目中
DROP PROCEDURE IF EXISTS add_user_role_to_project;
delimiter //
create procedure add_user_role_to_project(in userId INT, in tenantId INT, in roleValue varchar(256))
begin
    DECLARE stopFlag INT DEFAULT 0;
    DECLARE projectId INT;

    -- 查询该租户下所有的项目
    DECLARE project_cur CURSOR FOR (select id from rdos_project where tenant_id = tenantId and is_deleted = 0 and status = 1);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stopFlag = 1;

    -- 向该租户下所有的项目中添加该角色
    OPEN project_cur;
    FETCH project_cur INTO projectId;
    WHILE (stopFlag <> 1)
        DO
            -- 查询该角色的roleId
            SET @roleId = (select id
                           from rdos_role
                           where project_id = projectId
                             and role_type = 1
                             and role_value = roleValue
                             and is_deleted = 0);
            IF @roleId is not null THEN
                -- 判断该用户是否已经拥有该角色，如果没有则新增
                SET @hasRoleFlag = (select id
                                    from rdos_role_user
                                    where project_id = projectId
                                      and role_id = @roleId
                                      and user_id = userId
                                      and is_deleted = 0
                                    limit 1);
                IF @hasRoleFlag is null THEN
                    insert into rdos_role_user (project_id, role_id, user_id, tenant_id)
                    values (projectId, @roleId, userId, tenantId);
                end if;
            END IF;

            -- 判断是否有访客角色，没有的话则新增
            SET @memberRoleId = (select id
                           from rdos_role
                           where project_id = projectId
                             and role_type = 1
                             and role_value = 4
                             and is_deleted = 0);
            IF @memberRoleId is not null THEN
                SET @hasMemberRoleFlag = (select id
                                    from rdos_role_user
                                    where project_id = projectId
                                      and role_id = @memberRoleId
                                      and user_id = userId
                                      and is_deleted = 0
                                    limit 1);
                IF @hasMemberRoleFlag is null THEN
                    insert into rdos_role_user (project_id, role_id, user_id, tenant_id)
                    values (projectId, @memberRoleId, userId, tenantId);
                end if;
            end if;

            FETCH project_cur INTO projectId;
        END WHILE;
   CLOSE project_cur;
end //
delimiter ;

-- 添加租户所有者
DROP PROCEDURE IF EXISTS add_tenant_owner_user_to_project;
delimiter //
create procedure add_tenant_owner_user_to_project(in uicTenantId INT, in tenantId INT)
label :
begin
    -- 查询该租户下所有的租户所有者
    SELECT uu.id       as own_user_id,
           uu.username as own_user_name,
           uu.phone    as own_user_phone
    FROM dtuic.uic_user uu
             LEFT JOIN dtuic.uic_tenant ut on uu.id = ut.belong_user_id
    WHERE ut.id = uicTenantId
      and uu.is_deleted = 'N'
      and ut.is_deleted = 'N'
    limit 1
    into @tenantOwnerUserId, @tenantOwnerUserIdName, @tenantOwnerPhone;
    IF @tenantOwnerUserId is null THEN
        LEAVE label;
    END IF;
    -- 获取该租户所有者信息，如果没有，则新增
    SET @userId = (select id from rdos_user where dtuic_user_id = @tenantOwnerUserId and is_deleted = 0);
    IF @userId is null THEN
        insert into rdos_user (dtuic_user_id, user_name, email, phone_number, status)
        values (@tenantOwnerUserId, @tenantOwnerUserIdName, @tenantOwnerUserIdName, @tenantOwnerPhone, 0);
        SET @userId = (select id from rdos_user where dtuic_user_id = @tenantOwnerUserId and is_deleted = 0);
    END IF;

    -- 添加租户所有者
    call add_user_role_to_project(@userId, tenantId, 1);
end //
delimiter ;


-- 添加租户管理员
DROP PROCEDURE IF EXISTS add_tenant_admin_user_to_project;
delimiter //
create procedure add_tenant_admin_user_to_project(in uicTenantId INT, in tenantId INT)
begin
    DECLARE stopFlag INT DEFAULT 0;
    DECLARE dtuicUserId INT;
    DECLARE dtuicUserName VARCHAR(256);
    DECLARE dtuicUserPhone VARCHAR(256);

    --  查询uic 租户下所有租户管理员信息
    DECLARE tenant_admin_cur CURSOR FOR (
        SELECT uu.id as admin_user_id,
               uu.username  as admin_user_name,
               uu.phone     as admin_user_phone
        FROM dtuic.uic_user_tenant_rel ut
                 LEFT JOIN dtuic.uic_user uu on uu.id = ut.user_id
        WHERE ut.tenant_id = uicTenantId
          and uu.is_deleted = 'N'
          and ut.is_deleted = 'N'
          and ut.is_admin = 'Y'
    );
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stopFlag = 1;

    -- 向该租户下所有的项目中添加该用户
    OPEN tenant_admin_cur;
    FETCH tenant_admin_cur INTO dtuicUserId, dtuicUserName, dtuicUserPhone;
    WHILE (stopFlag <> 1)
        DO
              -- 获取该租户管理员信息，如果没有，则新增
            SET @userId = (select id from rdos_user where dtuic_user_id = dtuicUserId and is_deleted = 0);
            IF @userId is null THEN
                insert into rdos_user (dtuic_user_id, user_name, email, phone_number, status)
                values (dtuicUserId, dtuicUserName, dtuicUserName, dtuicUserPhone, 0);
                select id from rdos_user where dtuic_user_id = dtuicUserId and is_deleted = 0 into @userId;
            END IF;
             -- 添加租户管理员
            call add_user_role_to_project(@userId, tenantId, 9);

            FETCH tenant_admin_cur INTO dtuicUserId, dtuicUserName, dtuicUserPhone;
        END WHILE;
   CLOSE tenant_admin_cur;
end //
delimiter ;

-- 向离线所有项目中添加租户所有者、租户管理员
DROP PROCEDURE IF EXISTS add_user_to_project_main;
delimiter //
create procedure add_user_to_project_main()
begin
    DECLARE stopFlag INT DEFAULT 0;
    DECLARE tenantId INT;
    DECLARE uicTenantId INT;

     --  查询离线 所有租户信息
    DECLARE tenant_cur CURSOR FOR (
        SELECT id, dtuic_tenant_id
        from rdos_tenant
        WHERE is_deleted = 0
    );
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stopFlag = 1;

    -- 向该租户下所有的项目中添加租户所有者、租户管理员
    OPEN tenant_cur;
    FETCH tenant_cur INTO tenantId, uicTenantId;
    WHILE (stopFlag <> 1)
        DO
            call add_tenant_owner_user_to_project(uicTenantId, tenantId);
            call add_tenant_admin_user_to_project(uicTenantId, tenantId);
            FETCH tenant_cur INTO tenantId, uicTenantId;
        END WHILE;
   CLOSE tenant_cur;
end //
delimiter ;
call add_user_to_project_main();

drop procedure add_user_role_to_project;
drop procedure add_tenant_admin_user_to_project;
drop procedure add_tenant_owner_user_to_project;
drop procedure add_user_to_project_main;






