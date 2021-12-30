-- 用户表
CREATE TABLE ps_user (
    `id` int (11) UNSIGNED auto_increment PRIMARY KEY,
  	`gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` int(11) DEFAULT '0',
    `modify_user_id` int(11) DEFAULT '0',
  	`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `dtuic_user_id` BIGINT (20) UNSIGNED NOT NULL COMMENT 'dtuic userid',
    `user_name` VARCHAR (100) NOT NULL COMMENT '用户名称',
    `user_email` VARCHAR (100) NULL COMMENT '用户邮箱',
    `user_status` TINYINT (1) DEFAULT '0' NOT NULL COMMENT '用户状态0：正常，1：禁用',
    `phone_number` VARCHAR (100) NULL COMMENT '用户手机号'
) COMMENT '用户表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 租户表
CREATE TABLE ps_tenant (
  `id` int (11) UNSIGNED auto_increment PRIMARY KEY,
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` int(11) DEFAULT '0',
  `modify_user_id` int(11) DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `dtuic_tenant_id` BIGINT (20) UNSIGNED NOT NULL COMMENT 'dtuic的租户id',
  `tenant_name` VARCHAR (100) NOT NULL COMMENT '用户名称',
  `tenant_desc` VARCHAR (255) NULL COMMENT '租户描述',
  `tenant_status` TINYINT(1) DEFAULT '0' NOT NULL COMMENT '用户状态0：正常，1：禁用',
  CONSTRAINT index_tenant_name UNIQUE (tenant_name)
) COMMENT '租户表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ps_user表添加联合唯一索引is_deleted,dtuic_user_id
ALTER TABLE `ps_user` ADD UNIQUE `dtuic_ref` USING BTREE (`is_deleted`, `dtuic_user_id`) comment '';