ALTER TABLE dl_project
    ADD data_source_id int(11) DEFAULT NULL COMMENT 'project对应的数据源id';
ALTER TABLE dl_project CHANGE data_source_id data_source_id int(11) NULL COMMENT 'project对应的数据源id' AFTER top_sign;


INSERT INTO dt_pub_service.`dsc_info`(`data_type`,
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
                                      `dtuic_tenant_id`)
SELECT 'Presto'
     , null                                         as data_version
     , replace('_name_tag', 'name', p.project_name) AS data_name
     , p.project_desc
     , REPLACE(REPLACE(TO_BASE64(replace('{"jdbcUrl":url,"username":"root"}', 'url', p.url)), CHAR(10), ''), CHAR(13),'')
     ,REPLACE(REPLACE(TO_BASE64(replace('{"password":"","jdbcUrl":url,"username":"root"}', 'url', p.url)), CHAR(10), ''), CHAR(13),'')
     , 1
     , 1
     , 1
     , 0
     , p.create_by
     , p.update_by
     , p.tenant_id
FROM (
         SELECT pro.project_name
              , pro.project_desc
              , json_extract(convert(FROM_BASE64(data_json), char), "$.address") as url
              , pro.create_by
              , pro.update_by
              , pro.tenant_id
         FROM dl_project pro
                  JOIN dl_data_source d
                       ON pro.id = d.project_id
         WHERE data_source_id is null
     ) p;

INSERT INTO dt_pub_service.`dsc_auth_ref`(`data_info_id`,
                                          `app_type`,
                                          `create_user_id`,
                                          `modify_user_id`)
select info.id,
       '4' as app_type,
       info.create_user_id,
       info.modify_user_id
from (
         select d.id, d.create_user_id, d.modify_user_id
         from dl_project p
                  inner join dt_pub_service.`dsc_info` d
                             on replace('_name_tag', 'name', project_name) = d.data_name
         where p.data_source_id is null
     ) info;

INSERT INTO dt_pub_service.`dsc_import_ref`(`data_info_id`,
                                            `app_type`,
                                            `create_user_id`,
                                            `modify_user_id`)
select info.id,
       '4' as app_type,
       info.create_user_id,
       info.modify_user_id
from (
         select d.id, d.create_user_id, d.modify_user_id
         from dl_project p
                  inner join dt_pub_service.`dsc_info` d
                             on replace('_name_tag', 'name', project_name) = d.data_name
         where p.data_source_id is null
     ) info;

update dl_project inner join dt_pub_service.`dsc_info` d
on replace('_name_tag','name',project_name) = d.data_name
    set data_source_id = d.id;

update dl_entity d inner join dl_project p on d.project_id = p.id
set d.data_source_id = p.data_source_id;

update dl_relation d inner join dl_project p on d.project_id = p.id
set d.data_source_id = p.data_source_id;



