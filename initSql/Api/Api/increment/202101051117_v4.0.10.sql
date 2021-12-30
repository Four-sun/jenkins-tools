-- 修改role_user表索引
drop index  tenant_user_role on da_role_user;
alter table da_role_user add unique idx_user_role(user_id,role_id,tenant_id,project_id);