-- 表操作记录备份表
CREATE TABLE `rdos_hive_table_action_record_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `table_id` int(11) NOT NULL COMMENT '表id',
  `action_sql` longtext NOT NULL COMMENT '操作sql语句',
  `operate` varchar(100) NOT NULL COMMENT '操作类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_table_id` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表操作记录备份';

-- 增加CommonJob
INSERT INTO dt_center_cron_schedule (job_detail_name, job_detail_group, job_trigger_name, job_trigger_group, class_name,
                                     cron, concurrent, start_time, end_time, biz_type, gmt_create, gmt_modified, is_deleted)
VALUES ('batchCommonJob', 'batchCommonJobGroup', 'batchCommonJob', 'batchCommonJobGroup',
        'com.dtstack.batch.job.BatchCommonJob', '0 0 23 * * ?', 0, NULL, NULL, 'rdos', now(), now(), 0);
