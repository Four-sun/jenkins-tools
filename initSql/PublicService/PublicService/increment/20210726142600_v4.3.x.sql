-- 角色表
CREATE TABLE if not exists `auth_role` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `old_role_id` int(11) DEFAULT '0' COMMENT '平台迁移过来的角色id',
    `app_type` int(11) NOT NULL DEFAULT '0' COMMENT '应用类型',
    `dtuic_tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
    `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
    `role_name` varchar(256) NOT NULL COMMENT '角色名称',
    `role_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
    `role_value` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), PROJECTOWNER(2), PROJECTADMIN(3), MEMBER(4), OPERATION(5), DATADEVELOP(6)',
    `role_desc` varchar(256) NOT NULL DEFAULT '' COMMENT '角色描述',
    `modify_user_id` int(11) COMMENT '修改的用户',
    `create_user_id` int(11) COMMENT '创建的用户',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- 角色权限关联表
CREATE TABLE  if not exists `auth_role_permission` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `app_type` int(11) NOT NULL DEFAULT '0' COMMENT '应用类型',
    `role_id` int(11) unsigned NOT NULL COMMENT '关联角色id',
    `permission_id` int(11) unsigned NOT NULL COMMENT '关联权限id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `modify_user_id` int(11) DEFAULT NULL COMMENT '修改的用户',
    `create_user_id` int(11) DEFAULT NULL COMMENT '创建的用户',
    `dtuic_tenant_id` int(11) DEFAULT NULL COMMENT '角色所属租户id,0:基础角色',
    `project_id` int(11) DEFAULT NULL COMMENT '项目id',
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_role_permission` (`app_type`,`role_id`,`permission_id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

-- 角色用户关联表
CREATE TABLE if not exists `auth_role_user` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `app_type` int(11) NOT NULL DEFAULT '0' COMMENT '应用类型',
    `dtuic_tenant_id` int(11) NOT NULL COMMENT '租户id',
    `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
    `role_id` int(11) NOT NULL COMMENT '角色id',
    `dtuic_user_id` int(11) NOT NULL COMMENT '用户id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `modify_user_id` int(11) COMMENT '修改的用户',
    `create_user_id` int(11) COMMENT '创建的用户',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_project_user_role` (`project_id`,`dtuic_user_id`,`role_id`,`app_type`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

-- 项目表
CREATE TABLE if not exists `auth_project` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
    `dtuic_tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT 'uic租户id',
    `app_type` int(11) NOT NULL DEFAULT '0' COMMENT '应用类型',
    `project_name` varchar(128) NOT NULL DEFAULT '' COMMENT '项目名',
    `project_alias` varchar(512) NOT NULL DEFAULT '' COMMENT '项目中文名',
    `project_Identifier` varchar(256) DEFAULT '' COMMENT '项目标识',
    `project_desc` varchar(2048) DEFAULT '' COMMENT '项目描述',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
    `create_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '新建项目的用户id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除，0未删除 1删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_project_id` (`project_id`,`app_type`),
    KEY `index_uic_tenant_id_and_app_type` (`dtuic_tenant_id`,`app_type`,`project_alias`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='项目表';

-- 权限表
CREATE TABLE if not exists `auth_permission` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `old_permission_id` int(11) DEFAULT 0 COMMENT '平台迁移过来的权限id',
    `app_type` int(11) DEFAULT 0 COMMENT '应用类型',
    `code` varchar(256) NOT NULL DEFAULT '' COMMENT '权限CODE',
    `name` varchar(256) DEFAULT NULL COMMENT '权限名',
    `display` varchar(256) DEFAULT NULL COMMENT '展示名称',
    `parent_id` int(11) DEFAULT NULL COMMENT '父权限id',
    `type` tinyint(1) DEFAULT '1' COMMENT '1:功能权限;2:数据权限',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='权限表';
