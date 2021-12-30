CREATE TABLE dl_group_query_tag_rel
(
    id         int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id int(11)                              NOT NULL COMMENT '项目id',
    tenant_id  int(11)                              NOT NULL COMMENT '租户id',
    group_id   int(11)                              NOT NULL COMMENT '群组id',
    tag_id     int(11)                              NOT NULL COMMENT '可查询的标签id',
    create_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted tinyint(1) DEFAULT 0                 NOT NULL COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组查询维度关系表';

CREATE index idx_dgqtr_group_id
    ON dl_group_query_tag_rel (group_id);

ALTER TABLE dl_tag_temp_table
    ADD COLUMN dsl text NULL COMMENT '标签圈群条件';

ALTER TABLE dl_tag_temp_table
    MODIFY COLUMN task_id varchar(255) null COMMENT '任务id(冗余字段)';

ALTER TABLE dl_tag_temp_table
    ADD COLUMN query_tag_json text NULL COMMENT '群组查询维度';

ALTER TABLE dl_tag_tagsql_temp
    MODIFY COLUMN job_id varchar(256)  null comment '任务id';

delete from dagschedulex.schedule_engine_project where app_type=4;

insert into dagschedulex.schedule_engine_project(project_id, uic_tenant_id, app_type, project_name, project_alias,
                                                 project_Identifier, project_desc, status, create_user_id, gmt_create,
                                                 gmt_modified, is_deleted)
select dp.id,
       dt.dtuic_tenant_id,
       4,
       dp.project_name,
       dp.project_alias,
       dp.project_Identifier,
       dp.project_desc,
       1,
       dp.create_by,
       dp.create_at,
       dp.update_at,
       dp.is_deleted
from tagapp.dl_project dp
         left join tagapp.dl_tenant dt on dp.tenant_id = dt.dtuic_tenant_id
WHERE dp.id not in (select project_id FROM dagschedulex.schedule_engine_project WHERE app_type = 4)
  and dp.is_deleted = 0
  and dt.dtuic_tenant_id is not null and dt.is_deleted=0;

delete from dl_group where is_deleted=1;