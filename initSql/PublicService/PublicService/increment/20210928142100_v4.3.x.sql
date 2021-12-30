-- 删除auth_role添加索引
ALTER table auth_role ADD UNIQUE(`project_id`, `dtuic_tenant_id`, `role_value`, `app_type`);
ALTER table auth_role ADD INDEX(`dtuic_tenant_id`, `project_id`);