ALTER TABLE dl_api ADD api_id int(11) DEFAULT NULL COMMENT '数据服务 apiId';
ALTER TABLE dl_api CHANGE api_id api_id int(11) DEFAULT NULL COMMENT '数据服务 apiId' AFTER project_id;

ALTER TABLE dl_api ADD api_type tinyint(1) DEFAULT NULL COMMENT '数据服务 api 类型';
ALTER TABLE dl_api CHANGE api_type api_type tinyint(1) DEFAULT NULL COMMENT '数据服务 api 类型' AFTER api_id;