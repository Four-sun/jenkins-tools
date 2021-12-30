-- 历史数据修改为SparkThrift
UPDATE science.science_data_source_aiworks
SET type = 45;

-- 1.创建数据源中心映射表
drop table IF EXISTS science.`science_data_source_center`;
CREATE TABLE IF not EXISTS science.`science_data_source_center`
(
    `id`                  int(11) NOT NULL AUTO_INCREMENT,
    `dt_center_source_id` int(11) NOT NULL COMMENT '数据源中心id',
    `is_default`          tinyint(1) DEFAULT '0',
    `tenant_id`           int(11) NOT NULL COMMENT '租户 id',
    `project_id`          int(11) NOT NULL COMMENT '项目 id',
    `create_user_id`      int(11) NOT NULL COMMENT '创建用户',
    `modify_user_id`      int(11) NOT NULL COMMENT '修改用户',
    `gmt_create`          datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
    `gmt_modified`        datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
    `is_deleted`          tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `type`                int(11) NOT NULL COMMENT '数据源类型',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据源中心映射表';

-- 2.数据源中心 将算法本地数据源信息迁移到数据源中心
UPDATE dt_pub_service.dsc_info a
    INNER JOIN dt_pub_service.dsc_import_ref b
ON b.is_deleted = 0
    AND b.data_info_id = a.id
    AND b.app_type = 8
    SET a.is_deleted = 1
WHERE
    a.is_deleted = 0
  AND a.data_name LIKE '%_science';
INSERT INTO dt_pub_service.`dsc_info` (`data_type`, `data_version`, `data_name`, `data_desc`, `link_json`,
                                             `data_json`, `data_type_code`, `status`, `is_meta`, `tenant_id`,
                                             `is_deleted`, `dtuic_tenant_id`)
SELECT CASE

           WHEN
               type = 27 THEN
               'Hive'
           WHEN type = 7 THEN
               'Hive'
           WHEN type = 45 THEN
               'SparkThrift'
           ELSE '其他'
           END                                                                AS data_type,
       CASE

           WHEN type = 27 THEN
               '1.x'
           WHEN type = 7 THEN
               '2.x'
           ELSE NULL
           END                                                                AS data_version,
       REPLACE(CONCAT(a.data_name, '_', p.project_name, '_science'), ' ', '') AS data_name,
       a.data_desc,
       CASE

           WHEN JSON_CONTAINS_PATH(CONVERT(FROM_BASE64(data_json), CHAR), "one", '$."jdbc.url"', '$."jdbc.username"',
                                   '$."jdbc.password"') = 1 THEN
               REPLACE(
                       REPLACE(
                               TO_BASE64(
                                       json_remove(
                                               JSON_SET(
                                                       CONVERT(FROM_BASE64(data_json), CHAR),
                                                       '$.jdbcUrl',
                                                       JSON_EXTRACT(CONVERT(FROM_BASE64(data_json), CHAR),
                                                                    '$."jdbc.url"'),
                                                       '$.username',
                                                       JSON_EXTRACT(CONVERT(FROM_BASE64(data_json), CHAR),
                                                                    '$."jdbc.username"')
                                                   ),
                                               '$."jdbc.url"',
                                               '$."jdbc.username"',
                                               '$."jdbc.password"',
                                               '$."kerberosFile"',
                                               '$."kerberosConfig"'
                                           )
                                   ),
                           CHAR ( 10 ), ''
                           ),
                   CHAR ( 13 ), ''
                   )
           ELSE a.data_json
           END                                                                AS link_json,
       CASE

           WHEN JSON_CONTAINS_PATH(CONVERT(FROM_BASE64(data_json), CHAR), "one", '$."jdbc.url"', '$."jdbc.username"',
                                   '$."jdbc.password"') = 1 THEN
               REPLACE(
                       REPLACE(
                               TO_BASE64(
                                       json_remove(
                                               JSON_SET(
                                                       CONVERT(FROM_BASE64(data_json), CHAR),
                                                       '$.jdbcUrl',
                                                       JSON_EXTRACT(CONVERT(FROM_BASE64(data_json), CHAR),
                                                                    '$."jdbc.url"'),
                                                       '$.username',
                                                       JSON_EXTRACT(CONVERT(FROM_BASE64(data_json), CHAR),
                                                                    '$."jdbc.username"'),
                                                       '$.password',
                                                       JSON_EXTRACT(CONVERT(FROM_BASE64(data_json), CHAR),
                                                                    '$."jdbc.password"')
                                                   ),
                                               '$."jdbc.url"',
                                               '$."jdbc.username"',
                                               '$."jdbc.password"'
                                           )
                                   ),
                           CHAR ( 10 ), ''
                           ),
                   CHAR ( 13 ), ''
                   )
           ELSE a.data_json
           END                                                                AS data_json,
       a.type                                                                 AS data_type_code,
       a.link_state                                                           AS STATUS,
       1                                                                      AS is_meta,
       a.tenant_id,
       a.is_deleted,
       b.dtuic_tenant_id
FROM science.science_data_source_aiworks a
         INNER JOIN science.science_tenant b ON a.tenant_id = b.id
    AND b.is_deleted = 0
         INNER JOIN science.science_project p ON a.project_id = p.id
    AND p.is_deleted = 0
WHERE a.is_deleted = 0;

-- 3.插入历史数据到关联表
INSERT INTO science.science_data_source_center (`id`, `project_id`, `tenant_id`, `create_user_id`,
                                                        `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`,
                                                        `is_default`, `dt_center_source_id`, `type`)
SELECT a.id,
       a.project_id,
       a.tenant_id,
       a.create_user_id,
       a.modify_user_id,
       a.gmt_create,
       a.gmt_modified,
       0    AS is_deleted,
       a.is_default,
       c.id AS dt_center_source_id,
       a.type
FROM science.science_data_source_aiworks a
         INNER JOIN science.science_tenant b ON a.tenant_id = b.id
    AND b.is_deleted = 0
         INNER JOIN science.science_project p ON a.project_id = p.id
    AND p.is_deleted = 0
         INNER JOIN dt_pub_service.`dsc_info` c
                    ON c.data_name = CONCAT(a.data_name, '_', p.project_name, '_science')
                        AND b.dtuic_tenant_id = c.dtuic_tenant_id
                        AND c.is_deleted = 0
WHERE a.is_deleted = 0;

-- 4.数据源中心 插入子产品引入表
UPDATE dt_pub_service.dsc_import_ref a
    INNER JOIN dt_pub_service.dsc_info b
ON b.is_deleted = 1
    AND a.data_info_id = b.id
    AND b.data_name LIKE '%_science'
    SET a.is_deleted = 1
WHERE
    a.is_deleted = 0
  AND a.app_type = 8;
INSERT INTO dt_pub_service.`dsc_import_ref` (`data_info_id`, `old_data_info_id`, `dtuic_tenant_id`, `project_id`,
                                                   `app_type`, `is_deleted`, `create_user_id`, `modify_user_id`)
SELECT d.dt_center_source_id AS data_info_id,
       d.id                  AS old_data_info_id,
       t.dtuic_tenant_id,
       d.project_id,
       '8'                   AS app_type,
       0                     AS is_deleted,
       d.create_user_id,
       d.modify_user_id
FROM science.science_data_source_center d
         INNER JOIN science.science_tenant t ON d.tenant_id = t.id
    AND t.is_deleted = 0
WHERE d.is_deleted = 0;


-- 5.数据源中心 插入子产品授权表
UPDATE dt_pub_service.dsc_auth_ref a
    INNER JOIN dt_pub_service.dsc_info b
ON b.is_deleted = 1
    AND a.data_info_id = b.id
    AND b.data_name LIKE '%_science'
    SET a.is_deleted = 1
WHERE
    a.is_deleted = 0
  AND a.app_type = 8;
INSERT INTO dt_pub_service.`dsc_auth_ref` (`data_info_id`, `app_type`, `create_user_id`, `modify_user_id`)
SELECT DISTINCT data_info_id,
                app_type,
                create_user_id,
                modify_user_id
FROM dt_pub_service.dsc_import_ref
WHERE app_type = '8'
  AND is_deleted = 0;

-- 关闭数据源定时任务
UPDATE science.`dt_center_cron_schedule`
SET `gmt_modified` = now(),
    `is_deleted`   = '1'
WHERE `job_trigger_name` = 'dataScienceCheckConnJobTrigger'
  and biz_type = 'dataScience';