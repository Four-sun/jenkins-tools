-- 系统参数表
--
-- Table structure for table `dq_sys_parameter`
--

CREATE TABLE `dq_sys_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` VARCHAR(64) NOT NULL COMMENT '参数名称',
  `param_command` VARCHAR(64) NOT NULL COMMENT '参数替换指令',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '系统参数表';


INSERT INTO `dq_sys_parameter` VALUES ('1', 'bdp.system.bizdate', 'yyyyMMdd-1', '0');
INSERT INTO `dq_sys_parameter` VALUES ('2', 'bdp.system.cyctime', 'yyyyMMddHHmmss', '0');
INSERT INTO `dq_sys_parameter` VALUES ('3', 'bdp.system.currmonth', 'yyyyMM-0', '0');
INSERT INTO `dq_sys_parameter` VALUES ('4', 'bdp.system.premonth', 'yyyyMM-1', '0');
INSERT INTO `dq_sys_parameter` VALUES ('5', 'sys.recentPart', '', '0');


-- 任务对象和任务参数关系表
--
-- Table structure for table `dq_task_parameter`
--

CREATE TABLE `dq_task_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `biz_type` int(11) NOT NULL COMMENT '业务类型，1：规则，2：逐行校验',
  `relation_id` int(11) NOT NULL COMMENT '关联id',
  `parameter_id` int(11) NOT NULL COMMENT '系统参数id',
  `partition_col` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '分区字段',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '任务对象和任务参数关系表';


-- 处理在此之前的有配置过  ${sys.recentPart} 参数的监控对象
insert into dq_task_parameter (tenant_id,biz_type,relation_id,parameter_id) select tenant_id,1,id,5 from dq_monitor where partitions  like '%${sys.recentPart}%';



