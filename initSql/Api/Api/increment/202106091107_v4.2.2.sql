
alter table da_role_user add index idx_project_user_role(user_id, tenant_id, project_id, role_id);

alter table da_role_permission add index idx_role_permission(role_id, permission_id);