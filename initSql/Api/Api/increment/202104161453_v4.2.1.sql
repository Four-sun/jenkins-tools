

drop table if exists da_user_test_token;
CREATE TABLE `da_user_test_token` (
	`id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
	`tenant_id` BIGINT ( 20 ) NOT NULL,
	`project_id` INT ( 11 ) DEFAULT NULL COMMENT '项目id',
	`api_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT 'apiId',
	`user_id` INT ( 11 ) NOT NULL DEFAULT '0' COMMENT 'userId',
	`token` varchar(256) NOT NULL DEFAULT '0' COMMENT '测试token',
	`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
	`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
	PRIMARY KEY ( `id` ),
UNIQUE KEY `idx_source_api` ( `api_id`, `user_id` )
) ENGINE = INNODB AUTO_INCREMENT = 57 DEFAULT CHARSET = utf8 COMMENT = '用户-API测试token关联表';