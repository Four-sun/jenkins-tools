CREATE TABLE `dl_group_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `entity_id` int(11) NOT NULL COMMENT '实体id',
  `group_id` int(11) NOT NULL COMMENT '群组id',
  `group_num` int(11) NOT NULL COMMENT '群组覆盖实例数',
  `sync_period_type` int(11) NOT NULL COMMENT '0:分钟 1:小时 2:天 3:星期 4:月',
  `compute_time` datetime NOT NULL COMMENT '计算时间',
  `business_time` datetime NOT NULL COMMENT '最近分区时间',
  `business_format_time` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='群组覆盖实例表';

CREATE TABLE `dl_tag_value_data_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `entity_id` int(11) NOT NULL COMMENT '实体id',
  `tag_id` int(11) NOT NULL COMMENT '标签id',
  `tag_value_json` text COLLATE utf8_bin NOT NULL COMMENT '标签json',
  `un_cover` int(11) NOT NULL DEFAULT '0' COMMENT '未覆盖实例数',
  `entity_total` int(11) NOT NULL COMMENT '实例总量',
  `compute_time` datetime NOT NULL COMMENT '计算时间',
  `business_time` datetime DEFAULT NULL COMMENT '业务日期',
  `business_week_time` datetime DEFAULT NULL COMMENT '周的业务日期，需要特殊处理',
  `business_format_time` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '业务格式化日期',
  `sync_period_type` tinyint(1) DEFAULT NULL COMMENT '0:分钟 1:小时 2:天 3:星期 4:月',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` int(11) DEFAULT '0' COMMENT 'update_by',
  `create_by` int(11) DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签值覆盖量';


CREATE TABLE `dl_tag_publish_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `entity_id` int(11) NOT NULL COMMENT '实体id',
  `tag_publish_count` int(11) NOT NULL COMMENT '发布数量',
  `bussiness_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '业务时间',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) DEFAULT '0' COMMENT '更新的用户',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;