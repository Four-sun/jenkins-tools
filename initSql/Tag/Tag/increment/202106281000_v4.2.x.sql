CREATE TABLE dl_group_subscribe
(
    id               int(11)                            NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id       int(11)                            NOT NULL COMMENT '项目id',
    tenant_id        int(11)                            NOT NULL COMMENT '租户id',
    group_id         int(11)                            NOT NULL COMMENT '群组id',
    send_type        tinyint(1)                         NOT NULL COMMENT '1 邮件 2短信 3钉钉',
    send_gate_source varchar(64)                        NOT NULL COMMENT '发送通道',
    send_gate_name   varchar(64)                          NOT NULL COMMENT '告警通道名称',
    schedule_type    tinyint(1)                         NOT NULL COMMENT '周期类型',
    schedule_conf    varchar(2048)                      NULL comment '定时配置 json格式',
    is_deleted       tinyint  DEFAULT 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    create_at        datetime DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at        datetime DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by        int(11)  DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by        int(11)  DEFAULT 0                 NOT NULL COMMENT '修改人',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组数据订阅表';

create index idx_dtgs_group_id
    on dl_group_subscribe (group_id);

CREATE TABLE dl_group_subscribe_receive_user
(
    id         int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id int(11)                              NOT NULL COMMENT '项目id',
    tenant_id  int(11)                              NOT NULL COMMENT '租户id',
    group_id   int(11)                              NOT NULL COMMENT '群组id',
    user_id    int(11)                              NOT NULL COMMENT '订阅数据接收人',
    create_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted tinyint(1) DEFAULT 0                 NOT NULL COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组订阅接收人表';

create index idx_dtgsru_group_id
    on dl_group_subscribe_receive_user (group_id);

CREATE TABLE dl_group_subscribe_record
(
    id           int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id    int(11)                              NOT NULL COMMENT '租户id',
    project_id   int(11)                              NOT NULL COMMENT '项目id',
    group_id     int(11)                              NOT NULL COMMENT '群组id',
    send_time    datetime                             NOT NULL COMMENT '预期推送时间',
    send_status  tinyint(1)                           NOT NULL COMMENT '发送状态 0未发送 1已发送',
    send_type    varchar(64)                          NOT NULL COMMENT '推送方式',
    receive_user varchar(512)                         NOT NULL COMMENT '接收人',
    send_content varchar(2048)                        NULL     COMMENT '推送内容',
    is_deleted   tinyint(1) DEFAULT 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    create_at    datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at    datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by    int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by    int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    has_prepare  tinyint(1) DEFAULT 0                 NOT NULL COMMENT '是否准备完成,1完成准备，0未准备',
    job_id       varchar(64)                          NULL     COMMENT '调度任务id',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组订阅记录表';

create index idx_dgsr_group_id
    on dl_group_subscribe_record (group_id);

CREATE TABLE dl_group_subscribe_notify_record
(
    id         int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id  int(11)    DEFAULT 0                 NOT NULL COMMENT '租户id',
    project_id int(11)    DEFAULT 0                 NOT NULL COMMENT '项目id',
    group_id   int(11)                              NOT NULL COMMENT '群组id',
    content_id int(11)    DEFAULT 0                 NOT NULL COMMENT '内容文本id',
    create_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted tinyint(1) DEFAULT 0                 NOT NULL COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组订阅消息记录';

INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('groupSubscribeCheckJob', 'groupSubscribeCheckJob', 'groupSubscribeCheckJob', 'groupSubscribeCheckJob',
        'com.dtstack.tagapp.param.schedule.impl.GroupSubscribeCheckQuartz', '0 /5 * * * ? ', 0, NULL, NULL, 'TAG', now(),
        now(), 0);

INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('groupSubscribeSendJob', 'groupSubscribeSendJob', 'groupSubscribeSendJob', 'groupSubscribeSendJob',
        'com.dtstack.tagapp.param.schedule.impl.GroupSubscribeSendQuartz', '0 /1 * * * ? ', 0, NULL, NULL, 'TAG', now(),
        now(), 0);

truncate table dl_group_count;

alter table dl_group_count add constraint unique_name unique(group_id,business_time,is_deleted);

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (99, 'group_analysis_manage_group_subscribe', '群组分析_群组管理_群组订阅', '群组订阅', 65);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 99, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 99)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

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
         left join tagapp.dl_tenant dt on dp.tenant_id = dt.id
WHERE dp.id not in (select project_id FROM dagschedulex.schedule_engine_project WHERE app_type = 4)
  and dp.is_deleted = 0
  and dt.dtuic_tenant_id is not null;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (100, 'project_manage_config_add_api_datasource', '项目管理_项目配置_选择数据源', '选择数据源', 3);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 100, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 100)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (101, 'project_manage_config_member_mange', '项目管理_项目配置_成员管理', '成员管理', 3);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 101, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 101)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;

alter table dl_group_count
    add create_by int(11) DEFAULT 0 NOT NULL COMMENT '创建人',
    add update_by int(11) DEFAULT 0 NOT NULL COMMENT '修改人';

alter table  dl_entity_attr modify entity_attr_cn  varchar(255)   null comment '实体维度中文名';

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (113, 'group_analysis_manage_group_subscribe_status', '群组分析-群组管理-群组订阅状态查询', '群组订阅状态查询', 64);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 113, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 113)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;