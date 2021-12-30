CREATE TABLE `dl_api_call_statistic_count`
(
    `id`                int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`         int(11)      NOT NULL COMMENT '租户id',
    `project_id`        int(11)      NOT NULL COMMENT '项目id',
    `tag_api_id`        int(11)      NOT NULL COMMENT '标签apiId',
    `tag_api_type`      tinyint(1)   NOT NULL COMMENT '标签类型',
    `tag_id`            int(11)      NOT NULL COMMENT '标签 api id',
    `tag_invoke_total`  int(11)      NOT NULL COMMENT '标签 调用总理',
    `business_time`     datetime     DEFAULT NULL COMMENT '业务日期',
    `create_at`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`         int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`         int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '标签调用统计';

CREATE TABLE `dl_user_focused_tag`
(
    `id`                int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`         int(11)      NOT NULL COMMENT '租户id',
    `project_id`        int(11)      NOT NULL COMMENT '项目id',
    `uic_user_id`       int(11)      NOT NULL COMMENT '用户id',
    `tag_id`            int(11)      NOT NULL COMMENT '标签id',
    `create_at`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`         int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`         int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '关注的标签';

  CREATE TABLE `dl_api_param_rel`
(
    `id`                int(11)      NOT NULL AUTO_INCREMENT,
    `tag_api_id`        int(11)      NOT NULL COMMENT 'apiId',
    `tag_id`            int(11)      NOT NULL COMMENT '标签Id',
    `param_type`        int(11)      NOT NULL COMMENT '0输入参数 1输出参数',
    `create_at`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`         int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`         int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`        tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT 'api输入输出参数关联';