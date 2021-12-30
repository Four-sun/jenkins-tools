CREATE TABLE dl_group_portrait_dimension
(
    id         int(11) NOT NULL AUTO_INCREMENT,
    tenant_id  int(11) NOT NULL COMMENT '租户id',
    project_id int(11) NOT NULL COMMENT '项目id',
    entity_id  int(11) NOT NULL COMMENT '实体id',
    group_id   int(11) NULL COMMENT '群组id',
    tag_id     int(11) NOT NULL COMMENT '标签id',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='群组画像维度';

ALTER TABLE dl_group ADD UNIQUE  index_group_identifier (project_id,group_identifier);