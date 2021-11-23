CREATE TABLE `dl_third_table_create_log`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT,
    `tenant_id`        int(11) NOT NULL COMMENT '租户id',
    `project_id`       int(11) NOT NULL COMMENT '项目id',
    `entity_id`        int(11) NOT NULL COMMENT '实体Id',
    `c_table_name`     varchar(512) NOT NULL COMMENT '三方数据库表名',
    `data_source_type` tinyint(1) NOT NULL COMMENT '数据库类型',
    `create_at`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`        int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`        int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`       tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '三方数据库创表记录';