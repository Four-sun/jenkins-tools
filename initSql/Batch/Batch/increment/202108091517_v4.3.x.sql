--  支持重复执行，如果存在，则先删除需要新增的权限点
DELETE FROM `rdos_role_permission` where permission_id=(select id from `rdos_permission` where `code`='batchintegration_batch_mate_sync' and is_deleted=0);
DELETE FROM `rdos_permission` where `code`='batchintegration_batch_mate_sync' and is_deleted=0;

--  新增 元数据同步 权限点
INSERT INTO `rdos_permission`(`code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`)
select 'batchintegration_batch_mate_sync', '数据集成_元数据同步', '元数据同步', `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`
from rdos_permission
where `code`='batchintegration_batch_dbsync' and is_deleted=0;

--  批量插入 数据开发 以上角色的元数据同步权限(插入方法是找一个数据开发的角色权限-整库同步权限，将所有的数据复制一份，只修改权限Id)
INSERT INTO `rdos_role_permission`(`role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `create_user_id`, `modify_user_id`, `tenant_id`, `project_id`)
select a.`role_id`, b.id, a.`gmt_create`, a.`gmt_modified`, a.`is_deleted`, a.`create_user_id`, a.`modify_user_id`, a.`tenant_id`, a.`project_id`
from `rdos_role_permission` a
inner join `rdos_permission` b on b.`code`='batchintegration_batch_mate_sync' and b.is_deleted=0
inner join `rdos_permission` c on c.`code`='batchintegration_batch_dbsync' and c.is_deleted=0
where a.permission_id=c.id and a.is_deleted=0;