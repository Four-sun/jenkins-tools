CREATE TABLE `rdos_stream_alarm_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) DEFAULT NULL COMMENT '告警id',
  `alarm_type_id` int(11) DEFAULT NULL COMMENT '告警方式id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `alarm_id_index` (`alarm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_alarm_type_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_gate_source` varchar(256) DEFAULT NULL COMMENT '告警通道唯一标识',
  `alert_gate_name` varchar(256) DEFAULT NULL COMMENT '告警通道名称',
  `alert_gate_type` tinyint(1) DEFAULT NULL COMMENT '通道类别： 1邮件 2短信 3钉钉 4自定义',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `gate_source_index` (`alert_gate_source`(8))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;