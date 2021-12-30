CREATE TABLE `dt_center_cron_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_detail_name` varchar(255) NOT NULL COMMENT 'job名称',
  `job_detail_group` varchar(255) NOT NULL COMMENT 'job group 名称',
  `job_trigger_name` varchar(255) NOT NULL COMMENT 'job trigger 名称',
  `job_trigger_group` varchar(255) NOT NULL COMMENT 'job trigger group 名称',
  `class_name` varchar(255) NOT NULL COMMENT '任务执行类名称',
  `cron` varchar(255) NOT NULL COMMENT 'cron 表达式',
  `concurrent` tinyint(1) NOT NULL COMMENT '0: false, 1:true',
  `start_time` datetime COMMENT '开始时间',
  `end_time` datetime  COMMENT '结束时间',
  `biz_type` VARCHAR(255) NOT NULL COMMENT '任务业务类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_job_name` (`job_detail_name`, `job_detail_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'dataScienceAlarmCheckJob', 'dataScienceAlarmCheckJobGroup', 'dataScienceAlarmCheckJobTrigger', 'dataScienceAlarmCheckJobGroup', 'com.dtstack.science.schedule.alarm.job.DataScienceAlarmCheckJob', '0 */5 * * * ?', 0, NULL, NULL, 'dataScience', '2020-05-08 17:29:49', '2020-05-08 17:29:49', 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'dataScienceAlarmSendJob', 'dataScienceAlarmSendJobGroup', 'dataScienceAlarmSendJobTrigger', 'dataScienceAlarmSendJobGroup', 'com.dtstack.science.schedule.alarm.job.DataScienceAlarmSendJob', '0 */1 * * * ?', 0, NULL, NULL, 'dataScience', '2020-05-08 17:29:49', '2020-05-08 17:29:49', 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'dataScienceCheckConnJob', 'dataScienceCheckConnJobGroup', 'dataScienceCheckConnJobTrigger', 'dataScienceCheckConnJobGroup', 'com.dtstack.science.schedule.checkconn.job.DataScienceCheckConnJob', '*/10 * * * * ?', 0, NULL, NULL, 'dataScience', '2020-05-12 18:04:44', '2020-05-12 18:04:44', 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'dataScienceTableLifecycleJob', 'dataScienceTableLifecycleJobGroup', 'dataScienceTableLifecycleJobTrigger', 'dataScienceTableLifecycleJobGroup', 'com.dtstack.science.schedule.clean.job.DataScienceTableLifecycleJob', '0 */10 * * * ?', 0, NULL, NULL, 'dataScience', '2020-05-12 18:04:44', '2020-05-12 18:04:44', 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'syncHiveMetaDataJob', 'syncHiveMetaDataScheduleJobGroup', 'syncHiveMetaDataScheduleJobTrigger', 'syncHiveMetaDataScheduleJobGroup', 'com.dtstack.science.schedule.synchive.job.SyncHiveMetaDataJob', '0 0 22 * * ?', 0, NULL, NULL, 'dataScience', '2020-05-27 10:55:11', '2020-05-27 10:55:11', 1);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'dataSciencePeriodDataCleanJob', 'dataSciencePeriodDataCleanJobScheduleJobGroup', 'dataSciencePeriodDataCleanJobScheduleJobTrigger', 'dataSciencePeriodDataCleanJobbScheduleJobGroup', 'com.dtstack.science.schedule.clean.job.DataSciencePeriodDataCleanJob', '0 0 */12 * * ?', 0, NULL, NULL, 'dataScience', '2020-08-04 15:05:22', '2020-08-04 15:05:22', 0);
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (null, 'modelServiceSyncStatusAndLoadJob', 'modelServiceSyncStatusAndLoadJobGroup', 'modelServiceSyncStatusAndLoadJobTrigger', 'modelServiceSyncStatusAndLoadJobGroup', 'com.dtstack.science.schedule.model.job.ModelServiceSyncStatusAndLoadJob', '0 */10 * * * ?', 0, NULL, NULL, 'dataScience', '2020-10-16 10:55:11', '2020-10-16 10:55:11', 0);