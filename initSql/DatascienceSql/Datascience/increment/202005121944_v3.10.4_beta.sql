ALTER TABLE science_hive_table_info ADD COLUMN life_check_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '表生命周期检查时间';
ALTER TABLE science_hive_table_info ADD INDEX `idx_life_check`(`life_check_time`) USING BTREE COMMENT '表生命检查时间索引';

