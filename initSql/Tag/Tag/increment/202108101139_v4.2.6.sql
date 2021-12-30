ALTER TABLE dl_user_group
    ADD COLUMN uic_user_group_id int(11) null comment 'uic分组id';

ALTER TABLE dl_user_group_rel
    ADD COLUMN is_group_admin tinyint(1) default 0   not null comment '是否用户组管理员,1是，0否';

ALTER TABLE dl_user_group_tag_rel
    ADD COLUMN user_id         int(11)              null comment '用户id',
    ADD COLUMN tag_belong_type tinyint(1) default 0 not null comment '标签归属类型 0-用户组,1-个人';

ALTER TABLE dl_user_group_tag_rel
    MODIFY COLUMN user_group_id int(11)  null comment '用户组id';

ALTER TABLE dl_user
    MODIFY COLUMN email varchar(255) null comment '邮箱';

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (121, 'project_manage_member_mange', '项目管理-成员管理', '成员管理', 2);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 121, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 121)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (122, 'project_manage_member_mange_add', '项目管理-成员管理-添加成员', '添加成员', 121);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 122, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 122)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (123, 'project_manage_member_mange_remove_project', '项目管理-成员管理-移出项目', '移出项目', 121);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 123, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 123)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (124, 'project_manage_member_mange_query', '项目管理-成员管理-查看列表', '查看列表', 121);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 124, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 124)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (125, 'project_manage_member_mange_edit_role', '项目管理-成员管理-编辑角色', '编辑角色', 121);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 125, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 125)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (126, 'project_manage_member_mange_user_group_edit', '项目管理-成员管理-用户组编辑', '用户组编辑', 121);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 126, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 126)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (127, 'tag_center_authorization_security', '标签中心-授权与安全', '授权与安全', 31);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 127, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 127)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (128, 'tag_center_authorization_security_row_permission', '标签中心-授权与安全-行级权限', '行级权限', 127);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 128, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 128)
  and role_value in (1, 2, 3, 5, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (129, 'tag_center_authorization_security_row_permission_add', '标签中心-授权与安全-行级权限-创建', '创建', 128);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 129, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 129)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (130, 'tag_center_authorization_security_row_permission_edit', '标签中心-授权与安全-行级权限-编辑', '编辑', 128);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 130, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 130)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (131, 'tag_center_authorization_security_row_permission_del', '标签中心-授权与安全-行级权限-删除', '删除', 128);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 131, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 131)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (132, 'tag_center_authorization_security_row_permission_query', '标签中心-授权与安全-行级权限-查看', '查看', 128);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 132, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 132)
  and role_value in (1, 2, 3, 5, 7)
  and is_deleted = 0;