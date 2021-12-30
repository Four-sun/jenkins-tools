update rdos_permission set is_deleted = 1,gmt_modified = now() where id in (20,21,22);

update rdos_role_permission set is_deleted = 1,gmt_modified = now()  WHERE permission_id in (20,21,22);