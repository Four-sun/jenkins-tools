ALTER TABLE `dq_data_source`
CHANGE COLUMN `data_json` `data_json` text NOT NULL COMMENT '链接数据源信息需要加密 json格式' ;
