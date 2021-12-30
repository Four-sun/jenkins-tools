-- api 添加索引
ALTER TABLE `da_role_user`
ADD INDEX `idx_role`(`role_id`) USING BTREE,
ADD INDEX `idx_tenant_project`(`tenant_id`,`project_id`) USING BTREE;

ALTER TABLE `da_api_catalogue`
ADD INDEX `idx_pid_tenant_project`(`tenant_id`, `pid`, `project_id`) USING BTREE;
