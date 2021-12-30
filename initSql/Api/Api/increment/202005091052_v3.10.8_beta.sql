-- 新增TiDB数据源
INSERT INTO `da_dict` VALUES ('10', '1', 'TiDB', '31', 'TiDB', 'TiDB', '10', now(), now(), '0');

-- 新增MongoDB数据源
INSERT INTO `da_dict` VALUES ('11', '1', 'MongoDB', '13', 'MongoDB', 'MongoDB', '11', now(), now(), '0');

INSERT INTO da_role_permission (role_id, permission_id)
SELECT id, 66 FROM da_role WHERE role_value=5 AND is_deleted=0;

