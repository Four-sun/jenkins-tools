ALTER TABLE `da_api`
ADD COLUMN `dbName` VARCHAR(64) NULL COMMENT '创建API时指定的数据库' AFTER `data_src_id`;

ALTER TABLE `da_api_test`
ADD COLUMN `dbName` VARCHAR(64) NULL COMMENT '创建API时指定的数据库' AFTER `data_src_id`;
