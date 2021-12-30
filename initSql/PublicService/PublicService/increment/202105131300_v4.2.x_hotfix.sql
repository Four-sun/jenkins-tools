-- 模型中的列表增加【是否为分区】字段
ALTER TABLE `dt_pub_service`.`dm_column`
ADD COLUMN `is_partition` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为分区字段（默认0） 0-非分区字段 1-分区字段' AFTER `is_metric`;