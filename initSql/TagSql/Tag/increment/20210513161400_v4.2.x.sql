ALTER TABLE dl_tag_value_data_count
    ADD current_partition varchar(256) NULL COMMENT '当前数据分区';

ALTER TABLE dl_group
    ADD high_proportion_analyse_time datetime DEFAULT NULL COMMENT '最近一次当前群组显著性分析时间';

ALTER TABLE dl_group
    ADD high_proportion_analyse_status TINYINT(1) DEFAULT 0 NOT NULL COMMENT '当前群组显著性特征分析状态 0-未分析，1-分析中，2-已分析';

CREATE TABLE `dl_group_tag_value_proportion`
(
    `id`                        Int( 11 ) AUTO_INCREMENT NOT NULL COMMENT '自增id',
    `project_id`                Int( 11 ) NOT NULL COMMENT '项目id',
    `tenant_id`                 Int( 11 ) NULL COMMENT '租户id',
    `entity_id`                 Int( 11 ) NOT NULL COMMENT '实体id',
    `tag_id`                    Int( 11 ) NOT NULL COMMENT '标签id',
    `group_id`                  Int( 11 ) NOT NULL COMMENT '群组id',
    `tag_value_json_group`      Text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '群组标签值',
    `tag_value_json`            Text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '大宽表标签值',
    `high_proportion_tag_value` VarChar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '高占比标签值',
    `tgi_value`                 int(11) DEFAULT 0 NULL COMMENT 'tgi比值，为了保证精度等问题不采用小数方式存储，而是value * 100的方式存储',
    `group_count`               Int( 11 ) NULL COMMENT '群组数据总量',
    `all_count`                 Int( 11 ) NULL COMMENT '大宽表数据总量',
    `memo`                      VarChar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL,
    `create_at`                 DateTime                                                NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`                 DateTime                                                NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `update_by`                 Int( 11 ) NULL DEFAULT '0' COMMENT 'update_by',
    `create_by`                 Int( 11 ) NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`                TinyInt( 1 ) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) CHARACTER SET = utf8
COMMENT '群组显著性特征分析'
ENGINE = InnoDB
AUTO_INCREMENT = 1;