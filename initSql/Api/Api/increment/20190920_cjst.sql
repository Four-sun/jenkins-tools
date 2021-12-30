-- 增加数据开发角色 （数据开发的api管理权限中，查看、编辑权限都有。但数据开发只能编辑、发布、禁用、启用自己创建的api，不能修改和管理他人的API，但可查看他人的API信息）
INSERT INTO `da_role` VALUES ('5', '-1', '数据开发', '1', '5', '可进行API生成、发布、申请，但不具备API管理、授权审批、用户管理权限', '0', now(), now(), '0');

INSERT INTO da_role_permission (role_id, permission_id) VALUES
((SELECT id FROM da_role WHERE role_value = 5), 2),
((SELECT id FROM da_role WHERE role_value = 5), 4),
((SELECT id FROM da_role WHERE role_value = 5), 32),
((SELECT id FROM da_role WHERE role_value = 5), 76),
((SELECT id FROM da_role WHERE role_value = 5), 77),
((SELECT id FROM da_role WHERE role_value = 5), 78),
((SELECT id FROM da_role WHERE role_value = 5), 80),
((SELECT id FROM da_role WHERE role_value = 5), 81),
((SELECT id FROM da_role WHERE role_value = 5), 82),
((SELECT id FROM da_role WHERE role_value = 5), 40),
((SELECT id FROM da_role WHERE role_value = 5), 42),
((SELECT id FROM da_role WHERE role_value = 5), 44),
((SELECT id FROM da_role WHERE role_value = 5), 84),
((SELECT id FROM da_role WHERE role_value = 5), 46),
((SELECT id FROM da_role WHERE role_value = 5), 48),
((SELECT id FROM da_role WHERE role_value = 5), 50),
((SELECT id FROM da_role WHERE role_value = 5), 86),
((SELECT id FROM da_role WHERE role_value = 5), 52),
((SELECT id FROM da_role WHERE role_value = 5), 54),
((SELECT id FROM da_role WHERE role_value = 5), 56),
((SELECT id FROM da_role WHERE role_value = 5), 88),
((SELECT id FROM da_role WHERE role_value = 5), 58),
((SELECT id FROM da_role WHERE role_value = 5), 60),
((SELECT id FROM da_role WHERE role_value = 5), 62),
((SELECT id FROM da_role WHERE role_value = 5), 70),
((SELECT id FROM da_role WHERE role_value = 5), 72),
((SELECT id FROM da_role WHERE role_value = 5), 74),
((SELECT id FROM da_role WHERE role_value = 5), 92)
















