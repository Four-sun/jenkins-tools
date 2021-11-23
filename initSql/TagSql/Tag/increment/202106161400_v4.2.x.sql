CREATE TABLE dl_tag_alarm
(
    id              int(11)                            NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id      int(11)                            NOT NULL COMMENT '项目id',
    tenant_id       int(11)                            NOT NULL COMMENT '租户id',
    alarm_rule_id   int(11)                            NOT NULL COMMENT '规则id',
    task_id         int(11)                            NOT NULL COMMENT '任务id',
    next_check_time datetime                           NOT NULL COMMENT '下一次检查时间',
    is_deleted      tinyint  DEFAULT 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    create_at       datetime DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at       datetime DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)  DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by       int(11)  DEFAULT 0                 NOT NULL COMMENT '修改人',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '告警表,规则和任务关联关系';

create index idx_alarm_rule_id
    on dl_tag_alarm (alarm_rule_id);


CREATE TABLE dl_tag_alarm_record
(
    id            int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id     int(11)                              NOT NULL COMMENT '租户id',
    project_id    int(11)                              NOT NULL COMMENT '项目id',
    alarm_rule_id int(11)                              NOT NULL COMMENT '规则id',
    task_id       int(11)                              NOT NULL COMMENT '任务id',
    job_id        varchar(32)                          NOT NULL COMMENT '告警记录和job实例关联，特殊jobid 000000，特殊规则发送的告警',
    task_name     varchar(255)                         NULL,
    task_type     tinyint(1)                           NULL,
    policy_type   tinyint(1)                           NULL,
    send_time     datetime                             NOT NULL COMMENT '预期发送时间',
    send_status   tinyint(1)                           NOT NULL COMMENT '发送状态 0未发送 1已发送',
    send_type     varchar(64)                          NOT NULL,
    receive_user  varchar(512)                         NOT NULL,
    alarm_content varchar(512)                         NOT NULL COMMENT '告警内容',
    is_deleted    tinyint(1) DEFAULT 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    create_at     datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at     datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by     int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '告警记录表';

create index idx_project_id
    on dl_tag_alarm_record (project_id);


CREATE TABLE dl_tag_alarm_rule
(
    id          int(11)                                       NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id  int(11)                                       NOT NULL COMMENT '项目id',
    tenant_id   int(11)                                       NOT NULL COMMENT '租户id',
    alarm_name  varchar(64)                                   NOT NULL COMMENT '告警规则名称',
    policy_type tinyint(1)                                    NULL COMMENT '触发策略类型 0任务失败，1任务成功，2定时未完成，3超时未完成，4特殊规则',
    policy_conf varchar(512)                                  NOT NULL,
    status      tinyint(1) unsigned DEFAULT 0                 NOT NULL COMMENT '0开启，1关闭',
    send_conf   varchar(512)                                  NOT NULL COMMENT '发送策略配置',
    scope       tinyint(1)          DEFAULT 0                 NULL COMMENT '告警规则作用域 0 指定task，1当前项目全部task',
    create_at   datetime            DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at   datetime            DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by   int(11)             DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by   int(11)             DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted  tinyint(1)          DEFAULT 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '告警规则表';

create index idx_project_id
    on dl_tag_alarm_rule (project_id);


CREATE TABLE dl_tag_alarm_rule_receive_user
(
    id            int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id    int(11)                              NOT NULL COMMENT '项目id',
    tenant_id     int(11)                              NOT NULL COMMENT '租户id',
    alarm_rule_id int(11)                              NOT NULL COMMENT '告警规则id',
    user_id       int(11)                              NOT NULL COMMENT '告警接收人',
    create_at     datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at     datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by     int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted    tinyint(1) DEFAULT 0                 NOT NULL COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '告警规则接收人表';

create index idx_alarm_rule_id
    on dl_tag_alarm_rule_receive_user (alarm_rule_id);


CREATE TABLE dl_tag_alarm_rule_send
(
    id               int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    project_id       int(11)                              NOT NULL COMMENT '项目id',
    tenant_id        int(11)                              NOT NULL COMMENT '租户id',
    alarm_rule_id    int(11)                              NOT NULL COMMENT '告警规则id',
    send_type        tinyint(1)                           NOT NULL COMMENT '1 邮件 2短信 3钉钉 4自定义',
    send_gate_source varchar(64)                          NOT NULL COMMENT '告警通道',
    send_gate_name   varchar(64)                          NOT NULL COMMENT '告警通道名称',
    create_at        datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at        datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by        int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by        int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted       tinyint(1) DEFAULT 0                 NOT NULL COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '告警规则-告警发送方式表';

create index idx_alarm_rule_id
    on dl_tag_alarm_rule_send (alarm_rule_id);


CREATE TABLE dl_tag_notify_record
(
    id         int(11)                              NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id  int(11)    DEFAULT 0                 NOT NULL COMMENT '租户id',
    project_id int(11)    DEFAULT 0                 NOT NULL COMMENT '项目id',
    notify_id  int(11)    DEFAULT 0                 NOT NULL COMMENT '通知id',
    content_id int(11)    DEFAULT 0                 NOT NULL COMMENT '内容文本id',
    cyc_time   varchar(32)                          NULL COMMENT '批处理调度的时间',
    status     tinyint(1) DEFAULT 0                 NOT NULL COMMENT '任务状态',
    create_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    update_at  datetime   DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '创建人',
    update_by  int(11)    DEFAULT 0                 NOT NULL COMMENT '修改人',
    is_deleted tinyint(1) DEFAULT 0                 NOT NULL COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '消息记录';


INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('tagAlarmCheckJob', 'tagAlarmCheckJob', 'tagAlarmCheckJob', 'tagAlarmCheckJob',
        'com.dtstack.tagapp.param.schedule.impl.AlarmCheckQuartz', '0 /5 * * * ? ', 0, NULL, NULL, 'TAG', now(),
        now(), 0);

INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified,
                                     is_deleted)
VALUES ('tagAlarmSendJob', 'tagAlarmSendJob', 'tagAlarmSendJob', 'tagAlarmSendJob',
        'com.dtstack.tagapp.param.schedule.impl.AlarmSendQuartz', '0 /1 * * * ? ', 0, NULL, NULL, 'TAG', now(),
        now(), 0);

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (88, 'task_monitor', '任务监控', '任务监控', 31);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 88, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 88)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (89, 'alarm_rule', '告警规则', '告警规则', 88);
INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 89, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 89)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (90, 'alarm_rule_add', '告警规则创建', '告警规则创建', 89);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 90, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 90)
  and role_value in (1, 2, 3, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (91, 'alarm_rule_query', '告警规则列表查看', '列表查看', 89);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 91, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 91)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (92, 'alarm_rule_switch', '告警规则开关', '规则开关', 91);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 92, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 92)
  and role_value in (1, 2, 3, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (93, 'alarm_rule_edit', '告警规则编辑', '告警规则编辑', 91);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 93, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 93)
  and role_value in (1, 2, 3, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (94, 'alarm_rule_per_query', '告警规则详情', '告警规则详情', 91);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 94, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 94)
  and role_value in (1, 2, 3, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (95, 'alarm_rule_per_delete', '告警规则删除', '告警规则删除', 91);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 95, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 95)
  and role_value in (1, 2, 3, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (96, 'alarm_record', '告警记录', '告警记录', 88);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 96, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 96)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (97, 'alarm_record_query', '告警记录列表查看', '告警记录列表查看', 96);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 97, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 97)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (98, 'alarm_rule_statistics', '告警记录-告警汇总', '告警汇总', 96);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 98, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 98)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (102, 'group_analysis_api', '群组分析-API服务', 'API服务', 64);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 102, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 102)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (103, 'group_analysis_api_black_white_list', '群组分析-API服务-黑白名单', '黑白名单', 102);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 103, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 103)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (104, 'group_analysis_api_black_white_list_query', '群组分析-API服务-黑白名单-查看', '黑白名单查看', 103);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 104, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 104)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (105, 'group_analysis_api_black_white_list_edit', '群组分析-API服务-黑白名单-编辑', '黑白名单编辑', 103);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 105, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 105)
  and role_value in (1, 2, 3, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (106, 'tag_center_personal_operation', '标签中心_个人看板', '个人看板', 31);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 106, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 106)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (107, 'tag_center_personal_operation_query', '标签中心_个人看板_查看', '个人看板查看', 105);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 107, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 107)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (108, 'tag_center_personal_operation_edit', '标签中心_个人看板_编辑', '个人看板编辑', 105);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 108, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 108)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (109, 'tag_center_mask_rule', '标签中心-脱敏规则', '脱敏规则', 114);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 109, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 109)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;


INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (110, 'tag_center_mask_rule_query', '标签中心-脱敏规则-查看', '脱敏规则查看', 109);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 110, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 110)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (111, 'tag_center_mask_rule_edit', '标签中心-脱敏规则-编辑', '脱敏规则编辑', 109);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 111, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 111)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (112, 'tag_center_mask_record', '标签中心-脱敏记录', '脱敏记录', 114);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 112, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 112)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (114, 'tag_center_mask', '标签中心-标签脱敏', '标签脱敏', 31);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 114, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 114)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (115, 'tag_center_mask_rule_add', '标签中心-标签脱敏-创建规则', '标签脱敏-创建规则', 109);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 115, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 115)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (116, 'tag_center_mask_record_switch', '标签中心_脱敏记录_规则开关', '脱敏记录-规则开关', 114);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 116, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 116)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (117, 'tag_center_mask_record_edit', '标签中心_脱敏记录_编辑', '脱敏记录-编辑', 114);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 117, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 117)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (118, 'tag_center_mask_record_add', '标签中心_脱敏记录_创建脱敏', '脱敏记录-创建脱敏', 114);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 118, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 118)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (119, 'group_analysis_group_api', '群组分析_API管理', 'API管理', 102);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 119, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 119)
  and role_value in (1, 2, 3, 4, 5, 6, 7)
  and is_deleted = 0;

INSERT INTO dl_permission(id, code, name, display, parent_id)
VALUES (120, 'group_analysis_api_black_white_list_delete', '群组分析_API服务_黑白名单_删除', '黑白名单_删除', 103);

INSERT INTO `dl_role_permission`(`role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`,
                                 `is_deleted`)
select id, 120, NOW(), NOW(), 0, 0, 0
from dl_role
where dl_role.id not in (select role_id
                         from dl_role_permission
                         where permission_id = 120)
  and role_value in (1, 2, 3, 4, 6, 7)
  and is_deleted = 0;