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

rename table uic_sso_oauth2 to uic_sso_wechat;

alter table uic_user alter column sys_id set default 1;

update uic_user set sys_id = 1 where is_deleted = 'N' and external_id IS  NULL;
