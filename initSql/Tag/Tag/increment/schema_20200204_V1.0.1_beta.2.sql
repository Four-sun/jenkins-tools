ALTER TABLE da_index_update_record ADD create_by int(11) DEFAULT 0 NULL COMMENT '默认为0';
ALTER TABLE da_index_update_record  ADD update_by int(11) DEFAULT 0 NULL COMMENT '默认为0';