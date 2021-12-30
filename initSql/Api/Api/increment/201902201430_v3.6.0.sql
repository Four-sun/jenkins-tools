-- 创建授权表
CREATE TABLE `da_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  `source_id` bigint(20) NOT NULL COMMENT '授权关联人id或者app_id',
  `source_type` SMALLINT(3) NOT NULL DEFAULT 0 COMMENT 'source_id的类型（0-用户id；1-appId）',
  `app_key` varchar(255) NOT NULL COMMENT 'ak',
  `app_secret` varchar(255) NOT NULL COMMENT 'Sk',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNI_APPKEY_TENANT` (`source_id`,`tenant_id`),
  KEY `IND_APPKEY` (`app_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建api授权表
CREATE TABLE `da_api_auth` (
  `id` bigint(20) NOT NULL,
  `api_id` bigint(20) NOT NULL COMMENT 'api id',
  `auth_id` bigint(20) NOT NULL COMMENT 'da_auth表中的id',
  `tenant_id` bigint(20) NOT NULL,
  `begin_time` datetime DEFAULT NULL COMMENT '申请开始调用时间',
  `end_time` datetime DEFAULT NULL COMMENT '申请结束调用时间',
  `call_limit` int(11) DEFAULT NULL,
  `status` smallint(2) DEFAULT '0' COMMENT '授权状态(-1:未申请，0:待处理，1:通过，2:拒绝，3:停用，4:禁用，5，已到期)',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_api_id_auth_id` (`api_id`,`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
