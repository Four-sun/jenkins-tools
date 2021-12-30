-- sparkThrift授权增加资产
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	(9, 'SparkThrift', 0, '2021-06-15 10:51:24', '2021-06-15 10:51:24', 0, 0);

-- sparkThrift的form表单修改其jdbcUrl的示例和正则
update dsc_form_field set `tooltip` = '示例：jdbc:hive2://host:port/dbName',`regex` = '/jdbc:hive2:\\/\\/(.)+/' where type_version = 'SparkThrift' and `name` = 'jdbcUrl';

-- 所有数据源的form表单的密码都改为非必填
update dsc_form_field set `required` = 0 where name = 'password';


-- EMQ数据源的address的is_link改为1
update dsc_form_field set is_link = 1 where type_version = 'EMQ' and name = 'address';