delete from dq_role_permission where role_id = (SELECT id FROM dq_role WHERE role_value = 4) and permission_id IN (
  SELECT id from dq_permission where type = 1 and code in (
    'datasource_edit'
  )
);

UPDATE dq_role SET role_desc = '所有权限' where role_value = 1;
UPDATE dq_role SET role_desc = '可使用全部功能，且可以进行用户管理' where role_value = 2;
UPDATE dq_role SET role_desc = '只有查看权限，不能新建、编辑各类质量校验任务' where role_value = 3;
UPDATE dq_role SET role_desc = '可使用全部功能，不能进行用户管理' where role_value = 4;