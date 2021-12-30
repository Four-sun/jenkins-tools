use api;

create  table if not exists da_invoke_log
(
    id           bigint(36) unsigned auto_increment
        primary key,
    user_id      bigint(36)                           not null,
    api_id       int(36)                              not null comment '接口id',
    biz_type     tinyint(2)                           not null comment '日志类型',
    invoke_time  datetime                             not null comment '调用时间',
    content      text                                 null comment '日志内容',
    gmt_create   datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modified datetime   default CURRENT_TIMESTAMP not null comment '修改时间',
    app_sign     varchar(64)                          not null,
    is_deleted   tinyint(2) default 0                 not null comment '0正常 1逻辑删除'
)
    charset = utf8;

insert into da_invoke_log (id, user_id, api_id, biz_type, invoke_time, content, gmt_create, gmt_modified, app_sign, is_deleted)
SELECT  id, user_id, api_id, biz_type, invoke_time, content, gmt_create, gmt_modified, app_sign, is_deleted from common.da_invoke_log;

create table  if not exists  da_invoke_count
(
    id           int(11) unsigned auto_increment
        primary key,
    user_id      int                  not null,
    invoke_time  datetime             not null,
    api_id       int                  not null,
    count        int                  not null,
    execute_time int(36)              not null,
    gmt_create   datetime             not null,
    gmt_modified datetime             not null on update CURRENT_TIMESTAMP,
    is_deleted   tinyint(2) default 0 not null comment '0正常 1逻辑删除',
    app_sign     varchar(64)          not null
)
    charset = utf8;

create index app_u_a_i
    on da_invoke_count (app_sign, user_id, api_id);

insert into da_invoke_count (id, user_id, invoke_time, api_id, count, execute_time, gmt_create, gmt_modified, is_deleted, app_sign)
select id, user_id, invoke_time, api_id, count, execute_time, gmt_create, gmt_modified, is_deleted, app_sign from common.da_invoke_count;