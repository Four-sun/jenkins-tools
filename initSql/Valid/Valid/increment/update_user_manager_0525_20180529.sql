-- 更新原有角色
UPDATE dq_role role SET role.role_name = '租户所有者' where role.role_value = 1;
UPDATE dq_role role SET role.role_name = '产品管理员' where role.role_value = 2;
-- 新增数据开发角色
INSERT INTO dq_role(tenant_id, role_name, role_value, modify_user_id)VALUES(-1, '数据开发', 4, 1);

-- 增加数据开发权限
INSERT INTO dq_role_permission (role_id, permission_id) VALUES
((SELECT id FROM dq_role WHERE role_value = 4), 5),
((SELECT id FROM dq_role WHERE role_value = 4), 7),
((SELECT id FROM dq_role WHERE role_value = 4), 11),
((SELECT id FROM dq_role WHERE role_value = 4), 13),
((SELECT id FROM dq_role WHERE role_value = 4), 17),
((SELECT id FROM dq_role WHERE role_value = 4), 19),
((SELECT id FROM dq_role WHERE role_value = 4), 23),
((SELECT id FROM dq_role WHERE role_value = 4), 29),
((SELECT id FROM dq_role WHERE role_value = 4), 31),
((SELECT id FROM dq_role WHERE role_value = 4), 37);

-- 增加产品管理员的数据源管理编辑权限
INSERT INTO dq_role_permission (role_id, permission_id) VALUES((SELECT id FROM dq_role WHERE role_value = 2), (select id from dq_permission where code = 'datasource_edit'));

-- 数据开发角色roleValue从2修改为4
UPDATE dq_role_user SET role_id = (SELECT id FROM dq_role WHERE role_value = 4) WHERE role_id = (SELECT id FROM dq_role WHERE role_value = 2);
-- 原有的管理员角色修改为产品管理员角色
UPDATE dq_role_user SET role_id = (SELECT id FROM dq_role WHERE role_value = 2) where role_id = (SELECT id FROM dq_role WHERE role_value = 1);
UPDATE dq_role_user SET role_id = (SELECT id FROM dq_role WHERE role_value = 1) where user_id = 1;