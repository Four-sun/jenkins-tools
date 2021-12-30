BEGIN;
SET @id=(SELECT id FROM da_permission WHERE CODE='api_datasource_menu');
SET @id2=(SELECT id FROM da_permission WHERE CODE='api_datasource_query');
SET @role1=(SELECT id FROM da_role WHERE role_value=3);
SET @role2=(SELECT id FROM da_role WHERE role_value=4);
INSERT INTO da_role_permission (role_id,permission_id) VALUES (@role1,@id);
INSERT INTO da_role_permission (role_id,permission_id) VALUES (@role2,@id);
INSERT INTO da_role_permission (role_id,permission_id) VALUES (@role2,@id2);

ALTER TABLE `da_api`
  ADD COLUMN `api_type` VARCHAR(45) NULL DEFAULT 0 COMMENT 'api类型(0-默认,1-注册api)' AFTER `resp_limit`,
  ADD COLUMN `original_host` VARCHAR(45) NULL COMMENT '注册API的原始api host' AFTER `data_src_type`,
  ADD COLUMN `original_path` VARCHAR(200) NULL COMMENT '注册api的原始api path' AFTER `original_host`,
  ADD COLUMN `original_method` VARCHAR(10) NULL COMMENT '注册api的原始api 请求方式' AFTER `original_path`,
  ADD COLUMN `error_code_list_json` text(0) NULL COMMENT '注册api的错误码列表' AFTER `original_method`,
  ADD COLUMN `error_resp_json` text(0) NULL COMMENT '注册api的错误返回示例' AFTER `error_code_list_json`;

ALTER TABLE da_api modify column config_sql text;

UPDATE da_role SET role_desc = '所有权限' where role_value = 1;
UPDATE da_role SET role_desc = '可使用全部功能，且可以进行用户管理' where role_value = 2;
UPDATE da_role SET role_desc = '可查看概览、API市场、我的API模块' where role_value = 3;
UPDATE da_role SET role_desc = 'API的使用者，可查看概览（仅看到自己的API）、API市场、我的API模块，不能创建/编辑API，不能对用户进行管理' where role_value = 4;

delete from da_role_permission where role_id = (SELECT id FROM da_role WHERE role_value = 3) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
		'api_market_apply'
  )
);

COMMIT;
