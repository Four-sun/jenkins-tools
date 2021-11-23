INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 47, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 47) and role_value in (1,2,3,4,5);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 48, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 48) and role_value in (1,2,3,4,5);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 49, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 49) and role_value in (1,2,3,4,5);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 50, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 50) and role_value in (1,2,3,4);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 51, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 51) and role_value in (1,2,3,4);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 52, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 52) and role_value in (1,2,3,4);