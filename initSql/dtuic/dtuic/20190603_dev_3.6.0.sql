-- 创建事件表
CREATE TABLE `uic_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_code` varchar(45) DEFAULT NULL,
  `support_method` varchar(45) DEFAULT 'POST' COMMENT '支持的http方法类型，默认只支持post',
  `event_describe` varchar(200) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_code_UNIQUE` (`event_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

INSERT INTO `uic_event`(event_code, support_method, event_describe) VALUES
  ('LOG_OUT', 'POST', '用户登出'),
  ('CHANGE_TENANT_OWNER', 'POST', '切换租户所有者');

-- 创建
CREATE TABLE `uic_product_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `event_code` varchar(45) NOT NULL COMMENT '事件key',
  `callback_url` varchar(100) NOT NULL COMMENT '注册事件回调地址',
  `active` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否激活',
  `addition_key` varchar(100) DEFAULT NULL COMMENT '附加信息，比如数栈产品离线计算，流计算分别传递BATCH，STREAM',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_pid_ecode_url` (`product_id`,`event_code`,`callback_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4