ALTER TABLE dl_table_sync ADD priority int(2) DEFAULT 1 COMMENT '任务优先级';
ALTER TABLE dl_table_sync ADD tag_id int(11) DEFAULT NULL COMMENT '标签id';
