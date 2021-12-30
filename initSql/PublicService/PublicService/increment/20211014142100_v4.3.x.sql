-- 修改 auth_role_user 唯一索引
ALTER TABLE  auth_role_user DROP INDEX `index_project_user_role`;
ALTER TABLE auth_role_user ADD UNIQUE index_project_user_role(`project_id`, `dtuic_user_id`,`dtuic_tenant_id`, `role_id`, `app_type`);