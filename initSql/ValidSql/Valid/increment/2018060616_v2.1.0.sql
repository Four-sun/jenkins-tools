
UPDATE dq_role SET role_desc = '本产品内的全部权限，具有本租户内的最高权限' WHERE role_value = 1;
UPDATE dq_role SET role_desc = '本产品内的全部权限，可为其他用户分配角色' WHERE role_value = 2;
UPDATE dq_role SET role_desc = '只具备查看权限，没有权限进行编辑等操作' WHERE role_value = 3;
update dq_role set role_desc = '具有新建监控规则、查看监控规则、双表校验等权限，不能进行数据源管理、不能进行用户管理' where role_value = 4;


--  增加数据质量监控记录和告警数的快照表
-- Table structure for table `dq_snapshot`

  /*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_snapshot` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`relation_id` int(11) NOT NULL DEFAULT '0' COMMENT '统计对象的id',
`trigger_rules` int(11) NOT NULL DEFAULT '0'COMMENT '触发的规则数',
`notify_1d` int(11) NOT NULL DEFAULT '0'COMMENT '最近一天的告警数量',
`notify_7d` int(11) NOT NULL DEFAULT '0'COMMENT '最近七天的告警数量',
`notify_30d` int(11) NOT NULL DEFAULT '0'COMMENT '最近三十天的告警数量',
`last_record_id` int(11) NOT NULL DEFAULT '0'COMMENT '最近一次统计的监控记录id',
`remain_record_ids` varchar(256) COMMENT '上次统计的遗留',
`type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 monitorRecord  2  table',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE key `idx_relationId_type` (`relation_id`, `type`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='监控记录和表对象的统计结果表';
/*!40101 SET character_set_client = @saved_cs_client */;

-- 增加monitorData 表中的recordId的索引
ALTER TABLE `dq_monitor_data` ADD INDEX index_recordId ( `monitor_record_id` );