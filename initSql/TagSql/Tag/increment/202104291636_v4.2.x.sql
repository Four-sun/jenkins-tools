CREATE TABLE `dl_tag_version`
(
    `id`                 int(11) AUTO_INCREMENT COMMENT '主键id',
    `tenant_id`          int(11)                                  NOT NULL COMMENT '租户id',
    `project_id`         int(11)                                  NOT NULL COMMENT '项目id',
    `entity_id`          int(11)                                  NOT NULL COMMENT '实体id',
    `tag_publish_id`     int(11)                                  NOT NULL COMMENT '发布的标签id',
    `version`            int        default 0                     NOT NULL COMMENT '版本号',
    `version_format`     varchar(128)                             NOT NULL COMMENT '标签版本格式化',
    `tag_name`           varchar(256)                             NOT NULL COMMENT '标签名称',
    `tag_identifier`     varchar(256)                             NOT NULL COMMENT '标签英文名',
    `tag_rule_sql`       longtext                                 NULL COMMENT '标签规则',
    `tag_base_info`      text                                     NULL COMMENT '标签基本信息',
    `tag_publish_info`   text                                     NULL COMMENT '标签发布信息',
    `create_at`          datetime   default CURRENT_TIMESTAMP     NOT NULL COMMENT '创建时间',
    `update_at`          datetime   default CURRENT_TIMESTAMP     NOT NULL COMMENT '修改时间',
    `create_by`          int(11)        default 0                 NOT NULL COMMENT '发布人',
    `update_by`          int(11)        default 0                 NOT NULL COMMENT '修改人',
    `is_deleted`         tinyint(1) default 0                     NOT NULL COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '标签版本管理';