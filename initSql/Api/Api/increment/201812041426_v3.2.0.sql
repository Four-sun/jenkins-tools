-- ----------------------------
-- Table structure for da_security_group
-- ----------------------------
CREATE TABLE `da_security_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL COMMENT '安全组名称',
  `ip` text COMMENT 'ip列表',
  `simple_ip_text` text COMMENT 'ip列表',
  `type` tinyint(1) NOT NULL COMMENT '安全组类型 0：白名单，1：黑名单',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for da_security_group_ref
-- ----------------------------
CREATE TABLE `da_security_group_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 删除访客部分menu权限
delete from da_role_permission where role_id = (SELECT id FROM da_role WHERE role_value = 3) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
		'api_manager_menu',
		'api_authorized_menu',
		'api_datasource_menu'
  )
);