-- ################################################################################
-- #############################申请输出参数配置######################################
-- ################################################################################
alter table da_api_apply add column output_params text comment '输出参数';


-- ################################################################################
-- #############################数据源中心改造#######################################
-- ################################################################################

-- 删除da_data_source_ref表（开发服务编排时弃用，未及时删除）
drop table da_data_source_ref;

update da_dict set dict_value = 46 where dict_name = 'ElasticSearch7';

-- 新建da_data_source_center表
CREATE TABLE `da_data_source_center` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` INT NOT NULL COMMENT '租户ID',
  `project_id` INT NOT NULL COMMENT '项目ID',
  `data_name` VARCHAR(128) NOT NULL COMMENT '数据源名称',
  `data_source_center_id` INT NULL COMMENT '数据源中心ID',
  `type` TINYINT(1) NOT NULL COMMENT '数据源类型',
  `active` TINYINT(1) NOT NULL COMMENT '应用状态:0-未启用,1-使用中',
  `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user_id` INT NOT NULL COMMENT '创建的用户ID',
  `modify_user_id` INT NOT NULL COMMENT '更新的用户ID',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除:0-正常,1-逻辑删除',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = '数据源中心关联表';

-- 将da_data_source表迁移到da_data_source_center表(is_deleted等于1的数据不进行迁移)
insert into da_data_source_center(
    id,
    tenant_id,
    project_id,
    data_name,
    type,
    active,
    gmt_create,
    gmt_modified,
    create_user_id,
    modify_user_id,
    is_deleted)
select
    dds.id,
    dds.tenant_id,
    dds.project_id,
    CONCAT(dds.data_name, '_', dp.`project_name`,"_api") data_name,
    type,
    active,
    dds.gmt_create,
    dds.gmt_modified,
    dds.create_user_id,
    dds.modify_user_id,
    0
from
    da_data_source dds
    inner join da_project dp on dds.project_id = dp.id
where
    dds.is_deleted = 0;

-- 将da_data_source中的数据迁移到数据源中心
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
         WHEN dds.type = 1 THEN
           'MySQL'
         WHEN dds.type = 2 THEN
           'Oracle'
         WHEN dds.type = 3 THEN
           'SQLServer'
         WHEN dds.type = 15 THEN
           'AnalyticDB'
         WHEN dds.type = 4 THEN
           'PostgreSQL'
         WHEN dds.type = 29 THEN
           'Impala'
         WHEN dds.type = 19 THEN
           'DB2'
         WHEN dds.type = 23 THEN
           'Kylin JDBC'
         WHEN dds.type = 31 THEN
           'TiDB'
         WHEN dds.type = 13 THEN
           'MongoDB'
         WHEN dds.type = 33 THEN
           'Elasticsearch'
         WHEN dds.type = 11 THEN
           'Elasticsearch'
         WHEN dds.type = 8 THEN
           'HBase'
         WHEN dds.type = 39 THEN
           'HBase'
         WHEN dds.type = 40 THEN
           'KingbaseES8'
         WHEN dds.type = 25 THEN
           'ClickHouse'
         WHEN dds.type = 30 THEN
           'Phoenix'
         WHEN dds.type = 36 THEN
           'Greenplum'
         ELSE
           '其他'
         END AS data_type,
       CASE
         WHEN dds.type = 33 THEN
           '6.x'
         WHEN dds.type = 11 THEN
           '7.x'
         WHEN dds.type = 8 THEN
           '1.x'
         WHEN dds.type = 39 THEN
           '2.x'
         WHEN dds.type = 30 THEN
           '4.x'
         WHEN dds.type = 23 THEN
           '3.x'
         ELSE
           NULL
         END AS data_version,
       dds.type,
       concat(dds.`data_name`,'_',dp.`project_name`,'_api') AS data_name,
       data_desc,
       CASE
         WHEN (dds.type = 1
           OR dds.type = 2
           OR dds.type = 3
           OR dds.type = 15
           OR dds.type = 4
           OR dds.type = 19
           OR dds.type = 23
           OR dds.type = 31
           OR dds.type = 40
           OR dds.type = 25
           OR dds.type = 36) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.jdbcUrl'), '$.username',
                                        JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.username'))), CHAR(10), ''), CHAR(13), '')
         WHEN dds.type = 29 THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.jdbcUrl', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.jdbcUrl'), '$.defaultFS',
                                        JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.defaultFS'))), CHAR(10), ''), CHAR(13), '')
         WHEN dds.type = 13 THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.hostPorts', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.hostPorts'), '$.database',
                                        JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.database'))), CHAR(10), ''), CHAR(13), '')
         WHEN (dds.type = 33
            OR dds.type = 11) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.address', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address'))), CHAR(10), ''), CHAR(13), '')
         WHEN (dds.type = 8
            OR dds.type = 39) THEN
                    -- 数据服务中旧数据会把子目录和集群地方放在一起，需要拆开
                    CASE WHEN locate('/',JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')) = 0 then REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.hbase_quorum', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address'))), CHAR(10), ''), CHAR(13), '')
			        WHEN locate('/',JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')) > 0 then REPLACE(REPLACE(TO_BASE64(JSON_SET('{}', '$.hbase_quorum', replace(SUBSTRING_INDEX(JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address'),'/',1),'"',''))), CHAR(10), ''), CHAR(13), '') end
         WHEN dds.type = 30 THEN dds.data_json
         ELSE
           ''
         END AS link_json,
       CASE
         WHEN (dds.type = 1
           OR dds.type = 2
           OR dds.type = 3
           OR dds.type = 15
           OR dds.type = 4
           OR dds.type = 19
           OR dds.type = 23
           OR dds.type = 31
           OR dds.type = 40
           OR dds.type = 25
           OR dds.type = 36
           OR dds.type = 29
           OR dds.type = 13
           OR dds.type = 33
           OR dds.type = 11
           OR dds.type = 30) THEN dds.data_json
         WHEN (dds.type = 8
            OR dds.type = 39) THEN
           REPLACE(REPLACE(TO_BASE64(
                               JSON_SET('{}', '$.hbase_quorum',
                                                   CASE WHEN locate('/',JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')) = 0 then JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')
                                                        WHEN locate('/',JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')) > 0 then replace(SUBSTRING_INDEX(JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address'),'/',1),'"','') end,
                                              '$.hbase_parent',
                                                    CASE WHEN locate('/',JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')) = 0 then ''
                                                        WHEN locate('/',JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address')) > 0 then replace(concat('/',SUBSTRING_INDEX(JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.address'),'/',-1)),'"','') end,
                                              '$.hbase_other', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.others'),
                                              '$.openKerberos', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.openKerberos'),
                                              '$.kerberosFile', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.kerberosFile'),
                                              '$.kerberosConfig', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.kerberosConfig'),
                                              '$.principal', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.principal'),
                                              '$.hbase_master_kerberos_principal', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.hbase_master_kerberos_principal'),
                                              '$.hbase_regionserver_kerberos_principal', JSON_EXTRACT(CONVERT(from_base64(dds.data_json),CHAR), '$.hbase_regionserver_kerberos_principal'))), CHAR(10), ''), CHAR(13), '')
         ELSE
           ''
         END  AS data_json,
       dds.link_state                        AS status,
       0                                     AS is_meta,
       dds.tenant_id                         AS tenant_id,
       dds.is_deleted                        AS is_deleted,
       dds.create_user_id                    AS create_user_id,
       dds.modify_user_id                    AS modify_user_id,
       dt.dtuic_tenant_id                     AS dtuic_tenant_id
FROM
  da_data_source dds
  inner join da_project dp on dds.project_id = dp.id
  inner join da_tenant dt on dds.tenant_id = dt.id
WHERE dds.is_deleted = 0;

-- 关联中心源id
UPDATE da_data_source_center ddc
  INNER JOIN `dt_pub_service`.dsc_info di ON di.data_name = ddc.data_name and di.tenant_id = ddc.tenant_id
SET ddc.data_source_center_id = di.id;

-- 授权数据库
INSERT INTO `dt_pub_service`.dsc_auth_ref(data_info_id,
                                        app_type,
                                        create_user_id,
                                        modify_user_id)
SELECT info.dt_center_source_id,
       '3' AS app_type,
       info.create_user_id,
       info.modify_user_id
FROM (
       SELECT ddc.data_source_center_id as dt_center_source_id,
              ddc.create_user_id as create_user_id,
              ddc.modify_user_id as modify_user_id
       FROM
       da_data_source_center ddc
       INNER JOIN `dt_pub_service`.dsc_info di ON ddc.data_name = di.data_name and di.tenant_id = ddc.tenant_id
       where ddc.is_deleted = 0
     ) info;

-- 引用数据库
INSERT INTO `dt_pub_service`.dsc_import_ref(data_info_id,
                                          old_data_info_id,
                                          project_id,
                                          app_type,
                                          dtuic_tenant_id,
                                          create_user_id,
                                          modify_user_id)
select info.dt_center_source_id,
       info.da_source_id,
       info.project_id,
       '3' as app_type,
       info.dtuic_tenant_id,
       info.create_user_id,
       info.modify_user_id
from (
       SELECT di.id               as dt_center_source_id,
              ddc.id              as da_source_id,
              ddc.project_id      as project_id,
              dt.dtuic_tenant_id  as dtuic_tenant_id,
              ddc.create_user_id  as create_user_id,
              ddc.modify_user_id  as modify_user_id
       FROM
       da_data_source_center ddc
       INNER JOIN `dt_pub_service`.dsc_info di ON ddc.data_name = di.data_name and di.tenant_id = ddc.tenant_id
       INNER JOIN da_tenant dt on ddc.tenant_id = dt.id
       where ddc.is_deleted = 0
     ) info;

-- 删除da_data_source表
drop table da_data_source;

-- 删除数据源连通性检查定时任务
delete from dt_center_cron_schedule where job_trigger_name = 'apiDataSourceJobTrigger';
delete from qrtz_cron_triggers where TRIGGER_NAME= 'apiDataSourceJobTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'apiDataSourceJobTrigger';
delete from qrtz_job_details where JOB_NAME= 'apiDataSourceJob';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'apiDataSourceJobTrigger';

-- 数据源_编辑权限改为数据源_引入权限
update da_permission set code = 'api_datasource_import',name = '数据源_引入', display = '引入' where code = 'api_datasource_edit';

-- ################################################################################
-- #############################加解密相关###########################################
-- ################################################################################
-- 新建秘钥信息表
CREATE TABLE `da_secret_key_info` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT NOT NULL COMMENT '租户ID',
  `user_id` INT NOT NULL COMMENT '用户ID',
  `public_key` VARCHAR(1024) NOT NULL COMMENT 'RSA公钥',
  `private_key` VARCHAR(1024) NOT NULL COMMENT 'RSA私钥',
  `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除:0-正常,1-逻辑删除',
  PRIMARY KEY (`id`))
COMMENT = '秘钥信息表';

-- da_api新增传输加密方式字段
ALTER TABLE `da_api`
ADD COLUMN `transfer_encrypt_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '传输加密方式:0-不加密,1-RSA+AES' AFTER `app_type`;

-- da_api_test新增传输加密方式字段
ALTER TABLE `da_api_test`
ADD COLUMN `transfer_encrypt_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '传输加密方式:0-不加密,1-RSA+AES' AFTER `app_type`;

-- 修改kylin数据源的名称
update da_dict set dict_name = 'Kylin JDBC',dict_name_zh = 'Kylin JDBC', dict_name_en = 'Kylin JDBC' where dict_name = 'Kylin';

-- ################################################################################
-- #############################新增solr数据源#######################################
-- ################################################################################
INSERT INTO da_dict VALUES ('20', '1', 'Solr7.x', '53', 'Solr7.x', 'Solr7.x', '20', now(), now(), '0');

-- ################################################################################
-- #############################注册API优化#########################################
-- ################################################################################
alter table da_api add column contain_original_status int(2) null default '0' comment '返回结果中携带第三方 API 状态码 0/1';
alter table da_api_test add column contain_original_status int(2) null default '0' comment '返回结果中携带第三方 API 状态码 0/1';

alter table da_api add column content_type int(2) null default '1' comment '输入方式 json(1) formdata(2)';
alter table da_api_test add column content_type int(2) null default '1' comment '输入方式 json(1) formdata(2)';