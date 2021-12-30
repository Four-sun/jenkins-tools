update rdos_role_permission set is_deleted = 1
where role_id in (select id from rdos_role where role_name = '运维')
  and permission_id = (SELECT id from rdos_permission where code = 'datadevelop_batch_scriptmanager_edit')