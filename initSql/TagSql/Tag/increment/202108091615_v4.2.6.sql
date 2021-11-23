CREATE TABLE `dl_tag_row_level_permissions`
(
    `id`                            int(11) NOT NULL AUTO_INCREMENT,
    `tenant_id`                     int(11) NOT NULL COMMENT '租户id',
    `project_id`                    int(11) NOT NULL COMMENT '项目id',
    `entity_id`                     int(11) NOT NULL COMMENT 'entity id',
    `tag_row_level_permission_name` varchar(64) NOT NULL COMMENT '权限名称',
    `tag_id`                        int(11) NOT NULL COMMENT '标签id',
    `is_open`                       tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启,0：关闭，1：开启',
    `exp`                           text COMMENT '衍生表达式',
    `create_at`                     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`                     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`                     int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`                     int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `is_deleted`                    tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='行级权限';


CREATE TABLE `dl_tag_row_level_permission_use_rel`
(
    `id`                 int(11) NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11) NOT NULL COMMENT '租户id',
    `project_id`         int(11) NOT NULL COMMENT '项目id',
    `entity_id`          int(11) NOT NULL COMMENT '实体id',
    `row_permissions_id` int(11) NOT NULL COMMENT '行级权限id',
    `relation_id`        int(11) NOT NULL COMMENT '关联用户id',
    `relation_type`      int(11) NOT NULL COMMENT '关联类型 0:用户 1:用户组 ',
    `create_at`          datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`          datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`          int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`          int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `is_deleted`         tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='行级权限映射表';


ALTER TABLE dl_tag_apply ADD COLUMN tag_auth_type tinyint(1) default 0 not null comment '标签读写权限类型 0-读，1-写';
ALTER TABLE dl_tag_apply ADD COLUMN tag_auth_approve_type tinyint(1) DEFAULT NULL comment '标签写权限申请类型 0-发布，1-下线，2-编辑';
ALTER TABLE dl_tag_apply ADD COLUMN apply_param longtext DEFAULT NULL comment '暂存申请参数';
update dl_tag_apply set tag_auth_type = 0;


INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 51, NOW(), NOW(), 0, 0, 0
from dl_role where
        dl_role.id not in (select role_id from dl_role_permission
                           where permission_id = 51) and role_value in (4, 6);