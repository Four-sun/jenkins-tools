-- 逻辑删除数据地图中存在的libra表
update rdos_hive_table_info  set is_deleted = 1, gmt_modified = now() where table_type = 2 and is_deleted = 0;
