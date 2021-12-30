-- 创建实时数据源表
CREATE TABLE `rdos_stream_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_name` varchar(128) NOT NULL COMMENT '数据源名称',
  `data_desc` varchar(1024) NOT NULL COMMENT '数据源描述',
  `data_json` varchar(1024) NOT NULL COMMENT '链接数据源信息需要加密 json格式',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型',
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `index_rdos_batch_data_source` (`tenant_id`,`project_id`,`data_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 实时任务支持配置数据源
ALTER TABLE rdos_stream_task ADD COLUMN source_params text COMMENT '输入源';
ALTER TABLE rdos_stream_task ADD COLUMN sink_params text COMMENT '输出源';
ALTER TABLE rdos_stream_task ADD COLUMN side_params text COMMENT '维表';

CREATE TABLE `rdos_stream_data_source_task_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_source_id` int(11) NOT NULL COMMENT '数据源id',
  `task_id` int(11) DEFAULT NULL COMMENT '任务id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_data_source_task_id` (`data_source_id`,`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
