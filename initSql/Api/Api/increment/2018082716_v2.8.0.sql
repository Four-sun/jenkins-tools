-- 添加PostgreSQL数据源类型
INSERT INTO `da_dict` VALUES ('5', '1', 'PostgreSQL', '4', 'PostgreSQL', 'PostgreSQL', '5', now(), now(), '0');
-- 更新AnalyticDB的value值，保持和ide一致
UPDATE `da_dict` set dict_value = 15 where dict_name = 'AnalyticDB';
update da_data_source set type = 15 where type = 11;