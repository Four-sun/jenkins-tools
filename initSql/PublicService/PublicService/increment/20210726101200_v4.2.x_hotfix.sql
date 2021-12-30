-- 删除授权表重复数据
DELETE
FROM
    dsc_auth_ref
WHERE
        id IN (
        SELECT
            id
        FROM
            ( SELECT id, data_info_id, app_type, count(*) num
              FROM dsc_auth_ref WHERE is_deleted = 0 GROUP BY data_info_id, app_type HAVING num > 1 )
                a
    );