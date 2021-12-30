DROP TABLE IF EXISTS  da_api_group_relation;
CREATE TABLE `da_api_group_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组id',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '分流比例',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
 UNIQUE KEY `uniq_group_rel` (`group_id`,`relation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='服务分组关联表';


DROP TABLE IF EXISTS  da_api_group_relation_test;
CREATE TABLE `da_api_group_relation_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组id',
  `relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '分流比例',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
 UNIQUE KEY `uniq_group_rel` (`group_id`,`relation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='服务分组关联测试表';

alter table da_api add column app_type int(2) NOT NULL DEFAULT 5 COMMENT '应用标识，5 api，6 aiworks';
alter table da_api_test add column app_type int(2) NOT NULL DEFAULT 5 COMMENT '应用标识，5 api，6 aiworks';