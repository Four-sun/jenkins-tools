DELETE FROM `dt_pub_service`.`auth_role` WHERE app_type = 3;

DELETE FROM `dt_pub_service`.`auth_role_user` WHERE app_type = 3;

DELETE FROM `dt_pub_service`.`auth_permission` WHERE app_type = 3;

DELETE FROM `dt_pub_service`.`auth_role_permission` WHERE app_type = 3;

DELETE FROM `dt_pub_service`.`auth_project` WHERE app_type = 3;

INSERT INTO `dt_pub_service`.`auth_role`
(`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`,
`create_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `old_role_id`)
SELECT 3,CASE WHEN a.project_id = -1 THEN -1 ELSE b.dtuic_tenant_id END,a.project_id,a.role_name,a.role_type,
a.role_value,a.role_desc,a.modify_user_id,a.modify_user_id,a.gmt_create,a.gmt_modified,0,a.id
FROM da_role a LEFT JOIN da_tenant b ON a.tenant_id = b.id where a.is_deleted = 0;

INSERT INTO `dt_pub_service`.`auth_role_user` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_id`,
`dtuic_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`)
SELECT 3,b.dtuic_tenant_id,IFNULL(a.project_id,-1),a.role_id,c.dtuic_user_id,a.gmt_create,a.gmt_modified,0
FROM da_role_user a LEFT JOIN da_tenant b ON a.tenant_id = b.id
LEFT JOIN da_user c ON a.user_id = c.id WHERE a.is_deleted = 0 AND b.is_deleted = 0 AND c.is_deleted = 0;

INSERT INTO `dt_pub_service`.`auth_permission` (`old_permission_id`, `app_type`, `code`,
`name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`)
SELECT id,3,`code`,`name`,display,parent_id,type,gmt_create,gmt_modified,0 FROM da_permission where is_deleted = 0;

INSERT INTO `dt_pub_service`.`auth_role_permission` (`app_type`, `role_id`, `permission_id`,
`gmt_create`, `gmt_modified`, `is_deleted`, `dtuic_tenant_id`, `project_id`)
SELECT 3,a.role_id,a.permission_id,a.gmt_create,a.gmt_modified,a.is_deleted,c.dtuic_tenant_id,b.project_id
FROM da_role_permission a LEFT JOIN da_role b ON a.role_id = b.id LEFT JOIN da_tenant c ON c.id = b.tenant_id
GROUP BY a.role_id,a.permission_id ;

INSERT INTO `dt_pub_service`.`auth_project` (`project_id`, `dtuic_tenant_id`, `app_type`, `project_name`,
`project_alias`, `project_Identifier`, `project_desc`, `status`, `create_user_id`, `gmt_create`,
`gmt_modified`, `is_deleted`)
SELECT a.id,b.dtuic_tenant_id,3,a.project_name,a.project_alias,a.project_identifier,a.project_desc,
a.`status`,a.create_user_id,a.gmt_create,a.gmt_modified,a.is_deleted
FROM da_project a LEFT JOIN da_tenant b ON a.tenant_id = b.id where a.app_type = 3 AND a.is_deleted = 0 AND b.is_deleted = 0;

UPDATE dt_pub_service.auth_role_permission a,
dt_pub_service.auth_permission b,
dt_pub_service.auth_role c set a.role_id = c.id,a.permission_id = b.id
WHERE a.role_id = c.old_role_id AND a.permission_id = b.old_permission_id AND a.app_type = 3 AND b.app_type = 3 AND c.app_type = 3 ;

UPDATE dt_pub_service.auth_role_user a , dt_pub_service.auth_role b
set a.role_id = b.id
WHERE a.app_type = 3 AND b.app_type = 3 and a.role_id = b.old_role_id;

UPDATE dt_pub_service.auth_permission a, dt_pub_service.auth_permission b
set a.parent_id = b.id
WHERE a.app_type = 3 AND b.app_type = 3 and a.parent_id = b.old_permission_id AND a.parent_id != 0;
