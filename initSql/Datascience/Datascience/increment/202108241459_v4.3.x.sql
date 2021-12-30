-- 性能优化，science_task 表增加索引
ALTER TABLE `science_task` ADD INDEX project_id_name (`project_id`, `name`);
ALTER TABLE `science_task` ADD INDEX flow_id_component_type (`flow_id`,`component_type`);
ALTER TABLE `science_task` ADD INDEX tenant_id (`tenant_id`);
ALTER TABLE `science_task` ADD INDEX node_pid (`node_pid`);

-- science_task_version 增加索引

ALTER TABLE `science_task_version` ADD INDEX project_id (`project_id`);

-- science_task_task 增加索引
ALTER TABLE `science_task_task` DROP INDEX `index_batch_task_task`,
ADD UNIQUE INDEX `index_batch_task_task` (`task_id`,`parent_task_id`,`project_id`) USING BTREE;

-- drop 无用表
DROP TABLE if EXISTS science_data_source;
DROP TABLE if EXISTS science_datamask_columns_info;
DROP TABLE if EXISTS science_datamask_config;
DROP TABLE if EXISTS science_datamask_rule;
DROP TABLE if EXISTS science_distribute_lock;
DROP TABLE if EXISTS science_hive_table_column;
DROP TABLE if EXISTS science_hive_table_partition;