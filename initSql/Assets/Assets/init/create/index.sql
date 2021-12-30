-- 新增索引
ALTER TABLE `assets_data_table`
  ADD INDEX `idx_dbid` (`db_id`) USING BTREE,
  ADD INDEX `idx_table_name` (`table_name`)  USING BTREE,
  ADD INDEX `idx_sync_status` (`sync_status`) USING BTREE,
  ADD INDEX `idx_table_owner` (`table_owner`) USING BTREE,
  ADD INDEX `idx_table_datasource_id` (`data_source_id`) USING BTREE,
  ADD INDEX `idx_ck_1` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `table_hot`) USING BTREE,
  ADD INDEX `idx_ck_2` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `table_create_at`) USING BTREE,
  ADD INDEX `idx_ck_3` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `table_storage`) USING BTREE,
  ADD INDEX `idx_ck_4` (`tenant_id`, `data_source_type`, `is_deleted`, `sync_status`, `update_at`) USING BTREE;


ALTER TABLE `assets_data_db`
  ADD INDEX `idx_sub_model_id` (`sub_model_id`) USING BTREE,
  ADD INDEX `idx_use_status` (`use_status`) USING BTREE,
  ADD INDEX `idx_db_datasource_id` (`data_source_id`) USING BTREE,
  ADD INDEX `idx_ck_1` (`is_deleted`, `tenant_id`, `data_source_type`) USING BTREE;

ALTER TABLE `assets_data_table_column`
  ADD INDEX `idx_column_name` (`column_name`) USING BTREE,
  ADD INDEX `idx_table_id` (`table_id`) USING BTREE,
  ADD INDEX `idx_db_id` (`db_id`) USING BTREE,
  ADD INDEX `idx_column_source_id` (`data_source_id`) USING BTREE,
  ADD INDEX `idx_table_owner` (`table_owner`) USING BTREE,
  ADD INDEX `idx_ck_1` (`tenant_id`, `data_source_type`,`is_deleted`,`table_hot`) USING BTREE,
  ADD INDEX `idx_ck_2` (`tenant_id`, `data_source_type`,`is_deleted`,`table_create_at`) USING BTREE,
  ADD INDEX `idx_ck_3` (`tenant_id`, `data_source_type`,`is_deleted`,`table_storage`) USING BTREE,
  ADD INDEX `idx_ck_4` (`tenant_id`, `data_source_type`,`is_deleted`,`update_at`) USING BTREE;


ALTER TABLE `assets_data_table_index`
  ADD INDEX `idx_table_id` (`table_id`) USING BTREE;

ALTER TABLE `assets_data_table_partition`
  ADD INDEX `idx_table_id` (`table_id`) USING BTREE;

ALTER TABLE `assets_sync_job`
  ADD INDEX `idx_task_id` (`task_id`) USING BTREE,
  ADD INDEX `idx_job_id` (`job_id`) USING BTREE;


ALTER TABLE `assets_role_user`
  ADD INDEX `idx_roleid_userid` (`role_id`, `user_id`) USING BTREE;

ALTER TABLE `assets_user`
  ADD INDEX `idx_dtuic_userid` (`dtuic_user_id`) USING BTREE;

ALTER TABLE `assets_model_attribute`
  ADD INDEX `idx_sourcetype` (`data_source_type`) USING BTREE,
  ADD INDEX `idx_attributetype` (`attribute_type`) USING BTREE;

ALTER TABLE `assets_model_sub_management`
  ADD INDEX `idx_datasource_type` (`data_source_type`) USING BTREE;

ALTER TABLE `assets_model_attribute_value_set`
  ADD INDEX `idx_attribute_id` (`attribute_id`) USING BTREE;

ALTER TABLE `assets_sync_job`
  ADD UNIQUE INDEX `uk_job_id` (`job_id`) USING BTREE;

ALTER TABLE `assets_sync_job_thread`
  ADD UNIQUE INDEX `uk_job_id_thread_id` (`job_id`,`thread_id`) USING BTREE;

ALTER TABLE `assets_model_column_attribute`
    ADD INDEX `idx_column_id` (`column_id`) USING BTREE,
    ADD INDEX `idx_table_id` (`table_id`) USING BTREE;

ALTER TABLE `assets_model_column_attribute`
    ADD INDEX `idx_attribute_id` (`attribute_id`) USING BTREE;

-- 数据资源
ALTER TABLE `assets_resource`
  ADD UNIQUE INDEX `uk_data_id_resource_type` (`data_id`, `resource_type`),
	ADD INDEX `idx_db_id` (`db_id`),
	ADD INDEX `idx_table_id` (`table_id`);


ALTER TABLE `assets_data_masking_table`
    ADD INDEX `idx_ds_db_table_col_name` (`data_source_name`, `db_name`, `table_name`, `column_name`);

ALTER TABLE `assets_db_lineage_statistics`
	ADD UNIQUE INDEX `idx_db_id` (`db_id`);

ALTER TABLE `assets_version_record`
	ADD  INDEX `idx_table_id` (`table_id`);

ALTER TABLE `assets_resource_display` ADD UNIQUE (`user_id`);
