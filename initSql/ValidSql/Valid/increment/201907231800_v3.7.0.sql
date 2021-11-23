create table dq_monitor_record_rules
(
    id           int auto_increment
        primary key,
    record_id    int        default 0                 not null comment '记录id',
    rule_id      int                                  null comment '记录运行时规则集合',
    gmt_create   datetime   default CURRENT_TIMESTAMP not null comment '新增时间',
    gmt_modified datetime   default CURRENT_TIMESTAMP not null comment '修改时间',
    is_deleted   tinyint(1) default 0                 not null comment '0正常 1逻辑删除'
)
    comment '记录规则表' charset = utf8;

