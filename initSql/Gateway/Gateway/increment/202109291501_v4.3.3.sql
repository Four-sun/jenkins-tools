-- gateway 添加索引
ALTER TABLE `da_api`
ADD INDEX `idx_tenant_project_cat`(`tenant_id`, `project_id`,`cat_id`) USING BTREE;