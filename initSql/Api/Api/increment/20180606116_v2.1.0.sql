UPDATE da_role SET role_desc = '本产品内的全部权限，具有本租户内的最高权限' WHERE role_value = 1;
UPDATE da_role SET role_desc = '本产品内的全部权限，可为其他用户分配角色' WHERE role_value = 2;
UPDATE da_role SET role_desc = '只具备查看权限，没有权限进行编辑等操作' WHERE role_value = 3;
update da_role set role_desc = '只有申请并使用标签的权限，不可进行新建标签、编辑标签、审批授权等操作' where role_value = 4;

-- 应用开发增加查看权限
INSERT into da_role_permission(role_id, permission_id) VALUES ((SELECT id FROM da_role WHERE role_value = 4), (SELECT id from da_permission WHERE code = 'system_role_query'));
INSERT into da_role_permission(role_id, permission_id) VALUES ((SELECT id FROM da_role WHERE role_value = 4), (SELECT id from da_permission WHERE code = 'system_member_query'));