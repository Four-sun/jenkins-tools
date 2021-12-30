#新增字段
ALTER TABLE `rdos_batch_alarm` ADD COLUMN `alarm_type` TINYINT(1) DEFAULT 2 COMMENT '告警类型 1：项目  2：任务' ;
ALTER TABLE `rdos_batch_alarm` ADD COLUMN `receive_types` varchar(10) DEFAULT NULL COMMENT '接收人类别（项目管理员：1，其他：2）' ;
ALTER TABLE `rdos_batch_alarm` ADD COLUMN `send_time` varchar(10) DEFAULT NULL COMMENT '项目运行报告发送时间' ;
#更新历史数据
update rdos_batch_alarm set alarm_type = 2;
#更新字段非必填
ALTER TABLE rdos_batch_alarm MODIFY task_id int(11) DEFAULT NULL COMMENT 'batch 任务id';
ALTER TABLE rdos_batch_alarm MODIFY name varchar(200) DEFAULT NULL COMMENT '告警名称';
ALTER TABLE rdos_batch_alarm MODIFY is_task_holder tinyint(1) DEFAULT NULL COMMENT '1有任务负责人 0无任务负责人';

#notify
ALTER TABLE `rdos_notify` ADD COLUMN `alarm_type` TINYINT(1) DEFAULT 2 COMMENT '通知类型 1：项目  2：任务' ;


