-- 用户表
CREATE TABLE uic_user(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  username varchar(50) NOT NULL COMMENT '用户名',
  password varchar(256) COMMENT '用户登录密码（MD5）加密',
  is_active varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否已经激活,Y已激活，N未激活',
  full_name varchar(128) COMMENT '姓名',
  phone varchar(255) COMMENT '用户手机号',
  email varchar(255) COMMENT '邮箱地址',
  company varchar(128) COMMENT '用户所属公司',
  own_tenant_id int(11) unsigned NOT NULL COMMENT '创建的租户组id',
  last_login_date datetime COMMENT '最后一次登录时间',
  last_login_tenant_id int(11) unsigned  DEFAULT 0 COMMENT '最后一次登录时的租户id',
  source int(11) DEFAULT 0 COMMENT '0:直接输入网址;1:官网;2:云日志;3:easydb;4:阿里云市场;5:已有用户在uic创建;6:微信H5',
  is_root varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是root用户,Y是，N否',
  is_admin varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是管理员,Y是，N否',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- 租户表
CREATE TABLE uic_tenant(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  tenant_name varchar(255) COMMENT '租户名称',
  tenant_desc varchar(255) COMMENT '租户描述信息',
  contact_name varchar(255) COMMENT '租户联系人姓名(默认为创建租户者)',
  contact_email varchar(255) COMMENT '租户联系邮箱(默认为租户创建者邮箱)',
  contact_phone varchar(128) COMMENT '租户联系电话(默认为租户创建者电话)',
  belong_user_id int(11) unsigned DEFAULT 0 COMMENT '租户所属用户id(当前为创建租户的用户id)',
  agent_token varchar(64) COMMENT '与agent交互时的token',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='租户表';

-- 用户-租户关联表
CREATE TABLE uic_user_tenant_rel(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  user_id int(11) unsigned NOT NULL  COMMENT '关联用户id',
  tenant_id int(11) unsigned NOT NULL  COMMENT '关联租户id',
  is_admin varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y是管理员,N普通成员',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='用户-租户租表';

-- 产品表
CREATE TABLE uic_product(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  product_code varchar(30) NOT NULL COMMENT '产品CODE',
  product_name varchar(64) NOT NULL COMMENT '产品名称',
  product_version varchar(64) NOT NULL COMMENT '产品版本',
  prodcut_release_time  datetime DEFAULT NULL COMMENT '产品发布时间',
  prodcut_desc varchar(64) COMMENT '产品描述',
  product_img_url varchar(128) COMMENT '产品图片链接地址',
  product_url varchar(128) COMMENT '产品地址',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='产品列表';

-- 用户-产品关联表
CREATE TABLE uic_user_product_rel(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  tenant_id int(11) unsigned NOT NULL  COMMENT '关联租户id',
  user_id int(11) unsigned NOT NULL COMMENT '关联用户id',
  product_code varchar(30) NOT NULL COMMENT '产品CODE',
  is_admin varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是产品管理员,Y是管理员,N普通成员',
  is_viewer varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否有产品查看权限,Y可以产看,N不能查看',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='用户-产品角色关联表';

-- v1.0.3 电信版本
alter table uic_user add column external_id varchar(50) COMMENT '外部用户id';

-- 租户-产品关联
CREATE TABLE uic_tenant_product_rel(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  tenant_id int(11) unsigned NOT NULL  COMMENT '关联租户id',
  product_code varchar(30) NOT NULL COMMENT '产品CODE',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='租户-产品关联表';

-- 创建事件表
CREATE TABLE `uic_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_code` varchar(45) DEFAULT NULL,
  `support_method` varchar(45) DEFAULT 'POST' COMMENT '支持的http方法类型，默认只支持post',
  `event_describe` varchar(200) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_code_UNIQUE` (`event_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- 创建
CREATE TABLE `uic_product_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `event_code` varchar(45) NOT NULL COMMENT '事件key',
  `callback_url` varchar(100) NOT NULL COMMENT '注册事件回调地址',
  `active` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否激活',
  `addition_key` varchar(100) DEFAULT NULL COMMENT '附加信息，比如数栈产品离线计算，流计算分别传递BATCH，STREAM',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_pid_ecode_url` (`product_id`,`event_code`,`callback_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4