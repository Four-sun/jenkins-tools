alter table uic_sso_ldap add ssl_file_name varchar(64) null comment '上传文件名';
alter table uic_sso_ldap add file_path varchar(500) null comment '文件路径';
alter table uic_sso_ldap add is_ssl tinyint(1) not null default 0 comment '是否开启ssl，默认不开启 0,开启 1';
alter table uic_sso_ldap add key_store_password varchar(128) null comment 'keyStorePassword';
alter table uic_sso_ldap add alias varchar(64) null comment '认证文件别名';
alter table uic_sso_ldap add key_pass varchar(128) null comment 'keyPass';
alter table uic_sso_ldap add security_path varchar(500) null comment '认证文件路径';

