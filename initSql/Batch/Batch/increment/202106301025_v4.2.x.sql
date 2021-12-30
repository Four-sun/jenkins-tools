-- 删除数据地图中非hive（1）、tidb（3）、adb（7） 表
update rdos_hive_table_info set is_deleted = 1, gmt_modified = now() where is_deleted = 0 and table_type not in (1, 3, 7);
