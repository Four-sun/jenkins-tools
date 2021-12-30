
ALTER TABLE `assets_data_table_column`
    ADD COLUMN `col_extra_attribute` json NULL COMMENT '字段属性（json字符串）' AFTER `col_sub_model_id`;
