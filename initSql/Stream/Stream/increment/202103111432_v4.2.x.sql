-- checkpoint失败告警记录表
CREATE TABLE `rdos_stream_alarm_checkpoint_failure_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL COMMENT '告警id',
  `checkpoint_id` varchar(50) NOT NULL COMMENT 'checkpoint失败唯一标识',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_stream_alarm_checkpoint` (`project_id`,`alarm_id`,`checkpoint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'checkpoint失败告警记录表';