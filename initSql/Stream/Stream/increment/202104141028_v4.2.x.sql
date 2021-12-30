-- 实时计算向导模式新增数据源PostgreSQL
INSERT INTO `rdos_stream_support_data_source` (`type`, `data_source_name`, `data_source_value`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES (5, 'PostgreSQL', 4, now(), now(), 0);

-- 实时计算脚本模式新增数据源PostgreSQL
INSERT INTO `rdos_stream_support_data_source` (`type`, `data_source_name`, `data_source_value`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES (7, 'PostgreSQL', 4, now(), now(), 0);