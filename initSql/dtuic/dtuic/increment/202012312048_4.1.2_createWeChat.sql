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

INSERT INTO  uic_sso_system(sys_name, sys_status, sys_type, sync_status) VALUES ('UIC账号登录', 1, 0, 0);

CREATE TABLE uic_sso_oauth2 (
    id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    sys_id int(11) NOT NULL  COMMENT '系统id',
    sys_name VARCHAR(256)  NOT NULL COMMENT '对接系统名称',
	oauth2_url VARCHAR(512)  NOT NULL  COMMENT 'oauth2_url',
	redirect_url VARCHAR(512)  NOT NULL  COMMENT '回调url',
	client_id VARCHAR(512)  DEFAULT NULL  COMMENT '客户端id',
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

ALTER TABLE uic_user ADD COLUMN sys_id  int(11) NOT NULL DEFAULT 0   COMMENT '系统id';

alter TABLE uic_info  MODIFY COLUMN  name  varchar(64) DEFAULT NULL;
INSERT INTO  uic_info(name, value) VALUES ('register_enable', 'Y');
INSERT INTO  uic_info(name, value) VALUES ('login_page_enable', 'N');
INSERT INTO  uic_info(name, value) VALUES ('sub_product_enable', 'Y');
INSERT INTO  uic_info(name, value) VALUES ('external_api_enable', 'N');