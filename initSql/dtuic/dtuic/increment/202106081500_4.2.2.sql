
alter table uic_sso_system add is_default tinyint(1) default 0 not null;

update uic_sso_system set is_default = 1  where sys_name = 'UIC账号登录';

create table uic_sso_customize
(
    id                int(11) unsigned auto_increment comment '自增id'
        primary key,
    sys_id            int                                  not null comment '系统id',
    sys_name          varchar(128)                         not null comment '对接系统名称',
    server_url        varchar(255)                         null comment 'server认证回调url',
    params            text                                 null comment '三方参数信息 默认json数组',
    logout_type       tinyint(1) default 0                 not null comment '登出方式',
    logout_url        varchar(255)                         null comment '链接登出方式url',
    jar_name          varchar(255)                         null comment '自定义jar名',
    jump_url          varchar(255)                         null comment '接口跳转连接',
    origin_name       varchar(255)                         null comment '/* jar包 名称*/',
    jar_path          varchar(255)                         null comment '/* jar包 路径*/',
    login_input       tinyint(1)                           null comment '0 开启 1关闭',
    default_tenant_id int                                  null comment '默认同步租户',
    is_deleted        varchar(1) default 'N'               not null comment '是否删除,Y删除，N未删除',
    gmt_create        datetime   default CURRENT_TIMESTAMP null comment '创建时间',
    gmt_modified      datetime   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
    creator           int                                  null comment '创建人',
    modifier          int                                  null comment '修改人'
)
    comment 'customize-server表' charset = utf8;


create table uic_sso_ldap
(
    id                int(11) unsigned auto_increment comment '自增id'
        primary key,
    sys_id            int                                  not null comment '系统id',
    sys_name          varchar(128)                         not null comment '对接系统名称',
    ldap_url          varchar(255)                         not null comment 'ldap认证url',
    can_invite        tinyint(1) default 0                 null comment '能否邀请 ',
    bind_type         tinyint(1) default 0                 not null comment 'ldap 绑定认证方式 0 simple 1 none',
    bind_dn           varchar(128)                         null comment 'ldap simple的bind dn',
    bind_dn_secret    varchar(255)                         null comment 'ldap simple的bind secret',
    base_dn           varchar(128)                         null comment '/* ldap 的base dn */',
    ldap_scope        tinyint(1) default 0                 null comment 'ldap的查询范围 0 one level 1 subtree',
    search_condition  varchar(256)                         null comment 'ldap的查找条件 ',
    account_mapping   varchar(128)                         null comment '账号映射',
    phone_mapping     varchar(128)                         null comment '手机号映射',
    name_mapping      varchar(128)                         null comment '姓名映射',
    email_mapping     varchar(128)                         null comment '邮箱映射',
    default_tenant_id int                                  null comment '默认同步租户',
    sync_mode         tinyint(1) default 0                 null comment '同步模式 0只读/1可编辑',
    sync_type         tinyint(1) default 1                 null comment '同步类型 1接口触发',
    is_deleted        varchar(1) default 'N'               not null comment '是否删除,Y删除，N未删除',
    gmt_create        datetime   default CURRENT_TIMESTAMP null comment '创建时间',
    gmt_modified      datetime   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
    creator           int                                  null comment '创建人',
    modifier          int                                  null comment '修改人'
)
    comment 'ldap-server表' charset = utf8;

