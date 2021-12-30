delete from dl_role_permission where permission_id = 47;
INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 47, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 47)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (85, 'tag_center_tag_config_tag_configure_tag_analysis_export', '标签中心_标签管理_标签配置_标签分析数据导出', '标签分析数据导出', 41);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 85, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 85)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (86, 'tag_center_tag_config_tag_configure_tag_analysis_version_manager', '标签中心_标签管理_标签配置_版本管理', '版本管理', 41);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 86, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 86)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (87, 'group_analysis_group_analysis_group_data_export', '群组分析_群组分析_群体数据导出', '群体数据导出', 70);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 87, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 87)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;