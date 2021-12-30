delete from dt_pub_service.auth_permission where app_type = 4;
delete from dt_pub_service.auth_role where app_type = 4;
delete from dt_pub_service.auth_role_permission where app_type = 4;
delete from dt_pub_service.auth_role_user where app_type = 4;

update tagapp.dl_role set role_desc = '本项目内的全部权限，具有本项目内的最高权限，但不能对租户所有者操作' where role_value = 7 and is_deleted = 0;

-- 修改之前错误的层级关系
update tagapp.dl_permission set parent_id = 106 where id in (107,108);

-- 运营/数据开发 新增群组订阅权限
INSERT INTO tagapp.dl_role_permission (role_id, permission_id, create_at, update_at, create_by, update_by, is_deleted)
select id, 99, NOW(), NOW(), 0, 0, 0 from tagapp.dl_role
where id not in (select role_id from tagapp.dl_role_permission where permission_id = 99)
and role_value in (4, 6) and is_deleted = 0;

-- 清理关联表脏数据
update tagapp.dl_role_user
set role_id = (
    select min(id) from tagapp.dl_role
    where project_id = (select project_id from tagapp.dl_role where id = role_id)
      and tenant_id = (select tenant_id from tagapp.dl_role where id = role_id)
      and role_value = (select role_value from tagapp.dl_role where id = role_id)
      and is_deleted = 0
);

-- 清理重复数据
delete from tagapp.dl_role_user where id not in (
    select id from (
                   select min(id) id, project_id, user_id ,role_id, tenant_id from tagapp.dl_role_user
                   where is_deleted = 0
                   group by project_id, user_id ,role_id, tenant_id
               ) res);

-- 清理关联表脏数据
update tagapp.dl_role_permission
set role_id = (
    select min(id) from tagapp.dl_role
    where project_id = (select project_id from tagapp.dl_role where id = role_id)
      and tenant_id = (select tenant_id from tagapp.dl_role where id = role_id)
      and role_value = (select role_value from tagapp.dl_role where id = role_id)
      and is_deleted = 0
);

-- 先执行此条语句，整理数据
delete from tagapp.dl_role_user where user_id not in (select u.id from tagapp.dl_user u where u.is_deleted = 0);

-- 清理重复数据
delete from tagapp.dl_role_permission where id not in (
    select id from (
                       select min(id) id, role_id, permission_id from tagapp.dl_role_permission
                       where is_deleted = 0
                       group by role_id, permission_id
                   ) res);

-- 插入非初始角色
insert into dt_pub_service.auth_role
(app_type, dtuic_tenant_id, project_id, role_name, role_type, role_value, role_desc
, modify_user_id, create_user_id, gmt_create, gmt_modified, is_deleted, old_role_id)
    (select 4 as app_type, r.tenant_id, r.project_id, r.role_name, r.role_type,
-- 处理 role_value
            (case r.role_value
                 when '1' then '1'
                 when '2' then '2'
                 when '3' then '3'
                 when '4' then '5'
                 when '5' then '4'
                 when '6' then '6'
                 when '7' then '9'
                 else '' end) as role_value,
            r.role_desc, u2.dtuic_user_id, u.dtuic_user_id, r.create_at, r.update_at, r.is_deleted, r.id
     from tagapp.dl_role r
              -- left join tagapp.dl_tenant t on r.tenant_id = t.id -- 表里本来就是
-- dtuictenantid
              left join tagapp.dl_user u on r.create_by = u.id
              left join tagapp.dl_user u2 on r.update_by = u2.id
     where r.tenant_id != -1 and r.project_id != -1 and r.is_deleted = 0

-- 重复没有地方用到的话加上下面的条件
       and r.id in (select id from (select min(id) as id, project_id , tenant_id, role_value from tagapp.dl_role where is_deleted = 0
                                    group by project_id , tenant_id , role_value) res));


-- 插入初始角色
insert into dt_pub_service.auth_role
(app_type, dtuic_tenant_id, project_id, role_name, role_type, role_value, role_desc, modify_user_id, create_user_id, gmt_create,
 gmt_modified, is_deleted, old_role_id)
    (select
         4 as app_type, -1 as tenant_id, -1 as project_id, r.role_name, r.role_type,
-- 处理 role_value
         (case r.role_value
              when '1' then '1'
              when '2' then '2'
              when '3' then '3'
              when '4' then '5'
              when '5' then '4'
              when '6' then '6'
              when '7' then '9'
              else '' end) as role_value, r.role_desc, u2.dtuic_user_id, u.dtuic_user_id, r.create_at, r.update_at, r.is_deleted, r.id
     from tagapp.dl_role r
              left join tagapp.dl_user u on r.create_by = u.id
              left join tagapp.dl_user u2 on r.update_by = u2.id
     where r.tenant_id = -1 and r.project_id = -1 and r.is_deleted = 0

-- 重复没有地方用到的话加上下面的条件
       and r.id in (select id from (select min(id) as id, project_id , tenant_id, role_value from tagapp.dl_role where is_deleted = 0
                                    group by project_id , tenant_id , role_value) res));

-- 先插入数据
insert into dt_pub_service.auth_permission
(old_permission_id, app_type, code, name, display, type,  gmt_create, gmt_modified, is_deleted)
    (select id, 4 as app_type, code, name, display, type, create_at, update_at ,is_deleted
     from tagapp.dl_permission where is_deleted = 0);

-- 再补充 parent_id
update dt_pub_service.auth_permission np
    left join
-- 先转义原表中的 parent_id 成新的 id
    (select
         ap.id as ap_id, dp.id as dp_id
     from tagapp.dl_permission dp
              left join dt_pub_service.auth_permission ap on dp.parent_id = ap.old_permission_id and ap.app_type = 4
     where ap.app_type = 4
    ) as op on np.old_permission_id = op.dp_id
-- 赋值新的 parent_id 给新表中的 parent_id
set np.parent_id = op.ap_id
where app_type = 4;

insert into dt_pub_service.auth_role_permission
(app_type, role_id, permission_id, gmt_create, gmt_modified, is_deleted, modify_user_id, create_user_id, dtuic_tenant_id, project_id)
    (select 4 as app_type, drp.role_id, drp.permission_id, drp.create_at, drp.update_at, drp.is_deleted, drp.update_by, drp.create_by, 0, 0
     from tagapp.dl_role_permission drp
     where drp.is_deleted = 0
    );

update dt_pub_service.auth_role_permission arp
    left join dt_pub_service.auth_role ar on ar.old_role_id = arp.role_id and ar.app_type = 4
    left join dt_pub_service.auth_permission ap on ap.old_permission_id = arp.permission_id and ap.app_type = 4
    left join tagapp.dl_user u on arp.create_user_id = u.id
    left join tagapp.dl_user u2 on arp.modify_user_id = u2.id
set arp.role_id = ar.id, arp.permission_id = ap.id, arp.project_id = ar.project_id, arp.dtuic_tenant_id = ar.dtuic_tenant_id
  , arp.create_user_id = u.dtuic_user_id, arp.modify_user_id = u2.dtuic_user_id where arp.app_type = 4;

insert into dt_pub_service.auth_role_user
(app_type, dtuic_tenant_id, project_id, role_id, dtuic_user_id, gmt_create, gmt_modified, is_deleted, modify_user_id, create_user_id)
    (select
         4 as app_type, dru.tenant_id, dru.project_id, dru.role_id, dru.user_id, dru.create_at, dru.update_at, dru.is_deleted, 0, 0
     from
         (select * from tagapp.dl_role_user where id in (select id from
             (select min(id) as id, project_id , user_id, role_id from tagapp.dl_role_user where is_deleted = 0
              group by project_id , user_id , role_id) res )) as dru
    );

update dt_pub_service.auth_role_user aru
    left join dt_pub_service.auth_role ar on aru.role_id = ar.old_role_id and ar.app_type = 4
    left join tagapp.dl_user u on aru.dtuic_user_id = u.id
    left join tagapp.dl_user u2 on aru.create_user_id = u2.id
    left join tagapp.dl_user u3 on aru.modify_user_id = u3.id
set aru.role_id = ar.id, aru.dtuic_user_id = u.dtuic_user_id, aru.create_user_id = u2.dtuic_user_id, aru.modify_user_id = u3.dtuic_user_id
where aru.app_type = 4;

update tagapp.dl_statistics_cycle set update_by=create_by where is_deleted=0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1247 AND app_type = 4;

INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1247, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1247)
  AND role_value IN (1, 2, 3, 4, 5, 6, 7, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1249 AND app_type = 4;

INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1249, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1249)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1251 AND app_type = 4;

INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1251, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1251)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1253 AND app_type = 4;

INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1253, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1253)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1341 AND app_type = 4;

INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1341, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1341)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1333 AND app_type = 4;
INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1333, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1333)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1331 AND app_type = 4;
INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1331, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1331)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1323 AND app_type = 4;
INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1323, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1323)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1335 AND app_type = 4;
INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1335, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1335)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;

DELETE FROM dt_pub_service.auth_role_permission WHERE permission_id = 1337 AND app_type = 4;
INSERT INTO dt_pub_service.auth_role_permission(`app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 4, id, 1337, NOW(), NOW(), 0, auth_role.dtuic_tenant_id, auth_role.project_id
FROM dt_pub_service.auth_role
WHERE dt_pub_service.auth_role.id NOT IN (SELECT role_id
                         FROM dt_pub_service.auth_role_permission
                         WHERE permission_id = 1337)
  AND role_value IN (1, 2, 3, 9)
  AND app_type = 4
  AND is_deleted = 0;