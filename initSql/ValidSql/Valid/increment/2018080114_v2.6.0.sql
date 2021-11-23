-- 添加监控对象的远程触发表
--
-- Table structure for table `dq_remote_trigger`
--

  CREATE TABLE `dq_remote_trigger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `monitor_id` int(11) NOT NULL DEFAULT '0' COMMENT '监控对象id',
  `url` text COMMENT '触发url',
  `view_state_url` text COMMENT '查看状态url',
  `rule_ids` text COMMENT '规则id的json字符串',
  `rule_number` int(11) DEFAULT NULL COMMENT '触发规则数',
  `partition_value` varchar(256) DEFAULT NULL COMMENT '分区',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='监控对象的远程触发信息表';

-- 插入原来存在dq_monitor表中的remote数据
insert into dq_remote_trigger (tenant_id,monitor_id,url,rule_ids,rule_number,partition_value,remark,create_user_id,modify_user_id ) select tenant_id,id,url,rule_ids,rule_number,partitions,remark,create_user_id,modify_user_id from dq_monitor where url is not null;


-- 给monitor_record表添加remoteId字段，来表示是否是远程调用产生的监控记录
ALTER TABLE `dq_monitor_record`
ADD COLUMN `remote_id` INT(11) NOT NULL DEFAULT '0' COMMENT '远程调用的id' AFTER `job_key`;

ALTER TABLE `dq_data_source`
ADD COLUMN `link_state` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用' AFTER `active`;