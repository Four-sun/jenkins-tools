-- 1.新增数据源关联表 所有旧数据迁移到此后续不再使用 assets_data_source
CREATE TABLE `assets_data_source_center`
(
  `id`                    BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`             BIGINT(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`             BIGINT(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`             DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`             DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`            TINYINT(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `tenant_id`             BIGINT(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  `dt_center_source_id`   BIGINT(20)          NULL     DEFAULT NULL COMMENT '数据源中心id',
  `dt_center_source_name` varchar(128)        NULL     DEFAULT NULL COMMENT '数据源中心名称',
  `dtuic_tenant_id`       int(11)                      DEFAULT NULL COMMENT 'UIC租户id',
  `data_source_name`      VARCHAR(128)        NULL     DEFAULT NULL COMMENT '数据源名称',
  `data_source_desc`      VARCHAR(255)        NULL     DEFAULT NULL COMMENT '数据源描述',
  `data_source_type`      INT(11)             NOT NULL COMMENT '数据源类型code,小于1000为系统数据源，小于1000为自定义数据源',
  `link_status`           TINYINT(1)          NOT NULL DEFAULT '0' COMMENT '0-连接失败,1-连接成功,2-同步中,3-初始化,-1-未知(自定义数据源专用)',
  `sync_status`           TINYINT(1)          NOT NULL DEFAULT '1' COMMENT '1-同步结束，2-同步中',
  `sync_date`             DATETIME            NULL     DEFAULT NULL COMMENT '最近同步时间',
  PRIMARY KEY (`id`)
) COMMENT = '数据源中心关联表' ENGINE = InnoDB
                       DEFAULT CHARSET = utf8;


-- 2.迁移（数据源迁移到新表）assets_data_source -> assets_data_source_center
INSERT INTO assets_data_source_center (id,
                                       create_by,
                                       update_by,
                                       create_at,
                                       is_deleted,
                                       tenant_id,
                                       data_source_name,
                                       data_source_desc,
                                       data_source_type,
                                       link_status,
                                       sync_status,
                                       sync_date,
                                       dt_center_source_id,
                                       dt_center_source_name,
                                       dtuic_tenant_id)
SELECT a.id,
       a.create_by,
       a.update_by,
       a.create_at,
       a.is_deleted,
       a.tenant_id,
       CONCAT(a.data_source_name, '_assets'),
       a.data_source_desc,
       a.data_source_type,
       a.link_status,
       a.sync_status,
       a.sync_date,
       null,
       null,
       b.dtuic_tenant_id
FROM assets_data_source as a
       INNER JOIN assets_tenant b ON a.tenant_id = b.id
WHERE a.is_deleted = 0;


-- 3.迁移（数据源迁移到中心）assets.assets_data_source -> dt_pub_service.dsc_info
INSERT INTO `dt_pub_service`.`dsc_info`(`data_type`,
                                        `data_version`,
                                        `data_type_code`,
                                        `data_name`,
                                        `data_desc`,
                                        `link_json`,
                                        `data_json`,
                                        `status`,
                                        `is_meta`,
                                        `tenant_id`,
                                        `is_deleted`,
                                        `create_user_id`,
                                        `modify_user_id`,
                                        `dtuic_tenant_id`)


SELECT CASE
         WHEN data_source_type = 1 THEN
           'MySQL'
         WHEN data_source_type = 2 THEN
           'Oracle'
         WHEN data_source_type = 3 THEN
           'SQLServer'
         WHEN data_source_type = 31 THEN
           'TiDB'
         WHEN data_source_type = 43 THEN
           'Vertica'
         WHEN data_source_type = 27 THEN
           'Hive'
         WHEN data_source_type = 7 THEN
           'Hive'
         WHEN data_source_type = 8 THEN
           'HBase'
         WHEN data_source_type = 38 THEN
           'Phoenix'
         WHEN data_source_type = 37 THEN
           'Kafka'
         WHEN data_source_type = 17 THEN
           'Kafka'
         ELSE
           '其他'
         END                                 AS data_type,
       CASE
         WHEN data_source_type = 27 THEN
           '1.x'
         WHEN data_source_type = 7 THEN
           '2.x'
         WHEN data_source_type = 8 THEN
           '1.x'
         WHEN data_source_type = 38 THEN
           '5.x'
         WHEN data_source_type = 37 THEN
           '2.x'
         WHEN data_source_type = 17 THEN
           '0.10'
         ELSE
           NULL
         END                                 AS data_version,
       a.data_source_type,
       CONCAT(a.data_source_name, '_assets') AS data_name,
       data_source_desc,
       CASE
         WHEN (a.data_source_type = 1
           OR a.data_source_type = 2
           OR a.data_source_type = 3
           OR a.data_source_type = 31
           OR a.data_source_type = 43) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(data_source_json, '$.jdbcUrl'), '$.username',
                                        JSON_EXTRACT(data_source_json, '$.userName'))), CHAR(10), ''), CHAR(13), '')
         WHEN (data_source_type = 27
           OR data_source_type = 7) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(data_source_json, '$.jdbcUrl'), '$.defaultFS',
                                        JSON_EXTRACT(data_source_json, '$.defaultFS'))), CHAR(10), ''), CHAR(13), '')
         WHEN data_source_type = 38 THEN
           REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.jdbcUrl', REPLACE(
               CONCAT(JSON_EXTRACT(data_source_json, '$.jdbcUrl'), JSON_EXTRACT(data_source_json, '$.path')), '""/',
               '/'))), CHAR(10), ''), CHAR(13), '')
         WHEN data_source_type = 8 THEN
           REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.hbase_quorum', JSON_EXTRACT(data_source_json, '$.clusterUrl'))),
                           CHAR(10), ''), CHAR(13), '')
         WHEN (data_source_type = 37
           OR data_source_type = 17) THEN
           REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.address', JSON_EXTRACT(data_source_json, '$.clusterUrl'),
                                              '$.brokerList', JSON_EXTRACT(data_source_json, '$.brokerList'))),
                           CHAR(10), ''), CHAR(13), '')
         ELSE
           ''
         END                                 AS link_json,
       CASE
         WHEN (a.data_source_type = 1
           OR a.data_source_type = 2
           OR a.data_source_type = 3
           OR a.data_source_type = 31
           OR a.data_source_type = 43) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(data_source_json, '$.jdbcUrl'), '$.username',
                                        JSON_EXTRACT(data_source_json, '$.userName'), '$.password',
                                        JSON_EXTRACT(data_source_json, '$.password'))), CHAR(10), ''), CHAR(13), '')
         WHEN (data_source_type = 27
           OR data_source_type = 7) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(data_source_json, '$.jdbcUrl'), '$.username',
                                        JSON_EXTRACT(data_source_json, '$.userName'), '$.password',
                                        JSON_EXTRACT(data_source_json, '$.password'), '$.defaultFS',
                                        JSON_EXTRACT(data_source_json, '$.defaultFS'), '$.hadoopConfig',
                                        JSON_EXTRACT(data_source_json, '$.hadoopConfig'), '$.openKerberos',
                                        JSON_EXTRACT(data_source_json, '$.openKerberos'), '$.kerberosConfig',
                                        JSON_EXTRACT(data_source_json, '$.kerberosConfig'), '$.kerberosFile',
                                        JSON_EXTRACT(data_source_json, '$.kerberosFile'), '$.kerberosConfig.principal',
                                        JSON_EXTRACT(data_source_json, '$.kerberosConfig.principal'),
                                        '$.kerberosConfig."java.security.krb5.conf"',
                                        JSON_EXTRACT(data_source_json, '$.kerberosConfig."java.security.krb5.conf"'))),
                           CHAR(10), ''), CHAR(13), '')
         WHEN data_source_type = 38 THEN
           REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.jdbcUrl', REPLACE(
               CONCAT(JSON_EXTRACT(data_source_json, '$.jdbcUrl'), JSON_EXTRACT(data_source_json, '$.path')), '""/',
               '/'), '$.openKerberos', JSON_EXTRACT(data_source_json, '$.openKerberos'), '$.kerberosConfig',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig'), '$.kerberosFile',
                                              JSON_EXTRACT(data_source_json, '$.kerberosFile'),
                                              '$.kerberosConfig.principal',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig.principal'),
                                              '$.kerberosConfig.principalFile',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig.principalFile'),
                                              '$.kerberosConfig."java.security.krb5.conf"',
                                              JSON_EXTRACT(data_source_json,
                                                           '$.kerberosConfig."java.security.krb5.conf"'))), CHAR(10),
                           ''), CHAR(13), '')
         WHEN data_source_type = 8 THEN
           REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.hbase_quorum', JSON_EXTRACT(data_source_json, '$.clusterUrl'),
                                              '$.hbase_parent', JSON_EXTRACT(data_source_json, '$.path'),
                                              '$.hbase_other', JSON_EXTRACT(data_source_json, '$.other'),
                                              '$.openKerberos', JSON_EXTRACT(data_source_json, '$.openKerberos'),
                                              '$.kerberosConfig', JSON_EXTRACT(data_source_json, '$.kerberosConfig'),
                                              '$.kerberosFile', JSON_EXTRACT(data_source_json, '$.kerberosFile'),
                                              '$.kerberosConfig.principal',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig.principal'),
                                              '$.kerberosConfig.principalFile',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig.principalFile'),
                                              '$.kerberosConfig."java.security.krb5.conf"',
                                              JSON_EXTRACT(data_source_json,
                                                           '$.kerberosConfig."java.security.krb5.conf"'))), CHAR(10),
                           ''), CHAR(13), '')
         WHEN (data_source_type = 37
           OR data_source_type = 17) THEN
           REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.address', JSON_EXTRACT(data_source_json, '$.clusterUrl'),
                                              '$.brokerList', JSON_EXTRACT(data_source_json, '$.brokerList'),
                                              '$.openKerberos', JSON_EXTRACT(data_source_json, '$.openKerberos'),
                                              '$.kerberosConfig', JSON_EXTRACT(data_source_json, '$.kerberosConfig'),
                                              '$.kerberosFile', JSON_EXTRACT(data_source_json, '$.kerberosFile'),
                                              '$.kerberosConfig.principal',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig.principal'),
                                              '$.kerberosConfig.principalFile',
                                              JSON_EXTRACT(data_source_json, '$.kerberosConfig.principalFile'),
                                              '$.kerberosConfig."java.security.krb5.conf"',
                                              JSON_EXTRACT(data_source_json,
                                                           '$.kerberosConfig."java.security.krb5.conf"'))), CHAR(10),
                           ''), CHAR(13), '')
         ELSE
           ''
         END                                 AS data_json,
       a.link_status                         AS status,
       0                                     AS is_meta,
       a.tenant_id                           AS tenant_id,
       a.is_deleted                          AS is_deleted,
       a.create_by                           AS create_user_id,
       a.update_by                           AS modify_user_id,
       b.dtuic_tenant_id                     AS dtuic_tenant_id
FROM assets_data_source a
       INNER JOIN assets_tenant b ON a.tenant_id = b.id
WHERE a.is_deleted = 0
  AND a.data_source_type < 1000
  AND a.data_source_type != 201;


-- 4.授权数据库

INSERT INTO dt_pub_service.dsc_auth_ref(data_info_id,
                                        app_type,
                                        create_user_id,
                                        modify_user_id)
SELECT info.dt_center_source_id,
       '9' AS app_type,
       info.create_user_id,
       info.modify_user_id
FROM (
       SELECT c.id        as dt_center_source_id,
              a.create_by as create_user_id,
              a.update_by as modify_user_id
       FROM assets_data_source_center a
              INNER JOIN assets_tenant b ON b.id = a.tenant_id
              INNER JOIN dt_pub_service.dsc_info c ON c.data_name = a.data_source_name and
                                                      c.dtuic_tenant_id = b.dtuic_tenant_id
       WHERE c.is_deleted = 0
         AND a.is_deleted = 0
         AND a.data_source_type < 1000
         AND a.data_source_type != 201
     ) info;


-- 5.引用数据库
INSERT INTO dt_pub_service.dsc_import_ref(data_info_id,
                                          old_data_info_id,
                                          project_id,
                                          app_type,
                                          dtuic_tenant_id,
                                          create_user_id,
                                          modify_user_id)
select info.dt_center_source_id,
       info.assets_source_id,
       -1  as project_id,
       '9' as app_type,
       info.dtuic_tenant_id,
       info.create_user_id,
       info.modify_user_id
from (
       SELECT c.id              as dt_center_source_id,
              a.id              as assets_source_id,
              b.dtuic_tenant_id as dtuic_tenant_id,
              a.create_by       as create_user_id,
              a.update_by       as modify_user_id
       FROM assets_data_source_center a
              INNER JOIN assets_tenant b ON b.id = a.tenant_id
              INNER JOIN dt_pub_service.dsc_info c on c.data_name = a.data_source_name and
                                                      c.dtuic_tenant_id = b.dtuic_tenant_id
       WHERE c.is_deleted = 0
         AND a.is_deleted = 0
         AND a.data_source_type < 1000
         AND a.data_source_type != 201
     ) info;

-- 6.关联中心源id
UPDATE assets_data_source_center a
  INNER JOIN assets_tenant b ON b.id = a.tenant_id
  INNER JOIN dt_pub_service.dsc_info c ON c.data_name = a.data_source_name and c.dtuic_tenant_id = b.dtuic_tenant_id
SET a.dt_center_source_id = c.id
WHERE c.is_deleted = 0
  AND a.data_source_type < 1000
  AND a.data_source_type != 201;



-- 删除连通性校验定时任务

delete from qrtz_simprop_triggers where TRIGGER_NAME= 'dataSourceConnectionTrigger';
delete from qrtz_cron_triggers where TRIGGER_NAME= 'dataSourceConnectionTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'dataSourceConnectionTrigger';
delete from qrtz_simple_triggers where TRIGGER_NAME= 'dataSourceConnectionTrigger';
delete from qrtz_job_details where JOB_NAME= 'dataSourceConnectionJob';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'dataSourceConnectionTrigger';
delete from qrtz_blob_triggers where TRIGGER_NAME= 'dataSourceConnectionTrigger';

delete from dt_center_cron_schedule where job_trigger_name = 'dataSourceConnectionTrigger';



