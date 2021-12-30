
-- 角色表 
INSERT INTO `dt_pub_service`.`auth_role` (
  `app_type`,
  `dtuic_tenant_id`,
  `project_id`,
  `role_name`,
  `role_type`,
  `role_value`,
  `role_desc`,
  `modify_user_id`,
  `create_user_id`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`,
  `old_role_id`)
SELECT
  9,
  CASE
    WHEN role.tenant_id = -1 THEN
      -1
    WHEN tenant.dtuic_tenant_id = NULL THEN
      0
    ELSE
      tenant.dtuic_tenant_id
    END,
  CASE
    WHEN role.tenant_id = -1 THEN
      -1
    ELSE
      0
    END,
  role.`role_name`,
  role.`role_type`,
  role.`role_value`,
  role.`role_desc`,
  muser.dtuic_user_id,
  cuser.dtuic_user_id,
  role.update_at,
  role.create_at,
  role.`is_deleted`,
  role.id
FROM assets.assets_role role
       LEFT JOIN assets.assets_tenant tenant ON role.tenant_id = tenant.id
       LEFT JOIN assets.assets_user cuser ON role.create_by = cuser.id
       LEFT JOIN assets.assets_user muser ON role.update_by = muser.id;

-- 权限表
INSERT INTO `dt_pub_service`.`auth_permission` (
  `old_permission_id`,
  `app_type`,
  `code`,
  `name`,
  `display`,
  `parent_id`,
  `type`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`)
SELECT
  `id`,
  9,
  `permission_code`,
  `permission_name`,
  `permission_display`,
  `parent_id`,
  `permission_type`,
  `create_at`,
  `update_at`,
  `is_deleted`
FROM assets.assets_permission;
-- 更新父Id
UPDATE dt_pub_service.auth_permission AS ap1 INNER JOIN dt_pub_service.auth_permission AS ap2 ON ap1.parent_id = ap2.old_permission_id SET ap1.parent_id = ap2.id WHERE ap1.app_type = 9 AND ap2.app_type = 9;

-- 角色权限表
INSERT INTO `dt_pub_service`.`auth_role_permission` (
  `app_type`,
  `role_id`,
  `permission_id`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`,
  `modify_user_id`,
  `create_user_id`,
  `dtuic_tenant_id`)
SELECT
  9,
  role.id,
  per.id,
  arp.`create_at`,
  arp.`update_at`,
  arp.`is_deleted`,
  muser.dtuic_user_id,
  cuser.dtuic_user_id,
  role.dtuic_tenant_id
FROM assets.assets_role_permission arp
       LEFT JOIN dt_pub_service.auth_role role ON role.old_role_id = arp.role_id
       LEFT JOIN dt_pub_service.auth_permission per ON per.old_permission_id = arp.permission_id
       LEFT JOIN assets.assets_user cuser ON arp.create_by = cuser.id
       LEFT JOIN assets.assets_user muser ON arp.update_by = muser.id WHERE role.app_type = 9 AND per.app_type = 9;

-- 角色用户表
INSERT IGNORE INTO `dt_pub_service`.`auth_role_user` (
  `app_type`,
  `project_id`,
  `dtuic_tenant_id`,
  `role_id`,
  `dtuic_user_id`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`,
  `modify_user_id`,
  `create_user_id`)
SELECT
  9,
  0,
  tenant.dtuic_tenant_id,
  role.id,
  users.dtuic_user_id,
  ars.`create_at`,
  ars.`update_at`,
  ars.is_deleted,
  muser.dtuic_user_id,
  cuser.dtuic_user_id
FROM assets.assets_role_user ars
       LEFT JOIN assets.assets_tenant tenant ON ars.tenant_id = tenant.id
       LEFT JOIN assets.assets_user cuser ON ars.create_by = cuser.id
       LEFT JOIN assets.assets_user muser ON ars.update_by = muser.id
       LEFT JOIN dt_pub_service.auth_role role ON role.old_role_id = ars.role_id
       LEFT JOIN assets.assets_user users ON ars.user_id = users.id WHERE role.app_type = 9 AND ars.is_deleted = 0;

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
  users.`create_at`,
  users.`update_at`,
  cuser.dtuic_user_id,
  muser.dtuic_user_id,
  users.`is_deleted`,
  users.`dtuic_user_id`,
  users.`user_name`,
  users.`user_email`,
  users.`user_status`,
  users.`phone_number`
FROM assets.assets_user users
       LEFT JOIN assets.assets_user cuser ON users.create_by = cuser.id
       LEFT JOIN assets.assets_user muser ON users.update_by = muser.id;


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
  tenant.`create_at`,
  tenant.`update_at`,
  cuser.dtuic_user_id,
  muser.dtuic_user_id,
  tenant.`is_deleted`,
  tenant.`dtuic_tenant_id`,
  tenant.`tenant_name`,
  tenant.`tenant_desc`,
  tenant.`tenant_status`
FROM assets.assets_tenant tenant
       LEFT JOIN assets.assets_user cuser ON tenant.create_by = cuser.id
       LEFT JOIN assets.assets_user muser ON tenant.update_by = muser.id;