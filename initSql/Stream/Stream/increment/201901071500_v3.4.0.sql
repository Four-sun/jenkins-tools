UPDATE rdos_role_permission SET is_deleted=1 where role_id in (select id from rdos_role WHERE role_value = 5) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'batchintegration_edit'
  )
);