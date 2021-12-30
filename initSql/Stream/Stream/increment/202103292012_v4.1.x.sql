-- 清除多余的默认角色
UPDATE
rdos_role
SET is_deleted = 1
WHERE tenant_id = -1
  AND project_id = -1
  AND is_deleted = 0
  AND id NOT IN (
    SELECT dt.minid
    FROM (
             SELECT MIN(id) AS minid
             FROM rdos_role
             WHERE tenant_id = -1
               AND project_id = -1
               AND is_deleted = 0
             GROUP BY role_value
         ) dt);