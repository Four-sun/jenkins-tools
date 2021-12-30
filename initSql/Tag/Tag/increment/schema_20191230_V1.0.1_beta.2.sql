ALTER TABLE da_column_data CHANGE data_source_id data_source_url varchar(512) NOT NULL COMMENT '数据源url';
ALTER TABLE da_column_data_value CHANGE data_source_id data_source_url varchar(512) NOT NULL COMMENT '数据源url';
ALTER TABLE da_index_update_record CHANGE data_source_id data_source_url varchar(512) NOT NULL COMMENT '数据源url';

ALTER TABLE da_index_update_record ADD create_by int(11) DEFAULT 0 NULL COMMENT '默认为0';
ALTER TABLE da_index_update_record ADD update_by int(11) DEFAULT 0 NULL COMMENT '默认为0';

ALTER TABLE da_column_data ADD create_by int(11) DEFAULT 0 NULL COMMENT '默认为0';
ALTER TABLE da_column_data ADD update_by int(11) DEFAULT 0 NULL COMMENT '默认为0';

ALTER TABLE da_column_data_value ADD create_by int(11) DEFAULT 0 NULL COMMENT '默认为0';
ALTER TABLE da_column_data_value ADD update_by int(11) DEFAULT 0 NULL COMMENT '默认为0';
