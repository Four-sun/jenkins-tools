
-- 任务版本号
BEGIN ;
    alter table rdos_batch_task_version add column `task_params` text NOT NULL COMMENT '环境参数';
    alter table rdos_batch_task_version add column `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式';
    alter table rdos_batch_task_version add column `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停';
    alter table rdos_batch_task_version add column `dependency_task_ids` text NOT NULL COMMENT '依赖的任务id，多个以,号隔开';

    alter table rdos_stream_task_version add column `task_params` text NOT NULL COMMENT '环境参数';
COMMIT;

update rdos_batch_task_version set schedule_conf='{"selfReliance":0, "min":0,"hour":0,"periodType":"2","beginDate":"2001-01-01","endDate":"2121-01-01"}', schedule_status=1,
    task_params='##Number of CPU cores need driver program is running
##driver.cores=1

##Each Spark action (collect) limits the total size of the serialized results of all partitions. Setting value should not be less than 1M, 0 means no limit. If the total exceeds this limit, the program will terminate. Limit values may cause memory overflow error driver (dependent on spark. driver. memory and objects in the JVM\'s memory consumption).
##driver.maxResultSize=1g

##Driver number memory used by a process
##driver.memory=512m


##Amount of memory used by each executor process. And JVM memory strings have the same format (for example, 512m, 2G)
##executor.memory=512m


##Amount of memory used by each executor process. And JVM memory strings have the same format (for example, 512m, 2G)
##logConf=spark.logConf'
where schedule_status=0;



-- 优化displayOffSpring接口，添加对jobkey 的索引
ALTER TABLE `rdos_batch_job` ADD INDEX idx_jobKey ( `job_key`(128));
ALTER TABLE `rdos_batch_job_job` ADD INDEX idx_job_parentJobKey ( `job_key`(128), `parent_job_key`(128));

--
alter table rdos_batch_hive_select_sql add column `user_id` int(11) NULL COMMENT '执行用户';
alter table rdos_batch_hive_select_sql add column `sql_text` text NULL COMMENT 'sql';


-- 在dict中添加数据模型原子、衍生指标支持的数据类型
INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('9', 'STRING', '1', 'STRING', 'STRING', '1', now(), now(), '0'),
('9', 'TINYINT', '2', 'TINYINT', 'TINYINT', '2', now(), now(), '0'),
('9', 'SMALLINT', '3', 'SMALLINT', 'SMALLINT', '3', now(), now(), '0'),
('9', 'INT', '4', 'INT', 'INT', '4', now(), now(), '0'),
('9', 'BIGINT', '5', 'BIGINT', 'BIGINT', '5', now(), now(), '0'),
('9', 'BOOLEAN', '6', 'BOOLEAN', 'BOOLEAN', '6', now(), now(), '0'),
('9', 'FLOAT', '7', 'FLOAT', 'FLOAT', '7', now(), now(), '0'),
('9', 'DOUBLE', '8', 'DOUBLE', 'DOUBLE', '8', now(), now(), '0'),
('9', 'BINARY', '9', 'BINARY', 'BINARY', '9', now(), now(), '0'),
('9', 'TIMESTAMP', '10', 'TIMESTAMP', 'TIMESTAMP', '10', now(), now(), '0'),
('9', 'DECIMAL', '11', 'DECIMAL', 'DECIMAL', '11', now(), now(), '0'),
('9', 'DATE', '12', 'DATE', 'DATE', '12', now(), now(), '0'),
('9', 'VARCHAR', '13', 'VARCHAR', 'VARCHAR', '13', now(), now(), '0'),
('9', 'CHAR', '14', 'CHAR', 'CHAR', '14', now(), now(), '0');