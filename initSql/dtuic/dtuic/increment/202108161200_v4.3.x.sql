ALTER TABLE `uic_sso_customize`  CHANGE COLUMN `jump_url` `logout_jump_url` varchar(255);
ALTER TABLE `uic_sso_customize`  ADD COLUMN `jump_url`  varchar(255);
ALTER TABLE `uic_sso_ldap` ADD COLUMN `save_password`  tinyint(1) DEFAULT 1 COMMENT '是否保存密码';
ALTER TABLE `uic_sso_customize`  ADD COLUMN `post_params`  varchar(255);
ALTER TABLE `uic_sso_customize`  ADD COLUMN `url_params`  varchar(255);
UPDATE uic_sso_customize SET url_params = params;

UPDATE uic_sso_customize SET post_params = '[""]' WHERE post_params is null or post_params = '';

update uic_sso_cas set redirect_url = JSON_OBJECT("innerVal",redirect_url,"key","service")
WHERE is_deleted = 'N';

update uic_sso_oauth_server set redirect_url = JSON_OBJECT("innerVal",redirect_url,"key","redirect_uri")
WHERE is_deleted = 'N';