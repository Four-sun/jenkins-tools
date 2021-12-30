CREATE TABLE `gw_api` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`serviceName` varchar(45) NOT NULL DEFAULT 'group_service' COMMENT '注册服务名',
`ip` varchar(45) NOT NULL DEFAULT '0' COMMENT 'ip',
`port` int(11) NOT NULL DEFAULT '0' COMMENT '端口',
`is_group` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否分组api，0不是 1是',
`token` varchar(256) DEFAULT NULL COMMENT '请求token',
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='注册服务表';

CREATE TABLE `gw_api_group` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`api_id` int(11) NOT NULL DEFAULT '0' COMMENT 'api id，对应ga_api表的id字段',
`serviceName` varchar(45)  NOT NULL  COMMENT '注册服务名',
`ip` varchar(45) NOT NULL DEFAULT '0' COMMENT 'ip',
`port` int(11) NOT NULL DEFAULT '0' COMMENT '端口',
`rate` int(11) NOT NULL DEFAULT '0' COMMENT '分流比例',
`url` varchar(256) DEFAULT NULL COMMENT '请求url',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='服务分组表';

CREATE TABLE `gw_invoke_count` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`api_id` int(11) NOT NULL COMMENT '对应gw_api id',
`group_id` int(11) DEFAULT NULL COMMENT '对应gw_api_group id',
`count` int(11) NOT NULL COMMENT '调用次数',
`invoke_time` datetime NOT NULL COMMENT '调用时间',
`execute_time` int(36) NOT NULL COMMENT '调用耗时',
`app_sign` varchar(64) NOT NULL COMMENT '请求类型',
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`) USING BTREE,
KEY `invoke_time` (`invoke_time`) USING BTREE,
KEY `app_u_a_i` (`app_sign`,`app_type`,`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='成功调用信息表';

CREATE TABLE `gw_invoke_log` (
`id` bigint(36) unsigned NOT NULL AUTO_INCREMENT,
`api_id` int(36) NOT NULL COMMENT '对应gw_api id',
`group_id` int(11) DEFAULT NULL COMMENT '对应gw_api_group id',
`biz_type` tinyint(2) NOT NULL COMMENT '日志类型',
`invoke_time` datetime NOT NULL COMMENT '调用时间',
`content` text COMMENT '日志内容',
`app_sign` varchar(64) NOT NULL COMMENT '请求类型',
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='失败调用信息表';

CREATE TABLE `gw_statistics_trigger` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `last_count_id` int(11) DEFAULT NULL COMMENT '上次统计到的最后一条invoke_count 表 id',
 `last_log_id` int(11) DEFAULT NULL COMMENT '上次统计到的最后一条invoke_log 表 id',
 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
 `is_deleted` tinyint(2) NOT NULL DEFAULT '0',
 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `gw_snapshot_api` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`api_id` int(11) NOT NULL,
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`group_id` int(11) DEFAULT NULL COMMENT '对应gw_api_group id',
`invoke_total` bigint(11) NOT NULL DEFAULT '0' COMMENT '调用总计',
`sub_total` int(11) NOT NULL DEFAULT '0' COMMENT '订阅数总计',
`fail_total` bigint(11) NOT NULL DEFAULT '0' COMMENT '总失败率',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`tenant_id` int(11) NOT NULL DEFAULT '0',
`is_deleted` tinyint(2) unsigned zerofill NOT NULL DEFAULT '00',
PRIMARY KEY (`id`) USING BTREE,
UNIQUE KEY `group_id_index` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `gw_snapshot_invoke` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`api_id` int(11) NOT NULL,
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`group_id` int(11) DEFAULT NULL COMMENT '对应gw_api_group id',
`invoke_total` bigint(11) DEFAULT NULL COMMENT '调用总计',
`fail_total` bigint(11) unsigned zerofill DEFAULT '00000000000' COMMENT '总失败率',
`total_1d` bigint(11) DEFAULT NULL,
`fail_1d` bigint(11) DEFAULT NULL COMMENT '24h失败率',
`total_7d` bigint(11) DEFAULT NULL,
`fail_7d` bigint(11) DEFAULT NULL COMMENT '7日失败率',
`total_30d` bigint(11) DEFAULT NULL,
`fail_30d` bigint(11) DEFAULT NULL COMMENT '30日失败率',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(2) unsigned zerofill NOT NULL DEFAULT '00',
PRIMARY KEY (`id`) USING BTREE,
UNIQUE KEY `group_id_index` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `gw_invoke_count_day` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`invoke_time` datetime NOT NULL,
`api_id` int(11) NOT NULL,
`count` int(11) NOT NULL,
`execute_time` int(36) NOT NULL,
`gmt_create` datetime NOT NULL,
`gmt_modified` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
`is_deleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
`app_sign` varchar(64) NOT NULL,
PRIMARY KEY (`id`) USING BTREE,
KEY `api_time` (`api_id`,`invoke_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='调用情况统计表（按日维度）';

CREATE TABLE `gw_snapshot_err` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`api_id` int(11) NOT NULL,
`app_type` tinyint(2) NOT NULL COMMENT '平台应用类型',
`biz_type` tinyint(2) NOT NULL,
`group_id` int(11) DEFAULT NULL COMMENT '对应gw_api_group id',
`total_fail` bigint(11) NOT NULL DEFAULT '0',
`fail_1d` bigint(11) NOT NULL DEFAULT '0',
`fail_7d` bigint(11) NOT NULL DEFAULT '0',
`fail_30d` bigint(11) NOT NULL DEFAULT '0',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`project_id` int(11) DEFAULT NULL COMMENT '项目id',
PRIMARY KEY (`id`) USING BTREE,
UNIQUE KEY `group_id_index` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
