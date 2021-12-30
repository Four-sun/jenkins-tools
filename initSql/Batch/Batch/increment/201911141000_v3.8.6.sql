ALTER TABLE `ide`.`rdos_datamask_config`
DROP INDEX `unique_table_id_column`;

ALTER TABLE `ide`.`rdos_batch_table_relation`
ADD COLUMN `relation_result_type` int(11) NOT NULL DEFAULT '0' COMMENT '对应表在sql中类型 0:依赖表 1:主表';