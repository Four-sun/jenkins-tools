UPDATE dt_easy_index.ei_project_management SET data_source_addr = REPLACE(data_source_addr, 'jdbc:presto', 'jdbc:trino') WHERE is_deleted = 0;

UPDATE dt_easy_index.ei_index_dispatch_info d
SET d.task_detail = REPLACE (
        d.task_detail,
        'uuid()',
        'cast(uuid() as varchar)');

UPDATE dt_pub_service.dsc_info dd,
    (
    SELECT
    id,
    FROM_BASE64 ( data_json ) AS data_json,
    FROM_BASE64 ( link_json ) AS link_json,
    data_type
    FROM
    dt_pub_service.dsc_info di
    WHERE
    data_type = 'Presto'
    AND di.id IN ( SELECT DISTINCT data_info_id FROM dt_easy_index.ei_project_management WHERE is_deleted = 0 )) b
SET dd.data_type = 'Trino',
    dd.data_type_code = 59,
    dd.data_json = REPLACE(REPLACE(TO_BASE64 (REPLACE ( b.data_json, 'jdbc:presto', 'jdbc:trino' )), CHAR(10), ''), CHAR(13),''),
    dd.link_json = REPLACE(REPLACE(TO_BASE64 (REPLACE ( b.link_json, 'jdbc:presto', 'jdbc:trino' )), CHAR(10), ''), CHAR(13),'')
WHERE
    dd.data_type = 'Presto'
  AND dd.is_deleted = 0
  AND dd.id = b.id;

UPDATE dt_pub_service.dsc_info dd,
    (
    SELECT
    id,
    FROM_BASE64 ( data_json ) AS data_json,
    FROM_BASE64 ( link_json ) AS link_json,
    data_type
    FROM
    dt_pub_service.dsc_info di
    WHERE
    data_type = 'Presto'
    AND di.id IN ( SELECT DISTINCT data_source_id FROM dt_easy_index.rdos_tenant WHERE is_deleted = 0 )) b
SET dd.data_type = 'Trino',
    dd.data_type_code = 59,
    dd.data_json = REPLACE(REPLACE(TO_BASE64 (REPLACE ( b.data_json, 'jdbc:presto', 'jdbc:trino' )),CHAR(10), ''), CHAR(13),''),
    dd.link_json = REPLACE(REPLACE(TO_BASE64 (REPLACE ( b.link_json, 'jdbc:presto', 'jdbc:trino' )), CHAR(10), ''), CHAR(13),'')
WHERE
    dd.data_type = 'Presto'
  AND dd.is_deleted = 0
  AND dd.id = b.id;

