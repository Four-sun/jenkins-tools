CREATE TABLE `science_package`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `tenant_id`       int(11) NOT NULL COMMENT '租户 id',
    `project_id`      int(11) NOT NULL COMMENT '项目 id',
    `name`            varchar(200) NOT NULL COMMENT '包名称',
    `comment`         varchar(500) NOT NULL COMMENT '描述',
    `package_type`    int(11) NOT NULL COMMENT '导入：0，导出：1',
    `path`            varchar(500)          DEFAULT NULL COMMENT 'sftp 路径',
    `publish_user_id` int(11) DEFAULT NULL COMMENT '发布用户',
    `package_status` int(11) DEFAULT NULL COMMENT '打包状态：打包中：0，打包成功：1，  打包失败：2',
    `log`             text COMMENT '失败日志',
    `create_user_id`  int(11) NOT NULL COMMENT '创建用户',
    `modify_user_id`  int(11) NOT NULL COMMENT '修改用户',
    `gmt_create`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
    `gmt_modified`    datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
    `is_deleted`      tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `publish_time`    datetime              DEFAULT NULL COMMENT '发布时间',
    `publish_status`  int(11) DEFAULT NULL COMMENT '发布状态：上传中：0，待发布：1， 上传失败：2，发布中：3，发布成功：4，发布失败：5',
    PRIMARY KEY (`id`),
    KEY               `idx` (`tenant_id`,`project_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务发布包';

CREATE TABLE `science_package_item`
(
    `id`             int(11) NOT NULL AUTO_INCREMENT,
    `name`           varchar(255)      DEFAULT NULL COMMENT '名称',
    `tenant_id`      int(11) NOT NULL COMMENT '租户id',
    `project_id`     int(11) NOT NULL COMMENT '项目id',
    `package_id`     int(11) NOT NULL COMMENT '发布包id',
    `target_id`      int(11) DEFAULT NULL COMMENT '目标 id',
    `target_type`    tinyint(1) DEFAULT NULL COMMENT '目标类型',
    `type`           tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，任务：0，资源：1，表：2',
    `publish_param`  text COMMENT '发布参数,json格式',
    `gmt_create`     datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
    `gmt_modified`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
    `is_deleted`     tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `publish_status` int(11) DEFAULT NULL COMMENT '0待发布1成功2失败',
    `log`            text COMMENT '失败日志',
    `create_user_id` int(11) NOT NULL COMMENT '创建用户',
    `modify_user_id` int(11) NOT NULL COMMENT '修改用户',
    PRIMARY KEY (`id`) USING BTREE,
    KEY              `idx_pkg_id` (`package_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发布包资源';