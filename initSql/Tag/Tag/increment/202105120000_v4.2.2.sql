CREATE TABLE `dl_portrayal_template`
(
    `id`         Int( 11 ) AUTO_INCREMENT NOT NULL,
    `tenant_id`  Int( 11 ) NOT NULL COMMENT '租户id',
    `entity_id`  Int( 11 ) NOT NULL COMMENT '实体Id',
    `project_id` Int( 11 ) NOT NULL COMMENT '项目id',
    `tag_id`     Int( 11 ) NOT NULL COMMENT '项目id',
    `composing`  TinyInt( 1 ) NOT NULL COMMENT '排版 0-横向 1-纵向',
    `site`       Int( 11 ) NULL COMMENT '位置',
    `create_at`  DateTime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`  DateTime NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`  Int( 11 ) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`  Int( 11 ) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted` TinyInt( 1 ) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT '画像模板表'
ENGINE = InnoDB
AUTO_INCREMENT = 1;