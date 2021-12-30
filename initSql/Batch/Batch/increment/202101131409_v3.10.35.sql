-- 将rdos_role_user的历史数据租户所有者roleId替换成对应项目的租户所有者roleId

UPDATE rdos_role_user ru
INNER JOIN (
	SELECT
		id,
		project_id
	FROM
		rdos_role
	WHERE
		role_value = 1
	AND is_deleted = 0
	AND project_id != - 1
) t ON ru.project_id = t.project_id
SET ru.role_id = t.id,
 gmt_modified = now()
WHERE
	(
		SELECT
			role_value
		FROM
			rdos_role
		WHERE
			id = ru.role_id
	) = 1
AND t.project_id = ru.project_id
AND ru.is_deleted = 0
AND ru.project_id != - 1;
