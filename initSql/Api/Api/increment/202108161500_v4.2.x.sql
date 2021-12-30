-- 修改body_desc_json字段的字段类型为text
ALTER TABLE `da_api`
CHANGE COLUMN `body_desc_json` `body_desc_json` TEXT NULL DEFAULT NULL COMMENT '注册api put、post请求body示例' ;
