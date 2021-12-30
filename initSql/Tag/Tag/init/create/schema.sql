-- 登陆时
-- 1.插入用户信息；
-- 2.插入租户信息；
-- 3.为此用户插入默认角色权限

-- 添加项目
-- 1.插入项目信息 dl_project
-- 2.插入项目租户关联信息 dl_project_hit
-- 3.复制默认角色权限 插入项目的角色权限 dl_role dl_role_permission
-- 4.插入创建用户信息 dl_role_user

-- 系统功能表
CREATE TABLE dl_user
(
    id            int(11)      NOT NULL AUTO_INCREMENT,
    dtuic_user_id int(11)      NOT NULL COMMENT '用户id',
    user_name     varchar(255) NOT NULL COMMENT '用户名称',
    email         varchar(255) NOT NULL COMMENT '邮箱',
    phone_number  varchar(255) COMMENT '用户手机号',
    status        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
    create_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='用户表';

CREATE TABLE dl_tenant
(
    id              int(11)      NOT NULL AUTO_INCREMENT,
    dtuic_tenant_id int(11)      NOT NULL COMMENT '租户id',
    tenant_name     varchar(255) NOT NULL COMMENT '租户名称',
    tenant_desc     varchar(512) COMMENT '租户描述',
    status          tinyint(1)   NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
    create_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='租户表';

CREATE TABLE dl_project
(
    id                 int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id          int(11)      NOT NULL COMMENT '租户id',
    project_name       varchar(255) NOT NULL COMMENT '项目名称',
    project_desc       varchar(512) COMMENT '项目描述',
    project_alias      varchar(255) NULL COMMENT '项目别名',
    project_Identifier varchar(255) NOT NULL COMMENT '项目标识',
    top_sign           tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否置顶 1置顶 0不是置顶',
    data_source_id     int(11)               DEFAULT NULL COMMENT '数据源id',
    create_at          datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at          datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by          int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by          int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='项目表';


CREATE TABLE dl_project_stick
(
    id           int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id    int(11)    NOT NULL DEFAULT '0' COMMENT '租户id',
    project_id   int(11)    NOT NULL DEFAULT '0' COMMENT '项目id',
    user_id      int(11)             DEFAULT NULL COMMENT '用户id',
    stick        datetime            DEFAULT NULL COMMENT '置顶字段',
    gmt_create   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    gmt_modified datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    is_deleted   tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8 COMMENT ='项目的置顶记录表';

CREATE TABLE dl_project_hit
(
    id         int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    project_id int(11)    NOT NULL COMMENT '项目id',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='项目租户关联表';

CREATE TABLE dl_role_user
(
    id         int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    project_id int(11)    NOT NULL DEFAULT '-1' COMMENT '项目id',
    role_id    int(11)    NOT NULL COMMENT '角色id:对应的dl_role_permission中的自增id',
    user_id    int(11)    NOT NULL COMMENT '用户id',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='角色用户关联表';

CREATE TABLE dl_role
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)      NOT NULL DEFAULT '0' COMMENT '租户id,0:基础角色',
    project_id int(11)      NOT NULL DEFAULT '0' COMMENT '项目id',
    role_name  varchar(255) NOT NULL COMMENT '角色名称',
    role_type  tinyint(1)   NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
    role_value tinyint(1)   NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), PROJECTOWNER(2), PROJECTADMIN(3), MEMBER(4), OPERATION(5), DATADEVELOP(6)',
    role_desc  varchar(255) NOT NULL DEFAULT '' COMMENT '角色描述',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='角色表';

CREATE TABLE dl_role_permission
(
    id            int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    role_id       int(11)    NOT NULL COMMENT '关联角色id',
    permission_id int(11)    NOT NULL COMMENT '关联权限id',
    create_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='角色权限关联表';

CREATE TABLE dl_permission
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    code       varchar(255) NOT NULL DEFAULT '' COMMENT '权限CODE',
    name       varchar(255)          DEFAULT NULL COMMENT '权限名',
    display    varchar(255)          DEFAULT NULL COMMENT '展示名称',
    parent_id  int(11)               DEFAULT NULL COMMENT '父权限id',
    type       tinyint(1)            DEFAULT '1' COMMENT '1:功能权限;2:数据权限 （保留字段）',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='权限表';

-- 功能模块表

CREATE TABLE dl_data_source
(
    id         int(11)       NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)       NOT NULL COMMENT '租户id',
    project_id int(11)       NOT NULL COMMENT '项目id',
    data_name  varchar(128)  NOT NULL COMMENT '数据源名称',
    data_desc  varchar(1024) COMMENT '数据源描述',
    data_json  varchar(1024) NOT NULL COMMENT '链接数据源信息需要加密 json格式',
    type       tinyint(1)    NOT NULL DEFAULT '0' COMMENT '数据源类型 11：ElasticSearch',
    active     tinyint(1)    NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
    link_state tinyint(1)    NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
    create_at  datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)       NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)       NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1)    NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='数据源表';

CREATE TABLE dl_entity
(
    id                       int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id                int(11)      NOT NULL COMMENT '租户id',
    project_id               int(11)      NOT NULL COMMENT '项目id',
    entity_name              varchar(128) NOT NULL COMMENT '实体名称',
    entity_identifier        varchar(128) NOT NULL COMMENT '实体标识',
    data_source_id           int(11)      NOT NULL COMMENT '数据源id',
    data_source_table        varchar(255)          DEFAULT NULL COMMENT '数据表（ES索引）',
    data_source_table_type   varchar(255) COMMENT '数据表（ES类型）',
    entity_primary_key       varchar(255)          DEFAULT NULL COMMENT '实体主键',
    entity_desc              varchar(255) COMMENT '实体描述',
    entity_partition_filed   varchar(128) COMMENT '分区字段',
    entity_partition_format  varchar(128) COMMENT '分区格式',
    entity_current_partition varchar(128) COMMENT '当前分区',
    relation_id              int(11)               DEFAULT NULL COMMENT '关系id',
    relation_type            TINYINT(1)   NULL COMMENT '关系类型 0:逻辑表 1:物理表',
    relevance_key            varchar(255)          DEFAULT NULL COMMENT '主附表关联键',
    table_comment            varchar(512)          DEFAULT NULL COMMENT 'presto中该表的描述',
    platform_task_id         Int(11)      NULL COMMENT '其他平台任务id',
    platform_task_name       VarChar(255)          DEFAULT NULL COMMENT '其他平台任务name',
    platform_task_source     Int(2)       NULL COMMENT '其他平台任务的来源',
    master_entity_id         Int(11)      NULL     DEFAULT '-1' COMMENT '主表值为-1，附表值为主表id',
    create_at                datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at                datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by                int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by                int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted               tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='实体表';

CREATE TABLE dl_entity_data_count
(
    id                int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id         int(11)    NOT NULL COMMENT '租户id',
    entity_id         int(11)    NOT NULL COMMENT '实体id',
    entity_data_count int(11)    NOT NULL COMMENT '实体数据数量（更新数据时刷新）',
    create_at         datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at         datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by         int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by         int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted        tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='实体数据量表';

CREATE TABLE dl_entity_attr
(
    id                int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id         int(11)      NOT NULL COMMENT '租户id',
    entity_id         int(11)      NOT NULL COMMENT '实体id',
    entity_name       varchar(255)          DEFAULT NULL COMMENT '实体名称',
    entity_attr       varchar(255) NOT NULL COMMENT '实体维度',
    entity_attr_cn    varchar(255) NOT NULL COMMENT '实体维度中文名',
    is_primary_key    tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否主键,1是，0不是',
    is_multiple_value tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否多值,1是，0不是',
    data_type         tinyint(1)   NOT NULL COMMENT '数据类型,1：字符型：2：数值型，3：日期型，4：字典型',
    data_type_str     varchar(255)          DEFAULT NULL COMMENT '数据类型',
    tag_id            int(11)               DEFAULT NULL COMMENT '标签id',
    create_at         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by         int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by         int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='实体维度表';

CREATE TABLE dl_tag
(
    id                       int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id                int(11)      NOT NULL COMMENT '租户id',
    entity_id                int(11)      NOT NULL COMMENT '实体Id',
    project_id               int(11)      NOT NULL COMMENT '项目id',
    tag_name                 varchar(128) NOT NULL COMMENT '标签名称',
    tag_identifier           varchar(128) COMMENT '标签标识',
    data_type_str            varchar(255)          DEFAULT NULL COMMENT '数据类型',
    tag_type                 tinyint(1)   NOT NULL COMMENT '标签类型,0：原子标签,1:衍生标签，2:自定义标签 3.组合标签 4:物理表标签 5:附表标签',
    tag_dict_id              int(11) COMMENT '关联标签字典id',
    circle_entity_id         int(11)               DEFAULT NULL COMMENT '圈选实体',
    relation_id              int(11) COMMENT '衍生标签关联关系id',
    tagsql_id                int(11)               DEFAULT NULL COMMENT '产生衍生标签的sql id',
    tag_relation_entity_name varchar(128)          DEFAULT NULL COMMENT '关系所属实体名称',
    tag_desc                 varchar(512) COMMENT '标签描述',
    use_tag_value            tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否可以使用标签值查询 0 使用dsl查询 1:使用标签值查询',
    tag_status               tinyint(1)   NOT NULL DEFAULT '0' COMMENT '标签状态,0：正常,1：异常',
    create_at                datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at                datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by                int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by                int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted               tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    tag_update_status        tinyint(1)            default 1 NOT NULL COMMENT '更新状态 1 初始化 2 更新中 3 更新完成 4 更新失败 5 未更新',
    tag_update_status_before tinyint(1)   NULL COMMENT '前一次标签的更新状态 0 初始化 1未更新,2 更新中 3 更新完成 4 更新失败',
    status_update_time       datetime     NULL COMMENT '标签状态更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签表';

CREATE TABLE dl_attr_value_count
(
    id               int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id        int(11)    NOT NULL COMMENT '租户id',
    attr_id          int(11)    NOT NULL COMMENT '维度id',
    attr_value_count int(11)    NOT NULL COMMENT '维度属性值数量（更新数据时刷新）',
    create_at        datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at        datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by        int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by        int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted       tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='属性值数量表';

CREATE TABLE dl_tag_data_count
(
    id             int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id      int(11)    NOT NULL COMMENT '租户id',
    tag_id         int(11)    NOT NULL COMMENT '标签id',
    tag_data_count int(11)    NOT NULL COMMENT '标签覆盖数量（更新数据时刷新）',
    create_at      datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at      datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by      int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by      int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted     tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签覆盖数量表';

CREATE TABLE dl_tag_value
(
    id             int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id      int(11)      NOT NULL COMMENT '租户id',
    tag_id         int(11)      NOT NULL COMMENT '标签id',
    tag_value_name varchar(128) NOT NULL COMMENT '标签值名称',
    order_val      int(3)       NOT NULL DEFAULT '0' COMMENT '排序值（从小到大）',
    search_dsl     text COMMENT '正向DSL,根据标签在es中筛选符合条件的实体',
    aggr_dsl       text COMMENT '反向DSL,通过聚合DSL在es中反向获取实体的标签',
    exp            text COMMENT '衍生表达式',
    create_at      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by      int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by      int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted     tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签值表';

CREATE TABLE dl_relation
(
    id                        int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id                 int(11)      NOT NULL COMMENT '租户id',
    project_id                int(11)      NOT NULL COMMENT '项目id',
    data_source_id            int(11)      NOT NULL COMMENT '数据源id',
    relation_belong_entity_id int(11)               DEFAULT NULL COMMENT '关系隶属实体',
    relation_name             varchar(128) NOT NULL COMMENT '关系名称',
    relation_desc             varchar(512) COMMENT '关系描述',
    module_id                 int(11)               DEFAULT NULL COMMENT '模型id',
    module_type               tinyint(1)            DEFAULT NULL COMMENT '储存模型 0:逻辑关系 1:物理表',
    primary_key               varchar(255) NOT NULL COMMENT '主键',
    table_name_primary_key    varchar(255)          DEFAULT NULL COMMENT '主键所对应的表',
    parent_task_id            int(11)               DEFAULT NULL COMMENT '父任务id',
    parent_task_name          varchar(100)          DEFAULT NULL COMMENT '父任务名称',
    parent_task_id_source     int(11)               DEFAULT NULL COMMENT '父任务数据来源',
    relation_json             text                  DEFAULT NULL COMMENT '关系JSON(前端展现)',
    used_count                int(11)      NOT NULL DEFAULT '0' COMMENT '被调用次数（递增）',
    relation_status           tinyint(1)   NOT NULL DEFAULT '0' COMMENT '关系状态：0：不可用，1：创建中：2：创建成功，3：创建失败',
    create_at                 datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at                 datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by                 int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by                 int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted                tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='关系表';

CREATE TABLE dl_relation_used_record
(
    id          int(11)    NOT NULL AUTO_INCREMENT,
    relation_id int(11)    NOT NULL COMMENT '关系id',
    used_type   tinyint(1) NOT NULL COMMENT '被调用类型,1：衍生标签，2：群组',
    used_id     int(11) COMMENT '调用的id',
    create_at   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by   int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by   int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted  tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='关系被引用记录表';

CREATE TABLE dl_relation_collection
(
    id                 int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id          int(11)      NOT NULL COMMENT '租户id',
    project_id         int(11)      NOT NULL COMMENT '项目id',
    relation_id        int(11)      NOT NULL COMMENT '关系id',
    left_entity_id     int(11)               DEFAULT NULL COMMENT '左表实体id',
    left_entity_index  varchar(255) NOT NULL COMMENT '左表实体索引',
    left_attr_id       int(11)               DEFAULT NULL COMMENT '左表维度id',
    left_attr_name     varchar(255) NOT NULL COMMENT '左表维度名称',
    right_entity_id    int(11)               DEFAULT NULL COMMENT '右表实体id',
    right_entity_index varchar(255) NOT NULL COMMENT '右表实体索引',
    right_attr_id      int(11)               DEFAULT NULL COMMENT '右表维度id',
    right_attr_name    varchar(255) NOT NULL COMMENT '右表维度名称',
    join_type          tinyint(1)            DEFAULT NULL COMMENT '关联关系 1:LeftJoin 2:RightJoin 3:InnerJoin 4:OuterJoin',
    create_at          datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at          datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by          int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by          int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='关系集表';

CREATE TABLE dl_dict
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)      NOT NULL COMMENT '租户id',
    project_id int(11)      NOT NULL COMMENT '项目id',
    dict_name  varchar(255) NOT NULL COMMENT '字典名称',
    dict_desc  varchar(512) COMMENT '字典描述',
    dict_type  tinyint(1)   NOT NULL DEFAULT '0' COMMENT '字典类型,0：标签字典，1：维度字典',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签字典表';

CREATE TABLE dl_dict_value
(
    id              int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id       int(11)      NOT NULL COMMENT '租户id',
    dict_id         int(11)      NOT NULL COMMENT '字典id',
    dict_value      varchar(255) NOT NULL COMMENT '字典值',
    dict_value_name varchar(255) NOT NULL COMMENT '字典值名称',
    create_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    is_deleted      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签字典值表';

CREATE TABLE dl_tag_cate
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)      NOT NULL COMMENT '租户id',
    entity_id  int(11)      NOT NULL COMMENT '实体id',
    pid        int(11)      NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
    cate_name  varchar(128) NOT NULL COMMENT '文件夹名称',
    order_val  int(11)      NOT NULL DEFAULT '0' COMMENT '排序值（从小到大）',
    level      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '目录层级 0：一级，1：二级，2:二级以下目录',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签目录表';

CREATE TABLE dl_tag_cate_rel
(
    id         int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    tag_id     int(11)    NOT NULL COMMENT '标签id',
    cate_id    int(11)    NOT NULL COMMENT '目录id',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签目录表';

CREATE TABLE dl_group
(
    id                             int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id                      int(11)      NOT NULL COMMENT '租户id',
    project_id                     int(11)      NOT NULL COMMENT '项目id',
    entity_id                      int(11)      NOT NULL COMMENT '实体id',
    group_name                     varchar(64)  NOT NULL COMMENT '群组名称',
    group_identifier               varchar(64)  NOT NULL COMMENT '群组英文名称',
    group_data_count               int(11)      NOT NULL DEFAULT '0' COMMENT '群组数据量（刷新 或 统计）',
    growth_num                     int(11)      NOT NULL DEFAULT '0' COMMENT '增长量',
    group_type                     tinyint(1)   NOT NULL COMMENT '群组类型 0：规则创建，1：手动上传',
    group_store_type               tinyint(1)   NOT NULL COMMENT '群组类型 0：实时群组 1：动态群组 2:静态群组',
    group_status                   tinyint(1)            DEFAULT '0' COMMENT '0：正常，1：异常',
    group_desc                     varchar(255) COMMENT '群组描述',
    group_file_name                varchar(255) COMMENT '群组上传文件名',
    is_open_api                    tinyint(1)   NOT NULL COMMENT 'api开放状态 0：关闭，1：开启',
    is_publish                     tinyint(1)            DEFAULT '-1' COMMENT '是否上下线 0:下线,1:上线',
    publish_time                   datetime     NULL COMMENT '发布时间',
    computing_time                 datetime     NULL COMMENT '计算时间',
    high_proportion_analyse_time   datetime     NULL COMMENT '最近一次当前群组显著性分析时间',
    high_proportion_analyse_status tinyint(1)            DEFAULT '0' COMMENT '当前群组显著性特征分析状态 0-未分析，1-分析中，2-已分析',
    create_at                      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at                      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by                      int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by                      int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted                     tinyint(1)   NOT NULL COMMENT '是否删除,1删除，0未删除',
    group_current_partition        varchar(128) NULL COMMENT '当前可用分区',
    personalized                   tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否应用群组个性化模版 0 未应用 1应用',
    PRIMARY KEY (id),
    UNIQUE KEY `index_group_identifier` (`project_id`, `group_identifier`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组表';

CREATE TABLE dl_group_tag
(
    id            int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id     int(11)    NOT NULL COMMENT '租户id',
    project_id    int(11)    NOT NULL COMMENT '项目id',
    tag_id        int(11)    NOT NULL COMMENT '标签id',
    group_id      int(11)    NOT NULL COMMENT '群组id',
    ring_group_id int(11) COMMENT '圈群群组id',
    create_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组圈群标签';

CREATE TABLE dl_group_upload_data
(
    id            int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id     int(11)      NOT NULL COMMENT '租户id',
    project_id    int(11)      NOT NULL COMMENT '项目id',
    group_id      int(11)      NOT NULL COMMENT '群组id',
    data_id       varchar(128) NOT NUll COMMENT '匹配到到数据id',
    task_id       varchar(128) NOT NULL COMMENT '任务id,上传中使用',
    upload_status int(11)      NOT NULL COMMENT '上传状态 0初始状态 1上传中 2上传完成',
    create_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组上传数据表';

CREATE TABLE dl_api
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)      NOT NULL DEFAULT '0' COMMENT '租户id',
    project_id int(11)      NOT NULL DEFAULT '0' COMMENT '项目id',
    api_name   varchar(255) NOT NULL COMMENT 'API名称',
    api_desc   varchar(512) COMMENT 'API描述',
    api_token  varchar(255) NOT NULL COMMENT 'API token',
    entity_id  int(11)      NOT NULL COMMENT '实体id',
    group_id   int(11)      NOT NULL COMMENT '群组id',
    status     tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0：正常，1：已发布，2：禁用',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='API表';

CREATE TABLE dl_api_tag_rel
(
    id         int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    project_id int(11)    NOT NULL COMMENT '项目id',
    api_id     int(11)    NOT NULL COMMENT 'apiId',
    api_tag_id int(11)    NOT NUll COMMENT 'api中的标签id(既维度id)',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT 'API维度表';

-- 数据表

CREATE TABLE da_index_update_record
(
    id              int(11)      NOT NULL AUTO_INCREMENT,
    ts              int(11)      NOT NUll COMMENT '时间分区(20191119)',
    data_source_url varchar(512) NOT NULL COMMENT '数据源url',
    index_name      varchar(255) NOT NULL COMMENT 'ES索引名称',
    data_count      int(11)      NOT NULL DEFAULT '0' COMMENT '数据量',
    is_update       tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否更新（数据端插入0）,0：未更新，1：更新',
    create_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)      NULL     DEFAULT '0' COMMENT '默认为0',
    update_by       int(11)      NULL     DEFAULT '0' COMMENT '默认为0',
    is_deleted      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '实体更新-数据表（数据端）';

CREATE TABLE da_column_data
(
    id                int(11)      NOT NULL AUTO_INCREMENT,
    ts                int(11)      NOT NUll COMMENT '时间分区(20191119)',
    data_source_url   varchar(512) NOT NULL COMMENT '数据源url',
    index_name        varchar(128) NOT NULL COMMENT '索引名称',
    column_name       varchar(128) NOT NULL COMMENT '索引属性名称',
    is_multiple_value tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否多值,1是，0不是',
    data_count        int(11)      NOT NULL DEFAULT '0' COMMENT '数据量',
    create_at         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by         int(11)      NULL     DEFAULT '0' COMMENT '默认为0',
    update_by         int(11)      NULL     DEFAULT '0' COMMENT '默认为0',
    is_deleted        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='实体维度-数据表（数据端）';

CREATE TABLE da_column_data_value
(
    id              int(11)      NOT NULL AUTO_INCREMENT,
    ts              int(11)      NOT NUll COMMENT '时间分区(20191119)',
    data_source_url varchar(512) NOT NULL COMMENT '数据源url',
    index_name      varchar(128) NOT NULL COMMENT '索引名称',
    column_name     varchar(128) NOT NULL COMMENT '索引属性名称',
    column_value    varchar(255) NOT NULL COMMENT '索引属性值（20个以内，不重复）',
    create_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)      NULL     DEFAULT '0' COMMENT '默认为0',
    update_by       int(11)      NULL     DEFAULT '0' COMMENT '默认为0',
    is_deleted      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='实体维度值-数据表（数据端）';

-- 暂时废弃

CREATE TABLE dl_group_upload_record
(
    id            int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id     int(11)      NOT NULL COMMENT '租户id',
    entity_id     int(11)      NOT NULL COMMENT '实体id',
    group_id      int(11)      NOT NULL COMMENT '群组id',
    file_name     varchar(255) NOT NULL COMMENT '上传文件名',
    task_id       varchar(128) NOT NULL COMMENT '任务id,上传中使用',
    upload_status int(11)      NOT NULL COMMENT '上传状态 0初始状态 1上传中 2上传完成',
    create_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组上传记录表';

CREATE TABLE dl_group_upload_record_error_info
(
    id            int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id     int(11)      NOT NULL COMMENT '租户id',
    record_id     int(11)      NOT NULL COMMENT '上传记录id',
    task_id       varchar(128) NOT NULL COMMENT '任务id,上传中使用',
    upload_status int(11)      NOT NULL COMMENT '上传状态 0初始状态 1上传中 2上传完成',
    error_msg     text COMMENT '错误信息',
    create_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '群组上传记录错误信息表';

CREATE TABLE dl_api_invoke_log
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    api_id     varchar(255) NOT NULL COMMENT '被调用的api的id',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='API调用日志表';

CREATE TABLE dl_user_group
(
    id              int(11)      NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id       int(11)      NOT NULL COMMENT '租户id',
    project_id      int(11)      NOT NULL COMMENT '项目id',
    user_group_name varchar(255) NOT NULL COMMENT '用户分组名称',
    user_group_desc varchar(255) COMMENT '用户分组描述',
    create_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='用户分组表';

CREATE TABLE dl_use_tag_rel
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    project_id int(11)    NOT NULL COMMENT '项目id',
    tag_id     int(11)    NOT NULL COMMENT '标签id',
    use_tag_id int(11)    NOT NULL COMMENT '使用标签id',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='用户分组-用户id关联表';


CREATE TABLE dl_tag_publish
(
    id                 int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id          int(11)    NOT NULL COMMENT '租户id',
    project_id         int(11)    NOT NULL COMMENT '项目id',
    entity_id          int(11)    NOT NULL COMMENT '实体id',
    tag_id             int(11)    NOT NULL COMMENT '标签id',
    publish_status     int(2)     NOT NULL DEFAULT '0' COMMENT '发布状态: 0未发布，1已下线，2已发布，3过期下线',
    publish_start_time datetime            DEFAULT NULL COMMENT '发布有效期开始时间',
    publish_end_time   datetime            DEFAULT NULL COMMENT '发布有效期结束时间',
    is_time_limit      tinyint(1) NOT NULL DEFAULT '1' COMMENT 'false 无限制  true 使用生命周期',
    is_visible_limit   tinyint(1) NOT NULL DEFAULT '1' COMMENT 'false 所有人可见 true 限制可见用户组',
    offline_time       datetime            DEFAULT NULL COMMENT '实际下线时间',
    security_level     int(2)     NOT NULL COMMENT '安全等级-,0：初始化 ,1公有标签，2普通标签',
    create_at          datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at          datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by          int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by          int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted         tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='标签发布表/标签市场';

CREATE TABLE dl_user_group_tag_rel
(
    id            int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id     int(11)    NOT NULL COMMENT '租户id',
    project_id    int(11)    NOT NULL COMMENT '项目id',
    tag_id        int(11)    NOT NULL COMMENT '标签id',
    user_group_id int(11)    NOT NULL COMMENT '用户组id',
    create_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='标签-用户组关联表';


CREATE TABLE dl_tag_apply
(
    id                      int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id               int(11)    NOT NULL COMMENT '租户id',
    project_id              int(11)    NOT NULL COMMENT '项目id',
    tag_id                  int(11)    NOT NULL COMMENT '标签id',
    apply_user_id           int(11) COMMENT '申请人id',
    apply_start_time        datetime                      DEFAULT NULL COMMENT '申请开始时间',
    apply_end_time          datetime                      DEFAULT NULL COMMENT '申请结束时间',
    is_limit                tinyint(1) NOT NULL           DEFAULT '1' COMMENT 'false 无限制 true 使用生命周期',
    apply_explain           varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '申请说明',
    approve_user_id         int(11) COMMENT '审批人id',
    approve_explain         varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '审批说明',
    approve_status          int(11)    NOT NULL COMMENT ' 审批状态 0:初始化 1:审批中 2:已审批 3:拒绝审批 4.授权审批 5.已过期（通过计算得出）',
    apply_time              datetime                      DEFAULT NULL COMMENT '申请时间',
    approve_time            datetime                      DEFAULT NULL COMMENT '审批时间',
    approve_start_up_status tinyint(1) NOT NULL           DEFAULT '0' COMMENT '审批启动状态  false 启动 true 停用',
    create_at               datetime   NOT NULL           DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at               datetime   NOT NULL           DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by               int(11)    NOT NULL           DEFAULT '0' COMMENT '创建的用户',
    update_by               int(11)    NOT NULL           DEFAULT '0' COMMENT '修改的用户',
    is_deleted              tinyint(1) NOT NULL           DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='标签市场申请表';

CREATE TABLE dl_user_group_rel
(
    id            int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id     int(11)    NOT NULL COMMENT '租户id',
    project_id    int(11)    NOT NULL COMMENT '项目id',
    user_group_id int(11)    NOT NULL COMMENT '分组id',
    user_id       int(11)    NOT NULL COMMENT '用户id',
    create_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at     datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by     int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by     int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted    tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='用户分组-用户id关联表';

CREATE TABLE dl_table_sync
(
    id                            int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id                     int(11)    NOT NULL COMMENT '租户id',
    project_id                    int(11)    NOT NULL COMMENT '项目id',
    entity_id                     int(11)    NOT NULL COMMENT '实体id',
    group_id                      int(11) COMMENT '群组字段',
    entity_partition_filed        varchar(255) COMMENT '实体分区字段',
    entity_partition_filed_format varchar(64) COMMENT '实体分区字段格式',
    entity_current_partition      varchar(255) COMMENT '实体当前分区',
    sync_type                     tinyint(1) COMMENT '同步类型 1:original 2:derived 3:combined',
    sync_table_name               varchar(255) COMMENT '同步名称',
    sync_table_name_cn            varchar(255) COMMENT '同步中文名',
    sync_table_name_desc          varchar(255) COMMENT '同步描述',
    sync_partition_filed          varchar(255) COMMENT '同步分区字段',
    sync_partition_filed_format   varchar(64) COMMENT '同步分区字段格式',
    sync_current_partition        varchar(255) COMMENT '同步当前分区',
    sync_period_type              tinyint(1) COMMENT '0:分钟 1:小时 2:天 3:星期 4:月',
    sync_week_day                 varchar(64) COMMENT '每周几',
    sync_day                      varchar(64) COMMENT '每月几号',
    sync_hour                     varchar(64) COMMENT '小时',
    sync_minute                   varchar(64) COMMENT '分钟',
    begin_date                    varchar(64) DEFAULT NULL COMMENT '开始时间',
    end_date                      varchar(64) DEFAULT NULL COMMENT '结束时间',
    begin_min                     varchar(64) DEFAULT NULL COMMENT '开始时间分钟',
    end_min                       varchar(64) DEFAULT NULL COMMENT '结束时间分钟',
    gap_min                       varchar(64) DEFAULT NULL COMMENT '间隔时间分钟',
    begin_hour                    varchar(64) DEFAULT NULL COMMENT '结束时间小时',
    end_hour                      varchar(64) DEFAULT NULL COMMENT '结束时间小时',
    gap_hour                      varchar(64) DEFAULT NULL COMMENT '结束时间小时',
    create_at                     datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at                     datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by                     int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by                     int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted                    tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='表分区同步表';

CREATE TABLE `dl_tag_task`
(
    `id`              int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`       int(11)      NOT NULL COMMENT '租户id',
    `project_id`      int(11)      NOT NULL COMMENT '项目id',
    `entity_id`       int(11)      NOT NULL COMMENT '实体id',
    `tag_group_id`    int(11)               DEFAULT NULL COMMENT '标签/群组id',
    `name`            varchar(256) NOT NULL COMMENT '任务名称',
    `tag_type`        tinyint(1)   NOT NULL COMMENT '标签类型 0 原子标签,1 衍生标签 2 群组 3组合标签',
    `task_type`       tinyint(1)   NOT NULL COMMENT '任务类型 0 sql,1 mr 2 数据同步',
    `engine_type`     tinyint(1)   NOT NULL COMMENT '执行引擎类型 0 flink, 1 spark',
    `compute_type`    tinyint(1)   NOT NULL COMMENT '计算类型 0实时，1 离线',
    `sql_text`        longtext     NOT NULL COMMENT 'sql 文本',
    `task_params`     text         NOT NULL COMMENT '任务参数',
    `schedule_conf`   varchar(2048)         DEFAULT NULL COMMENT '调度配置 json格式',
    `period_type`     tinyint(2)            DEFAULT NULL COMMENT '周期类型',
    `schedule_status` tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
    `submit_status`   tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0未提交,1已提交',
    `submit_time`     datetime     NOT NULL COMMENT '提交时间',
    `owner_user_id`   int(11)      NOT NULL COMMENT '负责人id',
    `version`         int(11)      NOT NULL DEFAULT '0' COMMENT 'task版本',
    `task_desc`       varchar(256)          DEFAULT NULL,
    `main_class`      varchar(256) NOT NULL,
    `exe_args`        text,
    `create_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '标签任务表';


CREATE TABLE `dl_tag_task_task`
(
    `id`                 int(11)    NOT NULL AUTO_INCREMENT,
    `entity_id`          int(11)    NOT NULL COMMENT '实体id',
    `task_id`            int(11)    NOT NULL COMMENT 'batch 任务id',
    `task_source`        int(11)             DEFAULT NULL COMMENT '任务来源',
    `parent_task_id`     int(11)             DEFAULT NULL COMMENT '对应batch任务父节点的id',
    `parent_task_source` int(11)             DEFAULT NULL COMMENT '父任务来源',
    `project_id`         int(11)    NOT NULL COMMENT '项目id',
    `tenant_id`          int(11)    NOT NULL COMMENT '租户id',
    `create_at`          datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`          datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`          int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`          int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`         tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_batch_task_task` (`project_id`, `parent_task_id`, `task_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 535
  DEFAULT CHARSET = utf8;

CREATE TABLE `dl_tag_task_version`
(
    `id`              int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`       int(11)      NOT NULL COMMENT '租户id',
    `project_id`      int(11)      NOT NULL COMMENT '项目id',
    `task_id`         int(11)      NOT NULL COMMENT '父文件夹id',
    `origin_sql`      longtext COMMENT '原始sql',
    `sql_text`        longtext     NOT NULL COMMENT 'sql 文本',
    `publish_desc`    text         NOT NULL COMMENT '任务参数',
    `version`         int(11)      NOT NULL DEFAULT '0' COMMENT 'task版本',
    `task_params`     text         NOT NULL COMMENT '任务参数',
    `schedule_conf`   varchar(512) NOT NULL COMMENT '调度配置 json格式',
    `schedule_status` tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
    `create_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '标签任务版本表';

CREATE TABLE `dl_tag_schedule_record`
(
    `id`                 int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `entity_id`          int(11)    NOT NULL COMMENT '实体id',
    `group_id`           int(11)             DEFAULT NULL COMMENT '群组字段',
    `schedule_type`      tinyint(4)          DEFAULT NULL COMMENT '跑批类型 0:原子 1:衍生 2:圈群 3:组合',
    `last_schedule_time` datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上一次调度时间',
    `create_at`          datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`          datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`          int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`          int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`         tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='定时任务记录';

-- 任务调度表

CREATE TABLE `dt_center_cron_schedule`
(
    `id`                int(11)      NOT NULL AUTO_INCREMENT,
    `job_detail_name`   varchar(255) NOT NULL COMMENT 'job名称',
    `job_detail_group`  varchar(255) NOT NULL COMMENT 'job group 名称',
    `job_trigger_name`  varchar(255) NOT NULL COMMENT 'job trigger 名称',
    `job_trigger_group` varchar(255) NOT NULL COMMENT 'job trigger group 名称',
    `class_name`        varchar(255) NOT NULL COMMENT '任务执行类名称',
    `cron`              varchar(255) NOT NULL COMMENT 'cron 表达式',
    `concurrent`        tinyint(1)   NOT NULL COMMENT '0: false, 1:true',
    `start_time`        datetime COMMENT '开始时间',
    `end_time`          datetime COMMENT '结束时间',
    `biz_type`          VARCHAR(255) NOT NULL COMMENT '任务业务类型',
    `gmt_create`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_job_name` (`job_detail_name`, `job_detail_group`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- quartz自带表

CREATE TABLE QRTZ_JOB_DETAILS
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    JOB_NAME          VARCHAR(200) NOT NULL,
    JOB_GROUP         VARCHAR(200) NOT NULL,
    DESCRIPTION       VARCHAR(250) NULL,
    JOB_CLASS_NAME    VARCHAR(250) NOT NULL,
    IS_DURABLE        VARCHAR(1)   NOT NULL,
    IS_NONCONCURRENT  VARCHAR(1)   NOT NULL,
    IS_UPDATE_DATA    VARCHAR(1)   NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1)   NOT NULL,
    JOB_DATA          BLOB         NULL,
    PRIMARY KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_TRIGGERS
(
    SCHED_NAME     VARCHAR(120) NOT NULL,
    TRIGGER_NAME   VARCHAR(200) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL,
    JOB_NAME       VARCHAR(200) NOT NULL,
    JOB_GROUP      VARCHAR(200) NOT NULL,
    DESCRIPTION    VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13)   NULL,
    PREV_FIRE_TIME BIGINT(13)   NULL,
    PRIORITY       INTEGER      NULL,
    TRIGGER_STATE  VARCHAR(16)  NOT NULL,
    TRIGGER_TYPE   VARCHAR(8)   NOT NULL,
    START_TIME     BIGINT(13)   NOT NULL,
    END_TIME       BIGINT(13)   NULL,
    CALENDAR_NAME  VARCHAR(200) NULL,
    MISFIRE_INSTR  SMALLINT(2)  NULL,
    JOB_DATA       BLOB         NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(200) NOT NULL,
    TRIGGER_GROUP   VARCHAR(200) NOT NULL,
    REPEAT_COUNT    BIGINT(7)    NOT NULL,
    REPEAT_INTERVAL BIGINT(12)   NOT NULL,
    TIMES_TRIGGERED BIGINT(10)   NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(200) NOT NULL,
    TRIGGER_GROUP   VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(120) NOT NULL,
    TIME_ZONE_ID    VARCHAR(80),
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    VARCHAR(120)   NOT NULL,
    TRIGGER_NAME  VARCHAR(200)   NOT NULL,
    TRIGGER_GROUP VARCHAR(200)   NOT NULL,
    STR_PROP_1    VARCHAR(512)   NULL,
    STR_PROP_2    VARCHAR(512)   NULL,
    STR_PROP_3    VARCHAR(512)   NULL,
    INT_PROP_1    INT            NULL,
    INT_PROP_2    INT            NULL,
    LONG_PROP_1   BIGINT         NULL,
    LONG_PROP_2   BIGINT         NULL,
    DEC_PROP_1    NUMERIC(13, 4) NULL,
    DEC_PROP_2    NUMERIC(13, 4) NULL,
    BOOL_PROP_1   VARCHAR(1)     NULL,
    BOOL_PROP_2   VARCHAR(1)     NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    TRIGGER_NAME  VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA     BLOB         NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    INDEX (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_CALENDARS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    CALENDAR_NAME VARCHAR(200) NOT NULL,
    CALENDAR      BLOB         NOT NULL,
    PRIMARY KEY (SCHED_NAME, CALENDAR_NAME)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    ENTRY_ID          VARCHAR(95)  NOT NULL,
    TRIGGER_NAME      VARCHAR(200) NOT NULL,
    TRIGGER_GROUP     VARCHAR(200) NOT NULL,
    INSTANCE_NAME     VARCHAR(200) NOT NULL,
    FIRED_TIME        BIGINT(13)   NOT NULL,
    SCHED_TIME        BIGINT(13)   NOT NULL,
    PRIORITY          INTEGER      NOT NULL,
    STATE             VARCHAR(16)  NOT NULL,
    JOB_NAME          VARCHAR(200) NULL,
    JOB_GROUP         VARCHAR(200) NULL,
    IS_NONCONCURRENT  VARCHAR(1)   NULL,
    REQUESTS_RECOVERY VARCHAR(1)   NULL,
    PRIMARY KEY (SCHED_NAME, ENTRY_ID)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    INSTANCE_NAME     VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13)   NOT NULL,
    CHECKIN_INTERVAL  BIGINT(13)   NOT NULL,
    PRIMARY KEY (SCHED_NAME, INSTANCE_NAME)
) ENGINE = InnoDB;

CREATE TABLE QRTZ_LOCKS
(
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40)  NOT NULL,
    PRIMARY KEY (SCHED_NAME, LOCK_NAME)
) ENGINE = InnoDB;

CREATE
    INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS (SCHED_NAME, REQUESTS_RECOVERY);
CREATE
    INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS (SCHED_NAME, JOB_GROUP);

CREATE
    INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);
CREATE
    INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS (SCHED_NAME, JOB_GROUP);
CREATE
    INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS (SCHED_NAME, CALENDAR_NAME);
CREATE
    INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);
CREATE
    INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE);
CREATE
    INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);
CREATE
    INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);
CREATE
    INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS (SCHED_NAME, NEXT_FIRE_TIME);
CREATE
    INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);
CREATE
    INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);
CREATE
    INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);
CREATE
    INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP,
                                                          TRIGGER_STATE);

CREATE
    INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME);
CREATE
    INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);
CREATE
    INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);
CREATE
    INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_GROUP);
CREATE
    INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
CREATE
    INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);


CREATE TABLE `dl_group_count`
(
    `id`                   int(11)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `entity_id`            int(11)    NOT NULL COMMENT '实体id',
    `group_id`             int(11)    NOT NULL COMMENT '群组id',
    `group_num`            int(11)    NOT NULL COMMENT '群组覆盖实例数',
    `sync_period_type`     int(11)    NOT NULL COMMENT '0:分钟 1:小时 2:天 3:星期 4:月',
    `compute_time`         datetime   NOT NULL COMMENT '计算时间',
    `business_time`        datetime   NOT NULL COMMENT '最近分区时间',
    `business_format_time` varchar(64) COLLATE utf8_bin DEFAULT NULL,
    `create_at`            datetime   NOT NULL          DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`            datetime   NOT NULL          DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`           tinyint(1) NOT NULL          DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin COMMENT ='群组覆盖实例表';

CREATE TABLE `dl_tag_value_data_count`
(
    `id`                   int(11)               NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `tenant_id`            int(11)                        DEFAULT NULL COMMENT '租户id',
    `entity_id`            int(11)               NOT NULL COMMENT '实体id',
    `tag_id`               int(11)               NOT NULL COMMENT '标签id',
    `tag_value_json`       text COLLATE utf8_bin NOT NULL COMMENT '标签json',
    `un_cover`             int(11)               NOT NULL DEFAULT '0' COMMENT '未覆盖实例数',
    `entity_total`         int(11)               NOT NULL COMMENT '实例总量',
    `compute_time`         datetime              NOT NULL COMMENT '计算时间',
    `business_time`        datetime                       DEFAULT NULL COMMENT '业务日期',
    `business_week_time`   datetime                       DEFAULT NULL COMMENT '周的业务日期，需要特殊处理',
    `business_format_time` varchar(64) COLLATE utf8_bin   DEFAULT NULL COMMENT '业务格式化日期',
    `current_partition`    varchar(256) COLLATE utf8_bin  DEFAULT NULL COMMENT '当前数据分区',
    `sync_period_type`     tinyint(1)                     DEFAULT NULL COMMENT '0:分钟 1:小时 2:天 3:星期 4:月',
    `create_at`            datetime              NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`            datetime              NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `update_by`            int(11)                        DEFAULT '0' COMMENT 'update_by',
    `create_by`            int(11)                        DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`           tinyint(1)            NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标签值覆盖量';


CREATE TABLE `dl_tag_publish_count`
(
    `id`                int(11)  NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `entity_id`         int(11)  NOT NULL COMMENT '实体id',
    `tag_publish_count` int(11)  NOT NULL COMMENT '发布数量',
    `bussiness_time`    datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '业务时间',
    `tenant_id`         int(11)  NOT NULL COMMENT '租户id',
    `create_at`         datetime          DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`         datetime          DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`         int(11)           DEFAULT '0' COMMENT '创建的用户',
    `update_by`         int(11)           DEFAULT '0' COMMENT '更新的用户',
    `is_deleted`        tinyint(4)        DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `dl_tag_version`
(
    `id`               int(11) AUTO_INCREMENT COMMENT '主键id',
    `tenant_id`        int(11)                              NOT NULL COMMENT '租户id',
    `project_id`       int(11)                              NOT NULL COMMENT '项目id',
    `entity_id`        int(11)                              NOT NULL COMMENT '实体id',
    `tag_publish_id`   int(11)                              NOT NULL COMMENT '发布的标签id',
    `version`          int        default 0                 NOT NULL COMMENT '版本号',
    `version_format`   varchar(128)                         NOT NULL COMMENT '标签版本格式化',
    `tag_name`         varchar(256)                         NOT NULL COMMENT '标签名称',
    `tag_identifier`   varchar(256)                         NOT NULL COMMENT '标签英文名',
    `tag_rule_sql`     longtext                             NULL COMMENT '标签规则',
    `tag_base_info`    text                                 NULL COMMENT '标签基本信息',
    `tag_publish_info` text                                 NULL COMMENT '标签发布信息',
    `create_at`        datetime   default CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    `update_at`        datetime   default CURRENT_TIMESTAMP NOT NULL COMMENT '修改时间',
    `create_by`        int(11)    default 0                 NOT NULL COMMENT '发布人',
    `update_by`        int(11)    default 0                 NOT NULL COMMENT '修改人',
    `is_deleted`       tinyint(1) default 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '标签版本管理';


CREATE TABLE `dl_statistics_cycle`
(
    `id`         int(11)      NOT NULL AUTO_INCREMENT,
    `project_id` int(11)      NOT NULL COMMENT '项目id',
    `cycle_name` varchar(128) NOT NULL COMMENT '周期名称',
    `cycle_desc` varchar(512) NOT NULL COMMENT '周期描述',
    `start_time` varchar(128)          DEFAULT NULL COMMENT '开始时间',
    `end_time`   varchar(128)          DEFAULT NULL COMMENT '结束时间',
    `create_at`  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`  int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `is_custom`  tinyint(1)   NOT NULL DEFAULT '0',
    `tenant_id`  int(11)      NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
) CHARACTER SET = utf8
    COMMENT '统计周期'
  ENGINE = InnoDB
  AUTO_INCREMENT = 1;

CREATE TABLE `dl_tag_expand`
(
    `id`                  int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`           int(11)    NOT NULL COMMENT '租户id',
    `project_id`          int(11)    NOT NULL COMMENT '项目id',
    `tag_id`              int(11)             DEFAULT NULL COMMENT '标签id',
    `cycle_id`            int(11)             DEFAULT NULL COMMENT '统计周期id',
    `is_identify`         int(1)              DEFAULT NULL,
    `entity_id`           int(11)    NOT NULL,
    `statistics_filed_id` int(11)             DEFAULT NULL COMMENT '时间字段id',
    `filter_exp`          text COMMENT '过滤字段值',
    `create_at`           datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`           datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`           int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`           int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`          tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 9819
  DEFAULT CHARSET = utf8 COMMENT ='标签拓展表';

CREATE TABLE `dl_tag_tagsql_temp`
(
    `id`         int(11)  NOT NULL AUTO_INCREMENT,
    `job_id`     varchar(11)  DEFAULT NULL COMMENT '任务id',
    `table_name` varchar(255) DEFAULT NULL COMMENT '临时表表名',
    `tagsql`     Text NULL COMMENT '自定义sql',
    `entity_id`  int(11)      DEFAULT NULL COMMENT '实体名称',
    `create_at`  datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    `update_at`  datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    `project_id` int(11)      DEFAULT NULL,
    `is_deleted` int(255)     DEFAULT '0' COMMENT '临时表删除标记',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sql加工中sql日志的临时表';

CREATE TABLE dl_tag_temp_table
(
    `id`              int(11)      NOT NULL AUTO_INCREMENT,
    `project_id`      int(11)      NOT NULL COMMENT '项目id',
    `tenant_id`       int(11)      NOT NULL COMMENT '租户id',
    `entity_id`       int(11)      NULL COMMENT '实体id(冗余字段)',
    `group_id`        int(11)      NULL COMMENT '群组id',
    `task_id`         varchar(128) NULL COMMENT '任务id(冗余字段)',
    `temp_table_name` varchar(255) NOT NULL COMMENT '临时表表名',
    `create_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 9819
  DEFAULT CHARSET = utf8 COMMENT ='标签临时表';

CREATE TABLE `dl_portrayal_template`
(
    `id`         Int(11) AUTO_INCREMENT NOT NULL,
    `tenant_id`  Int(11)                NOT NULL COMMENT '租户id',
    `entity_id`  Int(11)                NOT NULL COMMENT '实体Id',
    `project_id` Int(11)                NOT NULL COMMENT '项目id',
    `tag_id`     Int(11)                NOT NULL COMMENT '项目id',
    `composing`  TinyInt(1)             NOT NULL COMMENT '排版 0-横向 1-纵向',
    `site`       Int(11)                NULL COMMENT '位置',
    `create_at`  DateTime               NOT NULL                             DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`  DateTime               NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`  Int(11)                NOT NULL                             DEFAULT '0' COMMENT '创建的用户',
    `update_by`  Int(11)                NOT NULL                             DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` TinyInt(1)             NOT NULL                             DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) CHARACTER SET = utf8
  COLLATE = utf8_general_ci
    COMMENT '画像模板表'
  ENGINE = InnoDB
  AUTO_INCREMENT = 1;

CREATE TABLE `dl_task_temp_job`
(
    `id`              int(11)                              NOT NULL AUTO_INCREMENT,
    `tenant_id`       int(11)                              NOT NULL COMMENT '租户id',
    `project_id`      int(11)                              NOT NULL COMMENT '项目id',
    `entity_id`       int(11)                              NOT NULL COMMENT '实体id',
    `task_id`         int(11)                              NOT NULL COMMENT '任务id',
    `job_id`          varchar(255)                         NULL COMMENT '调度jobId',
    `partition_value` varchar(255)                         NULL COMMENT '分区值',
    `fill_task_name`  varchar(255)                         NULL COMMENT '补数据的调度任务名',
    `type`            int(11)                              NOT NULL COMMENT '调度类型,0:补数据，1:临时',
    `create_at`       datetime   default CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    `update_at`       datetime   default CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`       int(11)    default 0                 NOT NULL comment '创建的用户',
    `update_by`       int(11)    default 0                 NOT NULL COMMENT '修改的用户',
    `is_deleted`      tinyint(1) default 0                 NOT NULL COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='临时任务表';

CREATE TABLE `dl_tag_tagsql`
(
    `id`                 int(11) NOT NULL AUTO_INCREMENT,
    `tagsql`             text COMMENT '自定义sql',
    `entity_id`          int(11)      DEFAULT NULL COMMENT '实体id',
    `temp_table_id`      varchar(255) DEFAULT NULL COMMENT '临时表id',
    `is_delete`          int(255)     DEFAULT NULL,
    `annotate_tagsql`    text COMMENT '含有注释的sql',
    `primary_key`        text,
    `primary_table_name` varchar(255) DEFAULT NULL COMMENT '需要关联的表',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sql加工产生的sql';


CREATE TABLE `dl_tag_sys_parameter`
(
    `id`            int(11)     NOT NULL AUTO_INCREMENT,
    `param_name`    varchar(64) NOT NULL COMMENT '参数名称',
    `param_command` varchar(64) NOT NULL COMMENT '参数替换指令',
    `gmt_create`    datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`    tinyint(1)  NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sql中的时间参数';


CREATE TABLE `dl_group_tag_value_proportion`
(
    `id`                        Int(11) AUTO_INCREMENT                                  NOT NULL COMMENT '自增id',
    `project_id`                Int(11)                                                 NOT NULL COMMENT '项目id',
    `tenant_id`                 Int(11)                                                 NULL COMMENT '租户id',
    `entity_id`                 Int(11)                                                 NOT NULL COMMENT '实体id',
    `tag_id`                    Int(11)                                                 NOT NULL COMMENT '标签id',
    `group_id`                  Int(11)                                                 NOT NULL COMMENT '群组id',
    `tag_value_json_group`      Text CHARACTER SET utf8 COLLATE utf8_bin                NULL COMMENT '群组标签值',
    `tag_value_json`            Text CHARACTER SET utf8 COLLATE utf8_bin                NULL COMMENT '大宽表标签值',
    `high_proportion_tag_value` VarChar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '高占比标签值',
    `tgi_value`                 int(11)                                                          DEFAULT 0 NULL COMMENT 'tgi比值，为了保证精度等问题不采用小数方式存储，而是value * 100的方式存储',
    `group_count`               Int(11)                                                 NULL COMMENT '群组数据总量',
    `all_count`                 Int(11)                                                 NULL COMMENT '大宽表数据总量',
    `memo`                      VarChar(255) CHARACTER SET utf8 COLLATE utf8_bin        NULL,
    `create_at`                 DateTime                                                NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`                 DateTime                                                NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `update_by`                 Int(11)                                                 NULL     DEFAULT '0' COMMENT 'update_by',
    `create_by`                 Int(11)                                                 NULL     DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`                TinyInt(1)                                              NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) CHARACTER SET = utf8
    COMMENT '群组显著性特征分析'
  ENGINE = InnoDB
  AUTO_INCREMENT = 1;


CREATE TABLE dl_group_portrait_dimension
(
    id         int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    project_id int(11)    NOT NULL COMMENT '项目id',
    entity_id  int(11)    NOT NULL COMMENT '实体id',
    group_id   int(11)    NULL COMMENT '群组id',
    tag_id     int(11)    NOT NULL COMMENT '标签id',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='群组画像维度';


