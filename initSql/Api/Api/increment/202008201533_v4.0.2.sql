INSERT INTO da_role (tenant_id, role_name, role_value, role_desc, modify_user_id, is_deleted, project_id) VALUES (-1, '租户管理员', 8, '本项目内的全部权限，具有本租户内的全部权限，但不能对租户所有者操作', 0, 0, -1);

INSERT INTO da_role_permission (role_id, permission_id) VALUES
((SELECT id FROM da_role WHERE role_value = 8), 1),
((SELECT id FROM da_role WHERE role_value = 8), 2),
((SELECT id FROM da_role WHERE role_value = 8), 4),
((SELECT id FROM da_role WHERE role_value = 8), 6),
((SELECT id FROM da_role WHERE role_value = 8), 8),
((SELECT id FROM da_role WHERE role_value = 8), 20),
((SELECT id FROM da_role WHERE role_value = 8), 22),
((SELECT id FROM da_role WHERE role_value = 8), 24),
((SELECT id FROM da_role WHERE role_value = 8), 26),
((SELECT id FROM da_role WHERE role_value = 8), 28),
((SELECT id FROM da_role WHERE role_value = 8), 30),
((SELECT id FROM da_role WHERE role_value = 8), 32),
((SELECT id FROM da_role WHERE role_value = 8), 40),
((SELECT id FROM da_role WHERE role_value = 8), 42),
((SELECT id FROM da_role WHERE role_value = 8), 44),
((SELECT id FROM da_role WHERE role_value = 8), 46),
((SELECT id FROM da_role WHERE role_value = 8), 48),
((SELECT id FROM da_role WHERE role_value = 8), 50),
((SELECT id FROM da_role WHERE role_value = 8), 52),
((SELECT id FROM da_role WHERE role_value = 8), 54),
((SELECT id FROM da_role WHERE role_value = 8), 56),
((SELECT id FROM da_role WHERE role_value = 8), 58),
((SELECT id FROM da_role WHERE role_value = 8), 60),
((SELECT id FROM da_role WHERE role_value = 8), 62),
((SELECT id FROM da_role WHERE role_value = 8), 64),
((SELECT id FROM da_role WHERE role_value = 8), 66),
((SELECT id FROM da_role WHERE role_value = 8), 68),
((SELECT id FROM da_role WHERE role_value = 8), 70),
((SELECT id FROM da_role WHERE role_value = 8), 72),
((SELECT id FROM da_role WHERE role_value = 8), 74),
((SELECT id FROM da_role WHERE role_value = 8), 76),
((SELECT id FROM da_role WHERE role_value = 8), 77),
((SELECT id FROM da_role WHERE role_value = 8), 78),
((SELECT id FROM da_role WHERE role_value = 8), 80),
((SELECT id FROM da_role WHERE role_value = 8), 81),
((SELECT id FROM da_role WHERE role_value = 8), 82),
((SELECT id FROM da_role WHERE role_value = 8), 84),
((SELECT id FROM da_role WHERE role_value = 8), 86),
((SELECT id FROM da_role WHERE role_value = 8), 88),
((SELECT id FROM da_role WHERE role_value = 8), 90),
((SELECT id FROM da_role WHERE role_value = 8), 92),
((SELECT id FROM da_role WHERE role_value = 8), 93),
((SELECT id FROM da_role WHERE role_value = 8), 94),
((SELECT id FROM da_role WHERE role_value = 8), 95),
((SELECT id FROM da_role WHERE role_value = 8), 96),
((SELECT id FROM da_role WHERE role_value = 8), 97);

ALTER TABLE da_tenant DROP INDEX `idx_tenant_name`;
CREATE INDEX `idx_tenant_name` ON da_tenant(`tenant_name`(128));

INSERT INTO `da_dict` VALUES ('14', '1', 'HBase1.x', '8', 'HBase1.x', 'HBase1.x', '14', now(), now(), '0');
INSERT INTO `da_dict` VALUES ('15', '1', 'HBase2.x', '39', 'HBase2.x', 'HBase2.x', '15', now(), now(), '0');

ALTER TABLE da_data_source MODIFY COLUMN data_json text DEFAULT NULL COMMENT '链接数据源信息需要加密 json格式';

INSERT INTO da_role(project_id, tenant_id, role_name, role_value, role_desc, modify_user_id)
 SELECT id, tenant_id, '租户管理员', 8, '本项目内的全部权限，具有本租户内的全部权限，但不能对租户所有者操作',0 FROM da_project
 WHERE (SELECT count(*) FROM da_role WHERE project_id = da_project.id AND role_value = 8) = 0;