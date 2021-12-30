ALTER TABLE `ide`.`rdos_file_merge_rule`
DROP INDEX `idx`;

ALTER TABLE `ide`.`rdos_file_merge_rule`
DROP COLUMN `table_id`,
DROP COLUMN `table_name`,
DROP COLUMN `is_partition`,
DROP COLUMN `location`,
DROP COLUMN `merge_date`,
DROP COLUMN `merge_time`,
DROP COLUMN `partition_info`,
ADD COLUMN `rule_name` varchar(255) DEFAULT NULL COMMENT '规则名称' ,
ADD COLUMN `merge_type` tinyint(1) NOT NULL DEFAULT 2 COMMENT '治理方式:1 周期治理 2一次性治理',
ADD COLUMN `schedule_conf` varchar(512) NULL COMMENT '调度配置 ：json字符串和任务的调度配置类似;' ,
ADD COLUMN `file_count` int(11) NOT NULL DEFAULT 0 COMMENT '需要治理的文件数量' ,
ADD COLUMN `storage` double NOT NULL DEFAULT 0 COMMENT '容量大小';


ALTER TABLE `ide`.`rdos_hive_table_info`
ADD COLUMN `is_partition` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否分区表 默认非分区';


ALTER TABLE `ide`.`rdos_batch_hive_table_partition`
ADD COLUMN `partition_name` varchar(255) DEFAULT NULL COMMENT '分区名称',
ADD COLUMN `file_count` int(11) NULL DEFAULT 0 COMMENT '文件数量' ,
ADD COLUMN `last_ddl_time` datetime(0) NOT NULL COMMENT '文件最后修改时间';


ALTER TABLE `ide`.`rdos_file_merge_partition`
DROP COLUMN `bak_status`;

ALTER TABLE `ide`.`rdos_file_merge_record`
MODIFY COLUMN `error_msg` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '错误信息' ,
ADD COLUMN `plan_time` datetime NOT NULL COMMENT '计划时间';


ALTER TABLE `ide`.`rdos_file_merge_partition`
MODIFY COLUMN `error_msg` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '错误信息' ;

ALTER TABLE `ide`.`rdos_batch_hive_table_partition`
DROP INDEX `unique_idx`