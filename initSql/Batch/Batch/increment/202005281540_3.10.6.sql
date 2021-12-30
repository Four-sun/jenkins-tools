ALTER TABLE `rdos_batch_test_produce_resource` ADD COLUMN `resource_type` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '资源类型 默认0：资源  1：函数' ;
