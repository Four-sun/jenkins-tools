CREATE TABLE `da_row_permission`
(
    `id`                  int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`           int(11)      NOT NULL COMMENT '租户ID',
    `project_id`          int(11)      NOT NULL COMMENT '项目id',
    `row_permission_name` VARCHAR(256) NOT NULL COMMENT '权限标示',
    `modify_user_id`      int(11)      NOT NULL COMMENT '最近修改人id',
    `gmt_create`          datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`          tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='行级权限表';

CREATE TABLE `da_row_permission_user_rel`
(
    `id`                 int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)    NOT NULL COMMENT '租户ID',
    `project_id`         int(11)    NOT NULL COMMENT '项目id',
    `user_id`            int(11)    NOT NULL COMMENT '数据API的用户ID',
    `row_permission_id`  int(11)    NOT NULL COMMENT '行级权限ID',
    `row_permission_val` text       NOT NULL COMMENT '行级权限值',
    `data_type`          int(11)             DEFAULT NULL COMMENT '展示用-数据源类型',
    `data_source_id`     int(11)             DEFAULT NULL COMMENT '展示用-数据源ID',
    `table_name`         VARCHAR(256)        DEFAULT NULL COMMENT '展示用-数据源表名',
    `table_column`       VARCHAR(256)        DEFAULT NULL COMMENT '展示用-数据源字段名',
    `modify_user_id`     int(11)    NOT NULL COMMENT '最近修改人id',
    `gmt_create`         datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='行级权限用户关联表';

CREATE TABLE `da_row_permission_api_rel`
(
    `id`                int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`         int(11)    NOT NULL COMMENT '租户ID',
    `project_id`        int(11)    NOT NULL COMMENT '项目id',
    `api_id`            int(11)    NOT NULL COMMENT '数据APIID',
    `row_permission_id` int(11)    NOT NULL COMMENT '行级权限ID',
    `modify_user_id`    int(11)    NOT NULL COMMENT '最近修改人id',
    `gmt_create`        datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`      datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`        tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='行级权限API关联表';