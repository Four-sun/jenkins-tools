-- 离线修改 编辑 数据源权限为 引入数据源
update ide.rdos_permission set `name`='数据集成_离线_引入数据源',display='引入数据源' where `code`='batchintegration_batch_edit' and `name`='数据集成_离线_编辑' and display='编辑';

-- 1.离线创建数据源中心关联表
drop table IF EXISTS ide.`rdos_batch_data_source_center`;

CREATE TABLE IF not EXISTS ide.`rdos_batch_data_source_center` (
  `id` INT (11) NOT NULL AUTO_INCREMENT COMMENT '离线数据源id',
  `project_id` INT (11) DEFAULT NULL COMMENT '项目ID',
  `tenant_id` INT (11) DEFAULT NULL COMMENT '租户ID',
  `create_user_id` INT (11) DEFAULT NULL,
  `modify_user_id` INT (11) DEFAULT NULL,
  `gmt_create` DATETIME DEFAULT NULL,
  `gmt_modified` DATETIME DEFAULT NULL,
  `is_deleted` TINYINT (1) DEFAULT 0,
	`is_default` TINYINT (1) DEFAULT 0,
  `dt_center_source_id` INT (11) NOT NULL COMMENT '数据源中心ID',
  PRIMARY KEY (`id`)
) ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8 COMMENT = '离线和数据源中心关联表';


-- 2.数据源中心 将离线本地数据源信息迁移到数据源中心
update dt_pub_service.dsc_info a
INNER JOIN dt_pub_service.dsc_import_ref b on b.is_deleted = 0 and b.data_info_id = a.id and b.app_type = 1
set a.is_deleted = 1
where a.is_deleted = 0 and a.data_name like '%_batch';

INSERT INTO dt_pub_service.`dsc_info` (
  `data_type`,
  `data_version`,
  `data_name`,
  `data_desc`,
  `link_json`,
  `data_json`,
	`data_type_code`,
  `status`,
  `tenant_id`,
  `is_deleted`,
  `is_meta`,
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
  'SQLServer_2017_LATER'
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
WHEN type = 50 THEN
  'Hive'
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
WHEN type = 51 THEN
  'AWS S3'
WHEN type = 45 THEN
  'SparkThrift'
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
WHEN type = 52 THEN
  'Inceptor'
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
WHEN type = 54 THEN
  'ADB_PostgreSQL'
WHEN type = 55 THEN
  'InfluxDB'
ELSE
  '其他'
END AS data_type,
 CASE
WHEN type = 27 THEN
  '1.x'
WHEN type = 7 THEN
  '2.x'
WHEN type = 50 THEN
  '3.x'
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
WHEN type = 55 THEN
   '1.x'
ELSE
  NULL
END AS data_version,
REPLACE(CONCAT(
  a.data_name,
	'_',
	p.project_name,
	'_batch'
) ,' ','') AS data_name,
 a.data_desc,

 CASE WHEN -- AWS S3不展示secretKey
	a.type = 51
THEN
	REPLACE(REPLACE(TO_BASE64 (
    json_remove (
      CONVERT (FROM_BASE64(data_json), CHAR),
      '$."secretKey"'
    )
  ), CHAR(10), ''), CHAR(13), '')
WHEN
JSON_CONTAINS_PATH (
  CONVERT (FROM_BASE64(data_json), CHAR),
  "one",
  '$."jdbc.url"',
  '$."jdbc.username"',
  '$."jdbc.password"'
) = 1
THEN
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
      '$."kerberosFile"',
	  '$."kerberosConfig"'
    )
  ), CHAR(10), ''), CHAR(13), '')
	ELSE
	a.data_json
END AS link_json,

 CASE WHEN
JSON_CONTAINS_PATH (
  CONVERT (FROM_BASE64(data_json), CHAR),
  "one",
  '$."jdbc.url"',
  '$."jdbc.username"',
  '$."jdbc.password"'
) = 1
THEN
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
  ), CHAR(10), ''), CHAR(13), '') ELSE a.data_json
	END AS data_json,
 a.type as data_type_code,
 a.link_state,
 a.tenant_id,
 a.is_deleted,
 a.is_default,
 b.dtuic_tenant_id
FROM
  ide.rdos_batch_data_source a
INNER JOIN ide.rdos_tenant b ON a.tenant_id = b.id and b.is_deleted = 0
INNER JOIN ide.rdos_project p ON a.project_id = p.id and p.is_deleted = 0
WHERE a.is_deleted = 0;


-- 3.离线计算 插入离线历史数据源到离线数据源关联表
INSERT INTO ide.rdos_batch_data_source_center (
  `id`,
  `project_id`,
  `tenant_id`,
  `create_user_id`,
  `modify_user_id`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`,
	`is_default`,
	`dt_center_source_id`
) SELECT
	a.id,
  a.project_id,
  a.tenant_id,
  a.create_user_id,
  a.modify_user_id,
  a.gmt_create,
  a.gmt_modified,
  0 AS is_deleted,
	a.is_default,
	c.id AS dt_center_source_id
FROM
  ide.rdos_batch_data_source a
INNER JOIN ide.rdos_tenant b ON a.tenant_id = b.id AND b.is_deleted = 0
INNER JOIN ide.rdos_project p ON a.project_id = p.id AND p.is_deleted = 0
INNER JOIN dt_pub_service.`dsc_info` c ON c.data_name = CONCAT(
  a.data_name,
	'_',
	p.project_name,
	'_batch'
) and b.dtuic_tenant_id=c.dtuic_tenant_id and c.is_deleted = 0
WHERE	a.is_deleted = 0;


-- 4.数据源中心 插入子产品引入表
update dt_pub_service.dsc_import_ref a
inner JOIN dt_pub_service.dsc_info b on b.is_deleted = 1 and a.data_info_id = b.id and b.data_name like '%_batch'
set a.is_deleted = 1
where a.is_deleted = 0 and a.app_type = 1;

INSERT INTO dt_pub_service.`dsc_import_ref` (
  `data_info_id`,
  `old_data_info_id`,
	`dtuic_tenant_id`,
	`project_id`,
  `app_type`,
	`is_deleted`,
  `create_user_id`,
  `modify_user_id`
) SELECT
      d.dt_center_source_id AS data_info_id,
      d.id AS old_data_info_id,
			t.dtuic_tenant_id,
			d.project_id,
			'1' AS app_type,
			0 AS is_deleted,
      d.create_user_id,
      d.modify_user_id
    FROM
      ide.rdos_batch_data_source_center d
		INNER JOIN ide.rdos_tenant t ON d.tenant_id = t.id AND t.is_deleted = 0
    WHERE
      d.is_deleted = 0;


-- 5.数据源中心 插入子产品授权表
update dt_pub_service.dsc_auth_ref a
inner JOIN dt_pub_service.dsc_info b on b.is_deleted = 1 and a.data_info_id = b.id and b.data_name like '%_batch'
set a.is_deleted = 1
where a.is_deleted = 0 and a.app_type = 1;

INSERT INTO dt_pub_service.`dsc_auth_ref` (
  `data_info_id`,
  `app_type`,
  `create_user_id`,
  `modify_user_id`
) SELECT DISTINCT
	data_info_id,
	app_type,
	create_user_id,
	modify_user_id
from dt_pub_service.dsc_import_ref
where app_type='1' AND is_deleted=0;