ALTER TABLE `da_api`
ADD COLUMN `original_port` INT NULL COMMENT '注册api的原始api port(socket协议)' AFTER `original_path`;

ALTER TABLE `da_api_test`
ADD COLUMN `original_port` INT NULL COMMENT '注册api的原始api port(socket协议)' AFTER `original_path`;