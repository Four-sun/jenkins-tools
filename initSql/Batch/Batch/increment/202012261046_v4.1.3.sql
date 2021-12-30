-- 告警配置告警通道关联表
CREATE TABLE `rdos_batch_alarm_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) DEFAULT NULL COMMENT '预警id',
  `alarm_type_id` int(11) DEFAULT NULL COMMENT '预警方式id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `alarm_id_index` (`alarm_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='告警配置告警通道关联表';

-- 控制台配置告警通道信息表
CREATE TABLE `rdos_batch_alarm_type_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_gate_source` varchar(256) DEFAULT NULL COMMENT '告警通道唯一标识',
  `alert_gate_name` varchar(256) DEFAULT NULL COMMENT '告警通道名称',
  `alert_gate_type` tinyint(1) DEFAULT NULL COMMENT '通道类别： 1短信 2邮件 3钉钉 4自定义',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0 正常 1 逻辑删除',
  PRIMARY KEY (`id`),
  KEY `gate_source_index` (`alert_gate_source`(8))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='控制台配置告警通道信息表';

-- 修改rdos_notify表结构
alter table rdos_notify modify send_way varchar(128) default '' comment '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）';