CREATE TABLE `dl_tag_tagsql_temp`
(
    `id`         int(11)  NOT NULL AUTO_INCREMENT,
    `job_id`     varchar(11)  DEFAULT NULL COMMENT '任务id',
    `table_name` varchar(255) DEFAULT NULL COMMENT '临时表表名',
    `tagsql`     Text NULL COMMENT '自定义sql',
    `entity_id`  int(11)      DEFAULT NULL COMMENT '实体名称',
    `create_at`  datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    `update_at`  datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sql加工中sql日志的临时表';

CREATE TABLE `dl_tag_tagsql`
(
    `id`        int(11) NOT NULL AUTO_INCREMENT,
    `tagsql`    varchar(255) DEFAULT NULL COMMENT '自定义sql',
    `entity_id` int(11)      DEFAULT NULL COMMENT '实体id',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sql加工产生的sql';

CREATE TABLE `dl_tag_temp_table`
(
    `id`              int(11)      NOT NULL AUTO_INCREMENT,
    `project_id`      int(11)      NOT NULL COMMENT '项目id',
    `task_id`         varchar(128)          DEFAULT NULL COMMENT '任务id(冗余字段)',
    `temp_table_name` varchar(255) NOT NULL COMMENT '临时表表名',
    `create_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`      tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `create_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`       int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `tenant_id`       int(11)      NOT NULL COMMENT '租户id',
    `entity_id`       int(11)               DEFAULT NULL COMMENT '实体id',
    `group_id`        int(11)               DEFAULT NULL COMMENT '群组id',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='存储临时表';

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


