INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (79, 'group_analysis_manage_high_proportion_query', '群组分析_群组管理_显著性分析', '显著性分析', 65);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 79, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 79)
  and role_value in (1, 2, 3, 4, 6, 7);

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (80, 'group_analysis_entity_portrayal', '群组分析_实体画像', '实体画像查看', 64);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 80, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 80)
  and role_value in (1, 2, 3, 4, 6, 7);

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (81, 'group_analysis_portrayal_set', '群组分析_画像设置', '画像设置', 64);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 81, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 81)
  and role_value in (1, 2, 3, 7);

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (82, 'group_analysis_entity_portrayal_set', '群组分析_画像设置_实体画像设置', '实体画像设置', 81);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 82, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 82)
  and role_value in (1, 2, 3, 7);


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (83, 'group_analysis_group_portrayal_set', '群组分析_画像设置_群组画像设置', '群组画像设置', 81);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 83, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 83)
  and role_value in (1, 2, 3, 7);


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (84, 'group_analysis_manage_group_portrayal_query', '群组分析_群组管理_群组画像查看', '群组画像查看', 65);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 84, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 84)
  and role_value in (1, 2, 3, 4, 6, 7);