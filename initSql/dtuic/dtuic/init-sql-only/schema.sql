-- 用户表
CREATE TABLE uic_user(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  username varchar(130) NOT NULL COMMENT '用户名',
  password varchar(256) COMMENT '用户登录密码（MD5）加密',
  is_active varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否已经激活,Y已激活，N未激活',
  full_name varchar(128) COMMENT '姓名',
  phone varchar(255) COMMENT '用户手机号',
  email varchar(255) COMMENT '邮箱地址',
  company varchar(128) COMMENT '用户所属公司',
  external_id varchar(50) COMMENT '外部用户id',
  own_tenant_id int(11) unsigned NOT NULL COMMENT '创建的租户组id',
  last_login_date datetime COMMENT '最后一次登录时间',
  last_login_tenant_id int(11) unsigned  DEFAULT 0 COMMENT '最后一次登录时的租户id',
  source int(11) DEFAULT 0 COMMENT '0:直接输入网址;1:官网;2:云日志;3:easydb;4:阿里云市场;5:已有用户在uic创建;6:微信H5',
  is_root varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是root用户,Y是，N否',
  is_admin varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是管理员,Y是，N否',
  sys_id  int(11) NOT NULL DEFAULT 1   COMMENT '系统id',
  user_time datetime DEFAULT CURRENT_TIMESTAMP COMMENT '用户有效期',
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
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='用户-产品角色关联表';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `uic_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


CREATE TABLE `uic_license` (
  `id` int(11)  NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  `custom` varchar(32) DEFAULT NULL COMMENT '客户名称',
  `serial_id` varchar(32) DEFAULT NULL COMMENT '序列号',
  `expire_at` datetime DEFAULT NULL COMMENT '到期日期',
  `license` text COMMENT 'license内容',
  `license_info` text COMMENT 'license原文',
  `type` tinyint(1) DEFAULT '0' COMMENT '0 为客户 license，1 为 license 模板',
  `target` int(11) DEFAULT NULL COMMENT 'License 指向 templateId',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='License列表';

CREATE TABLE uic_tenant_product_renew_record (
id INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
is_deleted VARCHAR ( 1 ) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
gmt_create datetime DEFAULT NULL COMMENT '创建时间',
gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
creator INT ( 11 ) DEFAULT NULL COMMENT '创建人',
modifier INT ( 11 ) DEFAULT NULL COMMENT '修改人',
tenant_id INT ( 11 ) UNSIGNED NOT NULL COMMENT '关联租户id',
product_code VARCHAR ( 30 ) NOT NULL COMMENT '产品CODE',
before_renew_time datetime DEFAULT NULL COMMENT '续费之前的时间',
after_renew_time datetime DEFAULT NULL COMMENT '续费之后的时间' ,
PRIMARY KEY ( `id`)
) ENGINE = INNODB  DEFAULT CHARSET = utf8 COMMENT = '租户-产品续费记录表';



CREATE TABLE uic_sub_product (
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  product_code  varchar(30) NOT NULL COMMENT '产品CODE',
  sub_product_code varchar(30) NOT NULL COMMENT '子产品CODE',
  sub_product_name varchar(64) NOT NULL COMMENT '子产品名称',
  sub_product_desc varchar(64) DEFAULT NULL COMMENT '子产品描述',
  order_num  int(11)  DEFAULT 0 COMMENT '排序字段',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='子产品列表';


CREATE TABLE uic_user_sub_product_rel (
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  tenant_id int(11) unsigned NOT NULL COMMENT '关联租户id',
  user_id int(11) unsigned NOT NULL COMMENT '关联用户id',
  product_code varchar(30) NOT NULL COMMENT '产品CODE',
  sub_product_code varchar(30) NOT NULL COMMENT '子产品CODE',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户-子产品角色关联表';


CREATE TABLE uic_sso_system (
        id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
        sys_name varchar(255) NOT NULL DEFAULT 'DTStack' COMMENT '系统名称',
        sys_status TINYINT NOT NULL DEFAULT '0' COMMENT '系统是否开启',
        sys_type int(2) NOT NULL DEFAULT '0' COMMENT '系统类型 0默认本地系统;1wechat;2ldap;3cas;4 openid;5dingTalk;6自定义',
        is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
        sync_status int(2) NULL DEFAULT NULL COMMENT '同步状态 0无需同步，1同步中，2同步失败，3同步成功',
        sync_result VARCHAR(512) COMMENT '同步结果',
        gmt_create datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        gmt_modified datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
        creator int(11) DEFAULT NULL COMMENT '创建人',
        modifier int(11) DEFAULT NULL COMMENT '修改人',
        PRIMARY KEY (id)
        ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户系统集成表';


  CREATE TABLE uic_sso_wechat (
        id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
        sys_id int(11) NOT NULL  COMMENT '系统id',
        sys_name VARCHAR(256)  NOT NULL COMMENT '对接系统名称',
        oauth2_url VARCHAR(512)  NOT NULL  COMMENT 'oauth2_url',
        redirect_url VARCHAR(512)  NOT NULL  COMMENT '回调url',
        client_id VARCHAR(512)  NOT NULL  COMMENT '客户端id',
        agent_id VARCHAR(512) NOT NULL  COMMENT '自建应用id',
        agent_secret VARCHAR(512) NOT NULL  COMMENT '自建应用密钥',
        response_type VARCHAR(64) NOT NULL DEFAULT 'code' COMMENT '返回类型',
        scope VARCHAR(64)  DEFAULT NULL COMMENT 'scope',
        contacts_api_enable TINYINT(1) DEFAULT 0 COMMENT '是否开启通讯录同步 0关闭/1开启',
        receive_event_enable  TINYINT(1) DEFAULT 0 COMMENT '是否开启微信事件接收 0关闭/1开启',
        token VARCHAR(512) DEFAULT NULL COMMENT '微信事件接收token',
        encoding_aes_key VARCHAR(512) DEFAULT NULL COMMENT '微信事件接收EncodingAESKey',
        account_mapping VARCHAR(256) COMMENT '账号映射',
        email_mapping VARCHAR(256) COMMENT '邮箱映射',
        phone_mapping VARCHAR(256) COMMENT '手机号映射',
        name_mapping VARCHAR(256) COMMENT '姓名映射',
        update_type TINYINT(1) DEFAULT 0 COMMENT '0增量更新/1全量更新',
        update_key VARCHAR(256) COMMENT '0增量更新/1全量更新',
        default_tenant_id INT(11) DEFAULT NULL COMMENT '默认同步租户',
        default_tenant_name VARCHAR(256) COMMENT '默认同步租户名称',
        sync_mode TINYINT(1) DEFAULT 0 COMMENT '同步模式 0只读/1可编辑',
        sync_type TINYINT(1) DEFAULT 0 COMMENT '同步类型 0手动同步/1上传文件',
        file_name VARCHAR(256) COMMENT '文件名称',
        is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
        gmt_create datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        gmt_modified datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
        creator int(11) DEFAULT NULL COMMENT '创建人',
        modifier int(11) DEFAULT NULL COMMENT '修改人',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='企业微信表';


 CREATE TABLE `uic_user_renew_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `before_renew_time` datetime NOT NULL COMMENT '续费之前的时间',
  `after_renew_time` datetime NOT NULL COMMENT '续费之后的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户续期记录表';



CREATE TABLE `uic_page_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '模块页面:uic/portal',
  `page` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '页面标识(标签页:tag_page/登录页:login_page/用户中心:user_center)',
  `main_title` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '主标题',
  `main_title_color` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '主标题颜色',
  `second_title` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '副标题',
  `second_title_color` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '副标题颜色',
  `copyright` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '版权声明',
  `copyright_color` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '版权声明颜色',
  `logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'logo图片',
  `original_logo_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'logo原文件名',
  `banner` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'banner图片地址',
  `original_banner_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'banner原图片名',
  `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Uic页面配置表';



CREATE TABLE `uic_sso_cas` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sys_id` int(11) NOT NULL COMMENT '系统id',
  `sys_name` varchar(256) NOT NULL COMMENT '对接系统名称',
  `auth_url` varchar(256) NOT NULL COMMENT 'cas认证登录页面',
  `ticket_url` varchar(256) NOT NULL COMMENT '认证ticketUrl',
  `redirect_url` varchar(256) DEFAULT NULL COMMENT '回调Url',
  `account_mapping` varchar(256) DEFAULT NULL COMMENT '账号映射',
  `name_mapping` varchar(256) DEFAULT NULL COMMENT '姓名映射',
  `email_mapping` varchar(256) DEFAULT NULL COMMENT '邮箱映射',
  `phone_mapping` varchar(256) DEFAULT NULL COMMENT '手机号映射',
  `default_tenant_id` int(11) DEFAULT NULL COMMENT '默认同步租户',
  `logout_type` tinyint(1) DEFAULT '0' COMMENT '登出方式，0链接/1接口/2无',
  `logout_url` varchar(64) DEFAULT NULL COMMENT '登出链接',
  `sync_mode` tinyint(1) DEFAULT '0' COMMENT '同步模式 0只读/1可编辑',
  `sync_type` tinyint(1) DEFAULT '0' COMMENT '同步类型 0手动同步/1接口触发',
  `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='cas-server表';


CREATE TABLE `uic_sso_oauth_server` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sys_id` int(11) NOT NULL COMMENT '系统id',
  `sys_name` varchar(256) NOT NULL COMMENT '对接系统名称',
  `auth_url` varchar(256) NOT NULL COMMENT 'oauth2认证登录页面',
  `client_id` varchar(256) NOT NULL COMMENT 'client_id',
  `client_secret` varchar(256) NOT NULL COMMENT 'client_secret',
  `redirect_url` varchar(256) DEFAULT NULL COMMENT '回调url',
  `response_type` varchar(256) NOT NULL COMMENT 'response_type',
  `access_token_column` varchar(256) NOT NULL COMMENT 'accessToken字段名',
  `access_token_url` varchar(256) NOT NULL COMMENT '获取accessToken的url',
  `user_info_url` varchar(256) NOT NULL COMMENT '获取用户信息的url',
  `account_mapping` varchar(256) DEFAULT NULL COMMENT '账号映射',
  `phone_mapping` varchar(256) DEFAULT NULL COMMENT '手机号映射',
  `name_mapping` varchar(256) DEFAULT NULL COMMENT '姓名映射',
  `email_mapping` varchar(256) DEFAULT NULL COMMENT '邮箱映射',
  `default_tenant_id` int(11) DEFAULT NULL COMMENT '默认同步租户',
  `logout_type` tinyint(1) DEFAULT '0' COMMENT '登出方式，0链接/1接口/2无',
  `logout_url` varchar(64) DEFAULT NULL COMMENT '登出链接',
  `sync_mode` tinyint(1) DEFAULT '0' COMMENT '同步模式 0只读/1可编辑',
  `sync_type` tinyint(1) DEFAULT '0' COMMENT '同步类型 0手动同步/1接口触发',
  `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='oauth2-server表';

ALTER TABLE uic_user ADD is_first_login varchar(1)  NOT NULL DEFAULT 'Y' COMMENT '是否是第一次登录,Y是，N否';

ALTER TABLE uic_tenant ADD external_id  varchar(50) DEFAULT NULL COMMENT '外部租户id';

alter table uic_tenant_product_rel add column product_time datetime default now() COMMENT '产品有效期';
