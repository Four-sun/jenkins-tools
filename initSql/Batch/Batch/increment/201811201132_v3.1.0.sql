
CREATE TABLE `rdos_user_operator_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id`  int(11) NOT NULL COMMENT '用户id',
  `operator_id` tinyint(1) NOT NULL COMMENT '操作类型',
  `type` tinyint(1) NOT NULL COMMENT 'ddl/dml',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `apply_id`  int(11) NOT NULL COMMENT '申请id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `rdos_user_column_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id`  int(11) NOT NULL COMMENT '用户id',
  `column_name` varchar(50) NOT NULL COMMENT '字段名称',
  `full_column` tinyint(1) NOT NULL COMMENT '全部字段',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `apply_id`  int(11) NOT NULL COMMENT '申请id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES ('1', 'DB2', '19', 'DB2', 'DB2', '19', now(), now(), '0');


ALTER TABLE `rdos_batch_hive_table_permission`
ADD COLUMN `apply_id` INT(11) NOT NULL COMMENT '申请id' AFTER `permission_type`;

ALTER TABLE `rdos_batch_alarm_record`
ADD COLUMN `receive_user` VARCHAR(512) COMMENT '告警接收人' after `alarm_content`;


INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
  ('1', 'DTinsightAnalytics', '20', 'CarbonData', 'DTinsightAnalytics', '20', now(), now(), '0');
