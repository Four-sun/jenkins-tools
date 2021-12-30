-- 针对表生命周期move文件记录表
CREATE TABLE if not exists `rdos_table_lifeday_backup` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` BIGINT(20) NOT NULL COMMENT '租户id',
  `project_id` BIGINT(20) NOT NULL COMMENT '项目id',
  `table_name` VARCHAR(200) NOT NULL COMMENT '表名',
  `backup_location` VARCHAR(1000) NOT NULL COMMENT '备份路径',
  `gmt_create` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未处理 1已处理',
  PRIMARY KEY (`id`),
  KEY `index_tenant_status` (`tenant_id`,`status`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='移动目录记录表';