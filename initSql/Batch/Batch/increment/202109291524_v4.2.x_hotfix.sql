-- 修改rdos_hive_table_info表location字段类型
ALTER TABLE `rdos_hive_table_info`
    MODIFY COLUMN `location` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hdfs路径' AFTER `path`;

-- 修改rdos_hive_table_info_deleted表location字段类型
ALTER TABLE `rdos_hive_table_info_deleted`
    MODIFY COLUMN `location` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hdfs路径' AFTER `path`;