-- 新增数据源关联表 所有旧数据迁移到此后续不再使用 dq_data_source
CREATE TABLE `dq_data_source_center` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
 `project_id` int(11) NOT NULL DEFAULT '1' COMMENT '项目ID',
 `data_name` varchar(128) DEFAULT NULL COMMENT '本地数据源名称',
 `data_desc` text DEFAULT NULL COMMENT '数据源描述',
 `dt_data_source_id` int(11) NOT NULL DEFAULT '0' COMMENT '统一数据源id',
 `dt_data_source_name` varchar(255) DEFAULT NULL COMMENT '统一数据源名称',
 `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据源类型 ',
 `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
 `link_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
 `dtuic_tenant_id` int(11) DEFAULT NULL COMMENT 'uic租户id',
 `write_db_source_id` int(11) DEFAULT NULL COMMENT '独立库绑定统一数据源id',
 `expire_day` int(11) DEFAULT '90' COMMENT '数据存储时间，不传默认90天',
 `write_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-写入源库；1-写入独立库，默认写入源库',
 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
 `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
 `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COMMENT='数据源中心关联表';

-- 同步dq_data_source记录到dq_data_source_center
INSERT INTO dq_data_source_center  (id,
                                    tenant_id,
                                    project_id,
                                    data_name,
                                    data_desc,
                                    type,
                                    active,
                                    link_state,
                                    dtuic_tenant_id,
                                    expire_day,
                                    write_type,
                                    create_user_id,
                                    modify_user_id)
select a.id,a.tenant_id,a.project_id,a.data_name,a.data_desc,a.type,a.active,a.link_state,b.dtuic_tenant_id,
       a.expire_day,a.write_type,a.create_user_id,a.modify_user_id
from dq_data_source a inner join dq_tenant b on a.tenant_id = b.id
where a.is_deleted = 0
group by a.data_name,a.project_id;

-- 将独立库的信息转为dq_data_source_center表记录
INSERT INTO dq_data_source_center  (tenant_id,
                                    project_id,
                                    data_name,
                                    data_desc,
                                    type,
                                    active,
                                    link_state,
                                    dtuic_tenant_id,
                                    expire_day,
                                    write_type,
                                    create_user_id,
                                    modify_user_id)
select a.tenant_id,a.project_id,a.writable_db_name,CONCAT(a.writable_db_name,'_write_db'),a.type,a.active,a.link_state,b.dtuic_tenant_id,
       a.expire_day,0 AS write_type,a.create_user_id,a.modify_user_id
from dq_data_source a inner join dq_tenant b on a.tenant_id = b.id
where a.is_deleted = 0 and a.write_type = 1
group by a.writable_db_name,a.project_id;


-- dq_data_source记录同步到数据源中心
INSERT INTO `dt_pub_service`.`dsc_info`   (`data_type`,
                                           `data_version`,
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
                                           `dtuic_tenant_id`,
                                           `data_type_code`)
SELECT
    CASE WHEN a.type = 1 THEN
             'MySQL'
         WHEN a.type = 2 THEN
             'Oracle'
         WHEN a.type = 3 THEN
             'SQLServer'
         WHEN a.type = 4 THEN
             'PostgreSQL'
         WHEN a.type = 5 THEN
             'RDBMS'
         WHEN a.type = 6 THEN
             'HDFS'
         WHEN a.type = 7 THEN
             'Hive'
         WHEN a.type = 8 THEN
             'HBase'
         WHEN a.type = 10 THEN
             'Maxcompute'
         WHEN a.type = 31 THEN
             'TiDB'
         WHEN a.type = 36 THEN
             'Greenplum'
         WHEN a.type = 40 THEN
             'KingbaseES8'
         WHEN a.type = 45 THEN
             'SparkThrift'
         WHEN a.type = 37 THEN
             'Kafka'
         WHEN a.type = 17 THEN
             'Kafka'
         ELSE
             '其他'
        END AS data_type,
    CASE WHEN a.type = 27 THEN
             '1.x'
         WHEN a.type = 7 THEN
             '2.x'
         WHEN a.type = 8 THEN
             '1.x'
         WHEN a.type = 37 THEN
             '2.x'
         WHEN a.type = 17 THEN
             '0.10'
         ELSE
             NULL
        END AS data_version,
    CONCAT(a.data_name,'_',c.project_name,'_dq') AS data_name,
    a.data_desc,
    CASE WHEN (a.type = 1
        OR a.type = 2
        OR a.type = 3
        OR a.type = 4
        OR a.type = 5
        OR a.type = 31
        OR a.type = 36
        OR a.type = 40
        OR a.type = 45) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.jdbcUrl'), '$.username', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.username'))), CHAR(10), ''), CHAR(13), '')
         WHEN (a.type = 27
             OR type = 7) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.jdbcUrl'), '$.defaultFS', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.defaultFS'))), CHAR(10), ''), CHAR(13), '')
         WHEN a.type = 10 THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.accessId', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.accessId'), '$.endPoint', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.endPoint'),'$.project', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.project'),'$.dbName', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.dbName'),'$.accessKey', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.accessKey'))), CHAR(10), ''), CHAR(13), '')
         WHEN (a.type = 37
             OR a.type = 17) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.address', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.address'), '$.brokerList', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.brokerList'))), CHAR(10), ''), CHAR(13), '')
         ELSE
             ''
        END AS link_json,
    CASE WHEN (a.type = 17
        OR a.type = 37) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.address', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.address'),
                                                '$.brokerList', JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.brokerList'),
                                                '$.principal',JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.kerberosConfig.principal'),
                                                '$.openKerberos',JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.openKerberos'),
                                                '$.kerberosFile',JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.kerberosFile'),
                                                '$.kerberosConfig',JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.kerberosConfig'),
                                                '$.brokerList',JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.brokerList'),
                                                '$.kerberosConfig',JSON_EXTRACT(convert(from_base64(data_json) using utf8), '$.kerberosConfig'))), CHAR(10), ''), CHAR(13), '')
         ELSE
             a.data_json
        END AS data_json,
    a.link_state AS `status`,
    CASE WHEN a.type = 45 THEN 1 ELSE 0 END AS is_meta,
    a.tenant_id,
    a.is_deleted AS is_deleted,
    a.create_user_id,
    a.modify_user_id,
    b.dtuic_tenant_id,
    a.type AS data_type_code
from dq_data_source a
inner join dq_project c on a.project_id = c.id
inner join dq_tenant b on a.tenant_id = b.id
where a.is_deleted = 0
group by a.data_name,a.project_id;


-- 独立库同步到数据源中心
INSERT INTO `dt_pub_service`.`dsc_info`(`data_type`,`data_version`,`data_name`,`data_desc`,
                       `link_json`,`data_json`,`status`,`is_meta`,`tenant_id`,`is_deleted`,`create_user_id`,
                       `modify_user_id`,`dtuic_tenant_id`,`data_type_code`)
SELECT
    CASE WHEN a.type = 1 THEN
             'MySQL'
         WHEN a.type = 2 THEN
             'Oracle'
         WHEN a.type = 3 THEN
             'SQLServer'
         WHEN a.type = 4 THEN
             'PostgreSQL'
         WHEN a.type = 5 THEN
             'RDBMS'
         WHEN a.type = 6 THEN
             'HDFS'
         WHEN a.type = 7 THEN
             'Hive'
         WHEN a.type = 8 THEN
             'HBase'
         WHEN a.type = 10 THEN
             'Maxcompute'
         WHEN a.type = 31 THEN
             'TiDB'
         WHEN a.type = 36 THEN
             'Greenplum'
         WHEN a.type = 40 THEN
             'KingbaseES8'
         WHEN a.type = 45 THEN
             'SparkThrift'
         WHEN a.type = 37 THEN
             'Kafka'
         WHEN a.type = 17 THEN
             'Kafka'
         ELSE
             '其他'
        END AS data_type,
    CASE WHEN a.type = 27 THEN
             '1.x'
         WHEN a.type = 7 THEN
             '2.x'
         WHEN a.type = 8 THEN
             '1.x'
         WHEN a.type = 37 THEN
             '2.x'
         WHEN a.type = 17 THEN
             '0.10'
         ELSE
             NULL
        END AS data_version,
    CONCAT(a.writable_db_name,'_',c.project_name,'_dq') AS data_name,
    CONCAT(a.writable_db_name,'_write_db') AS data_desc,
    CASE WHEN (a.type = 1
        OR a.type = 2
        OR a.type = 3
        OR a.type = 4
        OR a.type = 5
        OR a.type = 31
        OR a.type = 36
        OR a.type = 40
        OR a.type = 45) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.jdbcUrl'), '$.username', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.username'))), CHAR(10), ''), CHAR(13), '')
         WHEN (a.type = 27
             OR type = 7) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.jdbcUrl'), '$.defaultFS', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.defaultFS'))), CHAR(10), ''), CHAR(13), '')
         WHEN a.type = 10 THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.accessId', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.accessId'), '$.endPoint', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.endPoint'),'$.project', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.project'),'$.dbName', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.dbName'),'$.accessKey', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.accessKey'))), CHAR(10), ''), CHAR(13), '')
         WHEN (a.type = 37
             OR a.type = 17) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.address', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.address'), '$.brokerList', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.brokerList'))), CHAR(10), ''), CHAR(13), '')
         ELSE
             ''
        END AS link_json,
    CASE WHEN (a.type = 17
        OR a.type = 37) THEN
             REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.address', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.address'),
                                                '$.brokerList', JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.brokerList'),
                                                '$.principal',JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.kerberosConfig.principal'),
                                                '$.openKerberos',JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.openKerberos'),
                                                '$.kerberosFile',JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.kerberosFile'),
                                                '$.kerberosConfig',JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.kerberosConfig'),
                                                '$.brokerList',JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.brokerList'),
                                                '$.kerberosConfig',JSON_EXTRACT(convert(from_base64(writable_data_json) using utf8), '$.kerberosConfig'))), CHAR(10), ''), CHAR(13), '')
         ELSE
             a.writable_data_json
        END AS data_json,
    a.link_state AS `status`,
    CASE WHEN a.type = 45 THEN 1 ELSE 0 END AS is_meta,
    a.tenant_id,
    0 AS is_deleted,
    a.create_user_id,
    a.modify_user_id,
    b.dtuic_tenant_id,
    a.type AS data_type_code
from dq_data_source a
inner join dq_project c on a.project_id = c.id
inner join dq_tenant b on a.tenant_id = b.id
where a.write_type = 1 and a.is_deleted = 0
GROUP BY a.writable_db_name,a.project_id;


-- 授权数据库
INSERT INTO `dt_pub_service`.`dsc_auth_ref` (data_info_id,
                                             app_type,
                                             create_user_id,
                                             modify_user_id)
select info.dt_center_source_id,
       '2' as app_type,
       info.create_user_id,
       info.modify_user_id
from (
         SELECT
             b.id as dt_center_source_id,
             b.create_user_id,
             b.modify_user_id
         FROM
             dq_data_source_center a
                 INNER JOIN dq_project c on a.project_id = c.id
                 INNER JOIN dt_pub_service.dsc_info b on b.data_name = CONCAT(a.data_name,'_',c.project_name,'_dq') and a.data_desc = b.data_desc
         GROUP BY a.id
    ) info;


-- 引用数据库
INSERT INTO dt_pub_service.dsc_import_ref (data_info_id,
                                           old_data_info_id,
                                           project_id,
                                           app_type,
                                           dtuic_tenant_id,
                                           create_user_id,
                                           modify_user_id)
select info.dt_center_source_id,
       info.dq_source_id,
       info.project_id,
       '2' as app_type,
       info.dtuic_tenant_id,
       info.create_user_id,
       info.modify_user_id
from (
         SELECT
             b.id as dt_center_source_id,
             a.id as dq_source_id,
             a.project_id AS project_id,
             a.dtuic_tenant_id,
             b.create_user_id,
             b.modify_user_id
         FROM
             dq_data_source_center a
                 INNER JOIN dq_project c on a.project_id = c.id
                 INNER JOIN dt_pub_service.dsc_info b on b.data_name = CONCAT(a.data_name,'_',c.project_name,'_dq') and a.data_desc = b.data_desc
         GROUP BY a.id
     ) info;

-- 回填中心数据源id
UPDATE dq_data_source_center a
INNER JOIN
(select b.id as id,a.id as center_id
from dq_data_source_center a
INNER JOIN dq_project c on a.project_id = c.id
INNER JOIN dt_pub_service.dsc_info b ON b.data_name = CONCAT(a.data_name,'_',c.project_name,'_dq') and a.data_desc = b.data_desc
WHERE b.is_deleted = 0
GROUP BY b.id) info on a.id = info.center_id
SET a.dt_data_source_id = info.id;

-- 回填独立库id
UPDATE dq_data_source_center a
INNER JOIN dq_data_source b on a.id = b.id
LEFT JOIN dt_pub_service.dsc_info c on c.data_desc = CONCAT(b.writable_db_name,'_write_db')
SET a.write_db_source_id = c.id
where a.write_type = 1;

-- 删除连通性校验定时任务
delete from dt_center_cron_schedule where job_detail_name = 'dqDataSourceJob';

delete from qrtz_cron_triggers where TRIGGER_NAME= 'dqDataSourceJobTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'dqDataSourceJobTrigger';
delete from qrtz_job_details where JOB_NAME= 'dqDataSourceJob';
delete from qrtz_simprop_triggers where TRIGGER_NAME= 'dqDataSourceJobTrigger';
delete from qrtz_simple_triggers where TRIGGER_NAME= 'dqDataSourceJobTrigger';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'dqDataSourceJobTrigger';
delete from qrtz_blob_triggers where TRIGGER_NAME= 'dqDataSourceJobTrigger';



