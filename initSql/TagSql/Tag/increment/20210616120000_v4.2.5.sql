alter table dl_tag
    add datamask_id int(11) default null comment '规则id';

CREATE TABLE `dl_datamask_rule`
(
    `id`          int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`   int(11)      NOT NULL COMMENT '租户id',
    `project_id`  int(11)      NOT NULL COMMENT '项目id',
    `name`        varchar(128) NOT NULL COMMENT '名称',
    `example`     varchar(255)          DEFAULT NULL COMMENT '样例',
    `mask_type`   int(11)      NOT NULL COMMENT '脱敏效果 0-全部脱敏 1-部分脱敏',
    `replace_str` varchar(32)  NOT NULL COMMENT '替换字符',
    `begin_pos`   int(11)      NOT NULL DEFAULT '0' COMMENT '起始位置',
    `end_pos`     int(11)      NOT NULL DEFAULT '0' COMMENT '结束位置',
    `create_at`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`   int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`   int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`  tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 67
  DEFAULT CHARSET = utf8 COMMENT ='脱敏规则';

CREATE TABLE `dl_datamask_tag_group_rel`
(
    `id`          int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`   int(11)             DEFAULT NULL,
    `project_id`  int(11)    NOT NULL,
    `entity_id`   int(11)    NOT NULL,
    `tag_id`      int(11)    NOT NULL COMMENT '标签id',
    `example`     varchar(255)        DEFAULT NULL COMMENT '样例数据',
    `mask_type`   int(11)    NOT NULL COMMENT '除管理员和标签创建者进外进行脱敏0,用户组1',
    `group_id`    varchar(255)        DEFAULT NULL COMMENT '用户组id',
    `is_datamask` int(11)    NOT NULL DEFAULT '0' COMMENT '0禁用 1启用',
    `create_at`   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`   int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`   int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`  tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 157
  DEFAULT CHARSET = utf8 COMMENT ='标签与用户组关系';