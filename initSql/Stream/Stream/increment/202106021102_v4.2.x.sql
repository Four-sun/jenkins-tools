

CREATE TABLE `rdos_data_source_center` (
  `id` INT (11) NOT NULL AUTO_INCREMENT COMMENT '关联的流计算数据源ID',
  `project_id` INT (11) DEFAULT NULL COMMENT '项目ID',
  `tenant_id` INT (11) DEFAULT NULL COMMENT '租户ID',
  `dt_center_source_id` INT (11) DEFAULT NULL COMMENT '数据源中心ID',
  `data_name` VARCHAR (255) DEFAULT NULL COMMENT '数据源中心名称',
  `type` INT (11) DEFAULT NULL COMMENT '数据源类型',
  `create_user_id` INT (11) DEFAULT NULL,
  `modify_user_id` INT (11) DEFAULT NULL,
  `gmt_create` DATETIME DEFAULT NULL,
  `gmt_modified` DATETIME DEFAULT NULL,
  `is_deleted` TINYINT (1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8 COMMENT = '数据源中心映射表';

INSERT INTO rdos_data_source_center (
  `project_id`,
  `tenant_id`,
  `type`,
  `id`,
  `create_user_id`,
  `modify_user_id`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`
) SELECT
  a.project_id,
  a.tenant_id,
  a.type,
  a.id,
  a.create_user_id,
  a.modify_user_id,
  now(),
  now(),
  0
FROM
  rdos_stream_data_source a
WHERE
  a.is_deleted = 0;
INSERT INTO dt_pub_service.`dsc_info` (
  `data_type`,
  `data_version`,
  `data_name`,
  `data_desc`,
  `link_json`,
  `data_json`,
  `data_type_code`,
  `status`,
  `is_meta`,
  `tenant_id`,
  `is_deleted`,
  `dtuic_tenant_id`
) SELECT
  CASE
WHEN type = 1 THEN
  'MySQL'
WHEN type = 1001 THEN
  'MySQL8'
WHEN type = 98 THEN
  'MySQL PXC'
WHEN type = 53 THEN
  'Solr'
WHEN type = 28 THEN
  'PolarDB for MySQL8'
WHEN type = 2 THEN
  'Oracle'
WHEN type = 3 THEN
  'SQLServer'
WHEN type = 32 THEN
  'SQLServer JDBC'
WHEN type = 4 THEN
  'PostgreSQL'
WHEN type = 19 THEN
  'DB2'
WHEN type = 35 THEN
  'DMDB'
WHEN type = 5 THEN
  'RDBMS'
WHEN type = 40 THEN
  'KingbaseES8'
WHEN type = 27 THEN
  'Hive'
WHEN type = 7 THEN
  'Hive'
WHEN type = 45 THEN
  'SparkThrift'
WHEN type = 10 THEN
  'Maxcompute'
WHEN type = 36 THEN
  'Greenplum'
WHEN type = 21 THEN
  'LibrA'
WHEN type = 22 THEN
  'GBase_8a'
WHEN type = 6 THEN
  'HDFS'
WHEN type = 9 THEN
  'FTP'
WHEN type = 29 THEN
  'Impala'
WHEN type = 25 THEN
  'ClickHouse'
WHEN type = 31 THEN
  'TiDB'
WHEN type = 20 THEN
  'CarbonData'
WHEN type = 24 THEN
  'Kudu'
WHEN type = 23 THEN
  'Kylin'
WHEN type = 8 THEN
  'HBase'
WHEN type = 39 THEN
  'HBase'
WHEN type = 30 THEN
  'Phoenix'
WHEN type = 38 THEN
  'Phoenix'
WHEN type = 11 THEN
  'Elasticsearch'
WHEN type = 33 THEN
  'Elasticsearch'
WHEN type = 46 THEN
  'Elasticsearch'
WHEN type = 13 THEN
  'MongoDB'
WHEN type = 12 THEN
  'Redis'
WHEN type = 41 THEN
  'S3'
WHEN type = 26 THEN
  'Kafka'
WHEN type = 37 THEN
  'Kafka'
WHEN type = 18 THEN
  'Kafka'
WHEN type = 17 THEN
  'Kafka'
WHEN type = 14 THEN
  'Kafka'
WHEN type = 34 THEN
  'EMQ'
WHEN type = 42 THEN
  'WebSocket'
WHEN type = 44 THEN
  'Socket'
WHEN type = 15 THEN
  'AnalyticDB'
WHEN type = 48 THEN
  'Presto'
ELSE
  '其他'
END AS data_type,
 CASE
WHEN type = 27 THEN
  '1.x'
WHEN type = 7 THEN
  '2.x'
WHEN type = 8 THEN
  '1.x'
WHEN type = 39 THEN
  '2.x'
WHEN type = 30 THEN
  '4.x'
WHEN type = 38 THEN
  '5.x'
WHEN type = 11 THEN
  '5.x'
WHEN type = 33 THEN
  '6.x'
WHEN type = 46 THEN
  '7.x'
WHEN type = 26 THEN
  '1.x'
WHEN type = 37 THEN
  '2.x'
WHEN type = 18 THEN
  '0.9'
WHEN type = 17 THEN
  '0.10'
WHEN type = 14 THEN
  '0.11'
ELSE
  NULL
END AS data_version,
 CONCAT(
  a.data_name,
  REPLACE (
    '_name_stream',
    'name',
    p.project_name
  )
) AS data_name,
 data_desc,
 CASE
WHEN -- 有key才执行
JSON_CONTAINS_PATH (
  CONVERT (FROM_BASE64(data_json), CHAR),
  "one",
  '$."jdbc.url"',
  '$."jdbc.username"',
  '$."jdbc.password"'
) = 1
AND (
  a.type = 1
  OR a.type = 2
  OR a.type = 4
  OR a.type = 7
  OR a.type = 27
  OR a.type = 19
  OR a.type = 25
  OR a.type = 28
  OR a.type = 29
  OR a.type = 31
  OR a.type = 32
  OR a.type = 40
  OR a.type = 98
) THEN
  REPLACE(REPLACE(TO_BASE64 (
    json_remove (
      JSON_SET (
        CONVERT (FROM_BASE64(data_json), CHAR),
        '$.jdbcUrl',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$."jdbc.url"'
        ),
        '$.username',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$."jdbc.username"'
        )
      ),
      '$."jdbc.url"',
      '$."jdbc.username"',
      '$."jdbc.password"',
    '$.kerberosConfig'
    )
  ), CHAR(10), ''), CHAR(13), '')
ELSE
  data_json
END AS link_json,
 CASE
WHEN -- 有key才执行
JSON_CONTAINS_PATH (
  CONVERT (FROM_BASE64(data_json), CHAR),
  "one",
  '$."jdbc.url"',
  '$."jdbc.username"',
  '$."jdbc.password"'
) = 1
AND (
  a.type = 1
  OR a.type = 2
  OR a.type = 4
  OR a.type = 7
  OR a.type = 19
  OR a.type = 25
  OR a.type = 28
  OR a.type = 29
  OR a.type = 31
  OR a.type = 32
  OR a.type = 40
  OR a.type = 98
) THEN
  REPLACE(REPLACE(TO_BASE64 (
    json_remove (
      JSON_SET (
        CONVERT (FROM_BASE64(data_json), CHAR),
        '$.jdbcUrl',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$."jdbc.url"'
        ),
        '$.username',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$."jdbc.username"'
        ),
        '$.password',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$."jdbc.password"'
        )
      ),
      '$."jdbc.url"',
      '$."jdbc.username"',
      '$."jdbc.password"'
    )
  ), CHAR(10), ''), CHAR(13), '')
WHEN -- 有key才执行
JSON_CONTAINS_PATH (
  CONVERT (FROM_BASE64(data_json), CHAR),
  "one",
  '$.kerberosConfig."kafka.kerberos.principal"',
  '$.kerberosConfig."kafka.kerberos.keytab"'
) = 1
AND (
  a.type = 26
  OR a.type = 37
  OR a.type = 18
  OR a.type = 17
  OR a.type = 14
) THEN
  REPLACE(REPLACE(TO_BASE64 (
    json_remove (
      JSON_SET (
        CONVERT (FROM_BASE64(data_json), CHAR),
        '$.kerberosConfig.principal',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$.kerberosConfig."kafka.kerberos.principal"'
        ),
        '$.kerberosConfig.principalFile',
        JSON_EXTRACT (
          CONVERT (FROM_BASE64(data_json), CHAR),
          '$.kerberosConfig."kafka.kerberos.keytab"'
        )
      ),
      '$.kerberosConfig."kafka.kerberos.principal"',
      '$.kerberosConfig."kafka.kerberos.keytab"'
    )
  ), CHAR(10), ''), CHAR(13), '')
ELSE
  data_json
END AS data_json,
a.type as data_type_code,
 a.link_state AS STATUS,
 0 AS is_meta,
 0 AS tenant_id,
 a.is_deleted AS is_deleted,
 b.dtuic_tenant_id AS dtuic_tenant_id
FROM
  rdos_stream_data_source a
INNER JOIN rdos_tenant b ON a.tenant_id = b.id
INNER JOIN rdos_project p ON a.project_id = p.id
WHERE
  a.is_deleted = 0;

INSERT INTO dt_pub_service.`dsc_auth_ref` (
  `data_info_id`,
  `app_type`,
  `create_user_id`,
  `modify_user_id`
)
SELECT
  info.id,
  '7' AS app_type,
  info.create_user_id,
  info.modify_user_id
FROM
  (
    SELECT
      c.id,
      d.create_user_id,
      d.modify_user_id
    FROM
      rdos_data_source_center d
    INNER JOIN rdos_project p ON d.project_id = p.id
    INNER JOIN rdos_stream_data_source a ON a.id = d.id
    INNER JOIN dt_pub_service.`dsc_info` c ON c.data_name = CONCAT(
      a.data_name,
      REPLACE (
        '_name_stream',
        'name',
        p.project_name
      )
    )
    WHERE
      p.is_deleted = 0
    AND c.is_deleted = 0
and a.is_deleted = 0
  ) info;

INSERT INTO dt_pub_service.`dsc_import_ref` (
  `data_info_id`,
  `old_data_info_id`,
  `app_type`,
  `create_user_id`,
  `modify_user_id`,
  `project_id`,
  `dtuic_tenant_id`
) SELECT
  info.id,
  info.old_data_info_id,
  '7' AS app_type,
  info.create_user_id,
  info.modify_user_id,
  info.project_id,
  info.dtuic_tenant_id
FROM
  (
    SELECT
      c.id,
      a.id AS old_data_info_id,
      d.create_user_id,
      d.modify_user_id,
      d.project_id,
      c.dtuic_tenant_id
    FROM
      rdos_data_source_center d
    INNER JOIN rdos_project p ON d.project_id = p.id
    INNER JOIN rdos_stream_data_source a ON a.id = d.id
    INNER JOIN dt_pub_service.`dsc_info` c ON c.data_name = CONCAT(
      a.data_name,
      REPLACE (
        '_name_stream',
        'name',
        p.project_name
      )
    )
    WHERE
      p.is_deleted = 0
    AND c.is_deleted = 0
  ) info;

UPDATE
rdos_data_source_center d
INNER JOIN rdos_stream_data_source a ON a.id = d.id
INNER JOIN rdos_project p ON d.project_id = p.id
INNER JOIN dt_pub_service.`dsc_info` c ON c.data_name = CONCAT(
  a.data_name,
  REPLACE (
    '_name_stream',
    'name',
    p.project_name
  )
)
SET d.dt_center_source_id = c.id , d.data_name = c.data_name
where
p.is_deleted = 0
AND c.is_deleted = 0 and a.is_deleted = 0;
-- 关闭数据源定时任务
UPDATE `dt_center_cron_schedule`
SET
 `gmt_create` = now(),
 `is_deleted` = '1'
WHERE
 `job_trigger_name`='streamDataSourceJobTrigger' and biz_type ='stream';

-- 更新权限名称
update rdos_permission  set name ='数据源_数据源管理_引入数据源' ,display = '引入数据源',gmt_modified = now() where code ='datasource_manager_edit';
update rdos_permission  set name ='数据源_数据源管理_取消数据源' ,display = '取消数据源',gmt_modified = now() where code ='datasource_manager_delete';
