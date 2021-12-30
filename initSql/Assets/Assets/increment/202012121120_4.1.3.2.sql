-- TiDB表元模型技术属性-存储大小-field_type
update assets_model_attribute set field_type = 7 where data_source_type = 31 and field_type = 6 and attribute_type = 0 and attribute_name = 'total_size';
update assets_model_attribute set attribute_name = 'storage_size' where attribute_name = 'total_size';
update assets_preset_model_attribute set field_type = 7 where data_source_type = 31 and field_type = 6 and attribute_type = 0 and attribute_name = 'total_size';
update assets_preset_model_attribute set attribute_name = 'storage_size' where attribute_name = 'total_size';

CREATE TABLE `assets_data_source_type` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '创建人',
	`update_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '更新人',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
	`data_source_type_name` VARCHAR(255) NOT NULL COMMENT '数据源名称',
	`data_source_type_code` INT(11) NOT NULL DEFAULT '0' COMMENT '数据源类型code,1000起',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	PRIMARY KEY (`id`)
)ENGINE = InnoDB DEFAULT CHARSET=utf8 COMMENT ='自定义数据源类型表';

ALTER TABLE `assets_data_source` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_db` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_table` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_table_column` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_model_sub_management` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_model_attribute` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_check_record` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_preset_model_attribute` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_table_batch_manage` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_db_batch_manage` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_value_rank` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_statistic` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_statistic_table_storage` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_statistic_database_storage` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_distribution` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_resource` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_fill_rate_statistic` MODIFY `data_source_type` INT(11)  NULL DEFAULT NULL  COMMENT '数据源类型';
ALTER TABLE `assets_biz_attr_fill_rate_statistic` MODIFY `data_source_type` INT(11) NULL DEFAULT NULL COMMENT '数据源类型';
ALTER TABLE `assets_fill_rate_total_statistic` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_db_lineage_statistics` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';
ALTER TABLE `assets_data_masking_table` MODIFY `data_source_type` INT(11) NOT NULL COMMENT '数据源类型';