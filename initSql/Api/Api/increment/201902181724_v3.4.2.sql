ALTER TABLE `da_api`
  ADD COLUMN `body_desc_json` VARCHAR(1000) NULL COMMENT '注册api put、post请求body示例' AFTER `error_resp_json`;
