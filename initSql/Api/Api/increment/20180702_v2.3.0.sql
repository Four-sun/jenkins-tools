-- API改造增加字段
ALTER TABLE da_api ADD COLUMN req_type INT (11) DEFAULT 1;
ALTER TABLE da_api ADD COLUMN api_path VARCHAR (255);
ALTER TABLE da_api ADD COLUMN resp_page_size INT (11);
ALTER TABLE da_api ADD COLUMN param_cfg_type INT (11);
ALTER TABLE da_api ADD COLUMN allow_paging INT (11);
ALTER TABLE da_api ADD COLUMN data_src_type INT (11);
ALTER TABLE da_api ADD COLUMN config_sql VARCHAR (255);
ALTER TABLE da_api ADD COLUMN resp_json text;
ALTER TABLE da_api_apply ADD COLUMN call_limit INT (11);
ALTER TABLE da_api_apply ADD COLUMN begin_time datetime;
ALTER TABLE da_api_apply ADD COLUMN end_time datetime;

-- API改造将字段设置为可以为空
ALTER TABLE da_api MODIFY COLUMN cat_id INT (11) COMMENT '类目ID';
ALTER TABLE da_api MODIFY COLUMN data_src_id INT (11);
ALTER TABLE da_api MODIFY COLUMN name varchar(255);
ALTER TABLE da_api MODIFY COLUMN tableName varchar(64);
ALTER TABLE da_api MODIFY COLUMN req_limit INT (11) COMMENT '访问限制';
ALTER TABLE da_api MODIFY COLUMN resp_limit INT (11);
ALTER TABLE da_api MODIFY COLUMN input_params text;
ALTER TABLE da_api MODIFY COLUMN output_params text;

-- 增加数据源类型
INSERT INTO `da_dict` VALUES ('4', '1', 'AnalyticDB', '11', 'AnalyticDB', 'AnalyticDB', '4', now(), now(), '0');

-- 创建表，用于api再次申请
CREATE TABLE `da_apply_invoke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL COMMENT '用户',
  `api_id` int(11) NOT NULL,
  `invoke_total` bigint(11) DEFAULT NULL COMMENT '调用总计',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_apiId_isdeleted` (`user_id`,`api_id`,`is_deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 向新表中添加原有数据
INSERT INTO da_apply_invoke ( user_id, api_id, invoke_total ) ( SELECT user_id, api_id, invoke_total FROM da_snapshot_invoke );