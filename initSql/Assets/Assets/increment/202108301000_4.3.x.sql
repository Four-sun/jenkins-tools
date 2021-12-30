-- 修复租户管理员无数据标准权限

delete from assets_role_permission
where permission_id in (401, 402, 403, 404, 405, 406, 407, 408, 409)
  and role_id in (select id from assets_role where role_value = 5);

insert into assets_role_permission(role_id,permission_id)
select id, 401
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 402
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 403
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 404
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 405
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 406
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 407
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 408
from assets_role
where role_value = 5;

insert into assets_role_permission(role_id,permission_id)
select id, 409
from assets_role
where role_value = 5;