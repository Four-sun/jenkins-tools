-- 更新原有角色
UPDATE da_role role SET role.role_name = '租户所有者' where role.role_value = 1;
UPDATE da_role role SET role.role_name = '产品管理员' where role.role_value = 2;
-- 新增角色
INSERT INTO da_role(tenant_id, role_name, role_value, modify_user_id)VALUES(-1, '访客', 3, 1);
INSERT INTO da_role(tenant_id, role_name, role_value, modify_user_id)VALUES(-1, '应用开发', 4, 1);

-- 产品管理员角色权限
DELETE FROM da_role_permission WHERE role_id = (SELECT id FROM da_role WHERE role_value = 2);
INSERT INTO da_role_permission (role_id, permission_id) VALUES
((SELECT id FROM da_role WHERE role_value = 2), 4),
((SELECT id FROM da_role WHERE role_value = 2), 6),
((SELECT id FROM da_role WHERE role_value = 2), 22),
((SELECT id FROM da_role WHERE role_value = 2), 24),
((SELECT id FROM da_role WHERE role_value = 2), 28),
((SELECT id FROM da_role WHERE role_value = 2), 30),
((SELECT id FROM da_role WHERE role_value = 2), 42),
((SELECT id FROM da_role WHERE role_value = 2), 44),
((SELECT id FROM da_role WHERE role_value = 2), 48),
((SELECT id FROM da_role WHERE role_value = 2), 50),
((SELECT id FROM da_role WHERE role_value = 2), 54),
((SELECT id FROM da_role WHERE role_value = 2), 56),
((SELECT id FROM da_role WHERE role_value = 2), 60),
((SELECT id FROM da_role WHERE role_value = 2), 62),
((SELECT id FROM da_role WHERE role_value = 2), 66),
((SELECT id FROM da_role WHERE role_value = 2), 68),
((SELECT id FROM da_role WHERE role_value = 2), 72),
((SELECT id FROM da_role WHERE role_value = 2), 74),
((SELECT id FROM da_role WHERE role_value = 2), 78),
((SELECT id FROM da_role WHERE role_value = 2), 82),
((SELECT id FROM da_role WHERE role_value = 2), 84),
((SELECT id FROM da_role WHERE role_value = 2), 86),
((SELECT id FROM da_role WHERE role_value = 2), 88),
((SELECT id FROM da_role WHERE role_value = 2), 90),
((SELECT id FROM da_role WHERE role_value = 2), 92),
((SELECT id FROM da_role WHERE role_value = 2), 77),
((SELECT id FROM da_role WHERE role_value = 2), 81);


-- 增加访客权限
INSERT INTO da_role_permission (role_id, permission_id) VALUES
((SELECT id FROM da_role WHERE role_value = 3), 4),
((SELECT id FROM da_role WHERE role_value = 3), 22),
((SELECT id FROM da_role WHERE role_value = 3), 28),
((SELECT id FROM da_role WHERE role_value = 3), 42),
((SELECT id FROM da_role WHERE role_value = 3), 48),
((SELECT id FROM da_role WHERE role_value = 3), 54),
((SELECT id FROM da_role WHERE role_value = 3), 60),
((SELECT id FROM da_role WHERE role_value = 3), 66),
((SELECT id FROM da_role WHERE role_value = 3), 72),
((SELECT id FROM da_role WHERE role_value = 3), 77),
((SELECT id FROM da_role WHERE role_value = 3), 78),
((SELECT id FROM da_role WHERE role_value = 3), 81),
((SELECT id FROM da_role WHERE role_value = 3), 82),
((SELECT id FROM da_role WHERE role_value = 3), 84),
((SELECT id FROM da_role WHERE role_value = 3), 86),
((SELECT id FROM da_role WHERE role_value = 3), 90),
((SELECT id FROM da_role WHERE role_value = 3), 92);

-- 增加应用开发权限,概览（仅看到自己的API）、API市场、我的API
INSERT INTO da_role_permission (role_id, permission_id) VALUES
((SELECT id FROM da_role WHERE role_value = 4), 48),
((SELECT id FROM da_role WHERE role_value = 4), 50),
((SELECT id FROM da_role WHERE role_value = 4), 86),
((SELECT id FROM da_role WHERE role_value = 4), 42),
((SELECT id FROM da_role WHERE role_value = 4), 44),
((SELECT id FROM da_role WHERE role_value = 4), 60),
((SELECT id FROM da_role WHERE role_value = 4), 84),
((SELECT id FROM da_role WHERE role_value = 4), 81),
((SELECT id FROM da_role WHERE role_value = 4), 82);

-- 访客roleValue从2修改为3
UPDATE da_role_user SET role_id = (SELECT id FROM da_role WHERE role_value = 3) WHERE role_id = (SELECT id FROM da_role WHERE role_value = 2);
-- 原有的管理员角色修改为产品管理员角色
UPDATE da_role_user SET role_id = (SELECT id FROM da_role WHERE role_value = 2) where role_id = (SELECT id FROM da_role WHERE role_value = 1);
UPDATE da_role_user SET role_id = (SELECT id FROM da_role WHERE role_value = 1) where user_id = 1;