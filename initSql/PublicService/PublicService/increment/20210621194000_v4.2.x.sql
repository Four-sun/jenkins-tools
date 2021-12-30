-- 修改ADB_PostgreSQL数据源data_type_code值
update dsc_info
	set data_type_code = 54
	where data_type = 'ADB_PostgreSQL';

-- dsc_form_field表增加options字段
ALTER TABLE `dsc_form_field` ADD COLUMN `options` varchar(256) DEFAULT '' COMMENT 'select组件下拉内容' AFTER `type_version`;


-- 离线添加AWS S3数据源
-- 往dsc_type表新增 AWS S3类型数据源
INSERT INTO `dsc_type` (`data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
   ('AWS S3', 6, 0.0, 'AWS S3.png', 0, '2021-06-21 19:48:27', '2021-06-21 19:48:27', 0, 0, 1575, 0);


-- 在数据源和产品映射表dsc_app_mapping表中新增一条数据
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 1, 'AWS S3', '', 0, '2021-06-21 19:48:27', '2021-06-21 19:48:27', 0, 0);

-- dsc_form_field表新增几条和AWS S3相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)VALUES
	('region', 'Region', 'Select', 1, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL, 'AWS S3', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0,"[{key:'1',value:'cn-north-1',label:'cn-north-1 (北京)'},{key:'2',value:'cn-northwest-1',label:'cnnorthwest-1 (宁夏)'}]"),
('accessKey', 'ACCESS KEY', 'Input', 1, 0, NULL, NULL, NULL, 1, '', NULL, NULL, NULL, 'AWS S3', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0,''),
	('secretKey', 'SECRET KEY', 'Password', 1, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'AWS S3', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0,'');


-- 离线添加inceptor数据源
-- 往dsc_type表新增 AWS S3类型数据源
INSERT INTO `dsc_type` (`data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
   ('Inceptor', 4, 0.0, 'Inceptor.png', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0, 1875, 0);


-- 在数据源和产品映射表dsc_app_mapping表中新增一条数据
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 1, 'Inceptor', '', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0);

-- dsc_form_field表新增几条和Inceptor相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
   ('jdbcUrl', 'JDBC URL', 'Input', 1, 0, NULL, NULL, NULL, 1,  '{\"regex\":{\"message\":\"JDBC URL格式不符合规则!\"}}', '示例：jdbc:hive2://host:port/dbName', NULL, '/jdbc:(\\w|:)+:\\/\\/(.)+/', 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0),
	('username', '用户名', 'Input', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0),
	('password', '密码', 'Password', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0),
	('defaultFS', 'defaultFS', 'Input', 1, 0, NULL, 'hdfs://host:port', NULL, 1, '', NULL, NULL, NULL, 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0),
	('hiveMetastoreUris', 'hive.metastore.uris', 'Input', 0, 0, NULL, '', NULL, 0, '', 'hive.metastore.uris仅在做事务表的写同步时必填', NULL, NULL, 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0),
	('hadoopConfig', '高可用配置', 'TextAreaWithCopy', 0, 0, NULL, '{\n\"dfs.nameservices\": \"defaultDfs\", \n\"dfs.ha.namenodes.defaultDfs\": \"namenode1\", \n\"dfs.namenode.rpc-address.defaultDfs.namenode1\": \"\", \n\"dfs.client.failover.proxy.provider.defaultDfs\": \"org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider\" \n}', NULL, 0, '', '高可用模式下的填写规则：\n1、分别要填写：nameservice名称、 namenode名称（多个以逗号分隔）、proxy.provider参数；\n2、所有参数以JSON格式填写；\n3、格式为：\n\"dfs.nameservices\": \"nameservice名称\", \"dfs.ha.namenodes.nameservice名称\": \"namenode名称，以逗号分隔\", \"dfs.namenode.rpc-address.nameservice名称.namenode名称\": \"\", \"dfs.namenode.rpc-address.nameservice名称.namenode名称\": \"\", \"dfs.client.failover.proxy.provider.\nnameservice名称\": \"org.apache.hadoop.\nhdfs.server.namenode.ha.\nConfiguredFailoverProxyProvider\"\n4、详细参数含义请参考《帮助文档》或<a href=\'http://hadoop.apache.org/docs/r2.7.4/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html\'>Hadoop官方文档</a>', NULL, NULL, 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0),
	('openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Inceptor', 0, '2021-06-21 22:07:27', '2021-06-21 22:07:27', 0, 0);


-- InfluxDb formFiled表修改URL的name
update `dsc_form_field` set `name` = 'url' where type_version = "InfluxDB-1.x" and `label` = 'URL';

-- SparkThrift给离线授权权限
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 1, 'SparkThrift', '', 0, '2021-06-28 10:08:27', '2021-06-28 10:08:27', 0, 0);

-- SQLServer数据源，提示文案调整+去掉jdbc格式校验
update `dsc_form_field` set valid_info = '',
tooltip = '示例：jdbc:sqlserver://localhost:1433;DatabaseName=dbName\n或\n jdbc:jtds:sqlserver://localhost:1433/dbName',
regex = '' where type_version = 'SQLServer' and `name` = 'jdbcUrl';

-- GaussDB的正则校验和p
update `dsc_form_field` set tooltip = '示例：jdbc:postgresql://host:port/database',
regex = '/jdbc:postgresql:\\/\\/(.)+/' where type_version = 'GaussDB' and name = 'jdbcUrl';


-- 历史数据LibrA改成GaussDB
update dsc_info set data_type = 'GaussDB' where data_type = 'LibrA';

-- AnalyticDB数据源给api授权
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
(3, 'AnalyticDB', '', 0, '2021-06-28 21:06:21', '2021-06-28 21:06:21', 0, 0);


