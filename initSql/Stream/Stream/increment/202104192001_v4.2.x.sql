-- 任务支持的metric指标
CREATE TABLE `rdos_stream_metric_support` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) NOT NULL COMMENT '指标中文名称',
  `task_type` tinyint(4) NOT NULL COMMENT '指标支持的任务类型',
  `value` varchar(255) NOT NULL COMMENT '指标key',
  `metric_tag` int(11) NOT NULL COMMENT 'metric匹配模式',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务支持的metric指标';

-- 公共指标
insert into `rdos_stream_metric_support` (`name`, `task_type`, `value`, `metric_tag`, `gmt_modified`, `gmt_create`, `is_deleted`)
values
('jobmanager cpu负载',99,'flink_jobmanager_Status_JVM_CPU_Load', 2, now(), now(), 0),
('jobmanager cpu使用时间',99,'flink_jobmanager_Status_JVM_CPU_Time', 2, now(), now(), 0),
('taskmanager cpu负载',99,'flink_taskmanager_Status_JVM_CPU_Load', 2, now(), now(), 0),
('taskmanager cpu使用时间',99,'flink_taskmanager_Status_JVM_CPU_Time', 2, now(), now(), 0),
('bmanager jvm最大堆内存',99,'flink_jobmanager_Status_JVM_Memory_Heap_Max', 2, now(), now(), 0),
('taskmanager jvm最大堆内存',99,'flink_taskmanager_Status_JVM_Memory_Heap_Max', 2, now(), now(), 0),
('jobmanager jvm堆内存使用量',99,'flink_jobmanager_Status_JVM_Memory_Heap_Used', 2, now(), now(), 0),
('taskmanager jvm堆内存使用量',99,'flink_taskmanager_Status_JVM_Memory_Heap_Used', 2, now(), now(), 0),
('jobmanager jvm最大非堆内存',99,'flink_jobmanager_Status_JVM_Memory_NonHeap_Max', 2, now(), now(), 0),
('taskmanager jvm最大非堆内存',99,'flink_taskmanager_Status_JVM_Memory_NonHeap_Max', 2, now(), now(), 0),
('jobmanager jvm非堆内存使用量',99,'flink_jobmanager_Status_JVM_Memory_NonHeap_Used', 2, now(), now(), 0),
('taskmanager jvm非堆内存使用量',99,'flink_taskmanager_Status_JVM_Memory_NonHeap_Used', 2, now(), now(), 0),
('jobmanager直接缓冲区总容量',99,'flink_jobmanager_Status_JVM_Memory_Direct_TotalCapacity', 2, now(), now(), 0),
('taskmanager直接缓冲区总容量',99,'flink_taskmanager_Status_JVM_Memory_Direct_TotalCapacity', 2, now(), now(), 0),
('jobmanager直接缓冲区内存使用量',99,'flink_jobmanager_Status_JVM_Memory_Direct_MemoryUsed', 2, now(), now(), 0),
('taskmanager直接缓冲区内存使用量',99,'flink_taskmanager_Status_JVM_Memory_Direct_MemoryUsed', 2, now(), now(), 0),
('jobmanager 线程数',99,'flink_jobmanager_Status_JVM_Threads_Count', 2, now(), now(), 0),
('taskmanager 线程数',99,'flink_taskmanager_Status_JVM_Threads_Count', 2, now(), now(), 0),
('排队进入输入缓存区的数量',99,'flink_taskmanager_job_task_buffers_inputQueueLength', 1, now(), now(), 0),
('排队进入输出缓存区的数量',99,'flink_taskmanager_job_task_buffers_outputQueueLength', 1, now(), now(), 0),
('任务重启次数',99,'flink_jobmanager_job_numRestarts', 1, now(), now(), 0),
('任务重启花费时间',99,'flink_jobmanager_job_restartingTime', 1, now(), now(), 0),
('任务最后一次checkpoint花费时间',99,'flink_jobmanager_job_lastCheckpointDuration', 1, now(), now(), 0),
('任务最后一次checkpoint大小',99,'flink_jobmanager_job_lastCheckpointSize', 1, now(), now(), 0),
('任务checkpoint总数量',99,'flink_jobmanager_job_totalNumberOfCheckpoints', 1, now(), now(), 0),
('任务checkpoint失败数量',99,'flink_jobmanager_job_numberOfFailedCheckpoints', 1, now(), now(), 0),
('barrier 对齐花费时间',99,'flink_taskmanager_job_task_checkpointAlignmentTime', 1, now(), now(), 0);

-- flinkSql 任务
insert into `rdos_stream_metric_support` (`name`, `task_type`, `value`, `metric_tag`, `gmt_modified`, `gmt_create`, `is_deleted`)
values
('业务延迟',0,'flink_taskmanager_job_task_operator_dtEventDelay', 1, now(), now(), 0),
('各source tps数据输入',0,'flink_taskmanager_job_task_operator_dtNumRecordsInRate', 1, now(), now(), 0),
('各source rps数据输入',0,'flink_taskmanager_job_task_operator_dtNumRecordsInResolveRate', 1, now(), now(), 0),
('各source 总数据输入',0,'flink_taskmanager_job_task_operator_dtNumRecordsIn', 1, now(), now(), 0),
('各source bps数据输入',0,'flink_taskmanager_job_task_operator_dtNumBytesInRate', 1, now(), now(), 0),
('各source的脏数据',0,'flink_taskmanager_job_task_operator_dtDirtyData', 1, now(), now(), 0),
('各sink rps输出',0,'flink_taskmanager_job_task_operator_dtNumRecordsOutRate', 1, now(), now(), 0),
('各Sink的脏数据输出',0,'flink_taskmanager_job_task_operator_dtNumDirtyRecordsOut', 1, now(), now(), 0),
('数据延迟',0,'flink_taskmanager_job_task_operator_topic_partition_dtTopicPartitionLag', 1, now(), now(), 0);

-- 实时采集任务
insert into `rdos_stream_metric_support` (`name`, `task_type`, `value`, `metric_tag`, `gmt_modified`, `gmt_create`, `is_deleted`)
values
('输入rps',11,'flink_taskmanager_job_task_operator_flinkx_numReadPerSecond', 1, now(), now(), 0),
('输出rps',11,'flink_taskmanager_job_task_operator_flinkx_numWritePerSecond', 1, now(), now(), 0),
('输入bps',11,'flink_taskmanager_job_task_operator_flinkx_byteReadPerSecond', 1, now(), now(), 0),
('输出bps',11,'flink_taskmanager_job_task_operator_flinkx_byteWritePerSecond', 1, now(), now(), 0),
('累计输入记录数',11,'flink_taskmanager_job_task_operator_flinkx_numRead', 1, now(), now(), 0),
('累计输出记录数',11,'flink_taskmanager_job_task_operator_flinkx_numWrite', 1, now(), now(), 0),
('累计输入数据量',11,'flink_taskmanager_job_task_operator_flinkx_byteRead', 1, now(), now(), 0),
('累计输出数据量',11,'flink_taskmanager_job_task_operator_flinkx_byteWrite', 1, now(), now(), 0);