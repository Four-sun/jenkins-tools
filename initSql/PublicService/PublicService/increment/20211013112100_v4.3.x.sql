-- 扩展表
CREATE TABLE `lc_table_life_extend` (
                                        `id` int(11) NOT NULL AUTO_INCREMENT,
                                        `lc_table_id` int(11) NOT NULL COMMENT 'lc_table的主键',
                                        `timing` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '生成的时间,每个时间空格分开',
                                        `clean_before_day` int(11) NOT NULL COMMENT '清理多久之前数据',
                                        `yesterday` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '昨天日期',
                                        PRIMARY KEY (`id`),
                                        UNIQUE KEY `lc_table` (`lc_table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- 支持处理的类型
INSERT INTO lc_table_process(app_type,data_type_code,life_process) VALUES(4,59,'timingTable');