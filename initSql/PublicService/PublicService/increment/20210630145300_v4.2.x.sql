-- kafka2.x和0.10给数据质量授权权限
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	( 2, 'Kafka', '2.x', 0, '2021-06-30 14:55:21', '2021-06-30 14:55:21', 0, 0),
	( 2, 'Kafka', '0.10', 0, '2021-06-30 14:55:21', '2021-06-30 14:55:21', 0, 0);