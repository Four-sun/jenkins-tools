-- dsc_info表data_type_code字段改为非必填默认值为0
ALTER TABLE `dsc_info` CHANGE COLUMN `data_type_code` `data_type_code` tinyint(4) NOT NULL DEFAULT 0 COMMENT '数据源类型编码';