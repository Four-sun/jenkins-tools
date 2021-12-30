--  注意，这里的SQL有执行顺序要求，必须按照顺序执行
--  权限中心迁移，角色表
DELETE FROM `dt_pub_service`.`auth_role` where app_type = 1 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role`( `app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `create_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `old_role_id`)
select 1, tenant_id, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `create_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `id`
from `ide`.`rdos_role`
where is_deleted=0;


--  权限中心迁移，权限表
DELETE FROM `dt_pub_service`.`auth_permission` where app_type=1 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_permission`(`old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`)
select `id`, 1, `code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`
from `ide`.`rdos_permission`
where is_deleted=0;

--  更新权限表的parent_id
update `dt_pub_service`.`auth_permission` a
inner join `dt_pub_service`.`auth_permission` b on a.parent_id=b.old_permission_id and b.app_type=1 and b.is_deleted=0
set a.parent_id = b.id
where a.is_deleted = 0 and a.app_type = 1;

--  权限中心迁移，用户角色表
DELETE FROM `dt_pub_service`.`auth_role_user` where app_type=1 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role_user`( `app_type`, `dtuic_tenant_id`, `project_id`, `role_id`, `dtuic_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `modify_user_id`, `create_user_id`)
select 1, a.`tenant_id`, a.`project_id`, e.id as role_id, a.`user_id`, a.`gmt_create`, a.`gmt_modified`, a.`is_deleted`, a.`modify_user_id`, a.`create_user_id`
from `ide`.`rdos_role_user` a
inner join `dt_pub_service`.`auth_role` e on e.old_role_id = a.role_id and e.app_type=1 and e.is_deleted=0
where a.is_deleted=0;


--  权限中心迁移，角色权限表
DELETE FROM `dt_pub_service`.`auth_role_permission` where app_type=1 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role_permission`( `app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `modify_user_id`, `create_user_id`, `dtuic_tenant_id`, `project_id`)
select 1, e.id as role_id, f.id as permission_id, a.`gmt_create`, a.`gmt_modified`, a.`is_deleted`, a.`modify_user_id`, a.`create_user_id`, a.`tenant_id`, a.`project_id`
from `ide`.`rdos_role_permission` a
left join `ide`.`rdos_project` d on d.id = a.project_id and d.is_deleted=0
inner join `dt_pub_service`.`auth_role` e on e.old_role_id = a.role_id and e.app_type=1 and e.is_deleted=0
inner join `dt_pub_service`.`auth_permission` f on f.old_permission_id = a.permission_id and f.app_type=1 and f.is_deleted=0
where a.is_deleted=0 GROUP BY a.`role_id`, a.`permission_id`;


--  将离线用到的user和tenant迁移到业务中心
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
FROM ide.rdos_user
where is_deleted=0;


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
FROM ide.rdos_tenant
where is_deleted=0;
