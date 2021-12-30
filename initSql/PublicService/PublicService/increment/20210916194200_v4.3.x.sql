-- redis授权给数据服务
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
    ( 3,'Redis', '', 0, '2021-09-16 14:34:21', '2021-09-16 14:34:21', 0, 0);

-- Solr、ES7的可授权产品增加离线
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
  ( 1,'Solr', '7.x', 0, '2021-09-16 19:44:21', '2021-09-16 19:44:21', 0, 0),
  ( 1,'Elasticsearch', '7.x', 0, '2021-09-16 19:44:21', '2021-09-16 19:44:21', 0, 0);

-- es7和redis支持授权数据资产
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
  ( 9,'Redis', '', 0, '2021-09-16 19:44:21', '2021-09-16 19:44:21', 0, 0),
  ( 9,'Elasticsearch', '7.x', 0, '2021-09-16 19:44:21', '2021-09-16 19:44:21', 0, 0);

-- SQLServer改名，中间增加个空格SQL Server
update dsc_type set data_type = 'SQL Server' where data_type = 'SQLServer';
update dsc_info set data_type = 'SQL Server' where data_type_code = 3;
update dsc_app_mapping set data_type = 'SQL Server' where data_type = 'SQLServer';
update dsc_form_field set type_version = 'SQL Server' where type_version = 'SQLServer';




-- SQLServer JDBC改名，中间增加个空格SQL Server JDBC
update dsc_type set data_type = 'SQL Server JDBC' where data_type = 'SQLServer JDBC';
update dsc_info set data_type = 'SQL Server JDBC' where data_type_code = 32;
update dsc_app_mapping set data_type = 'SQL Server JDBC' where data_type = 'SQLServer JDBC';
update dsc_form_field set type_version = 'SQL Server JDBC' where type_version = 'SQLServer JDBC';


-- 增加kafka TBDS版本
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 'Kafka', 'TBDS', 5, 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);

-- 授权给实时
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	(7, 'Kafka', 'TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);

-- kafka原来的版本form_field加上kafkaReactAuth属性列
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)
VALUES
   ('KafkaAuthReact', 'KafkaAuthReact', 'KafkaAuthReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL,'Kafka-0.9',0,  '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('KafkaAuthReact', 'KafkaAuthReact', 'KafkaAuthReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL,'Kafka-0.10',0,  '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('KafkaAuthReact', 'KafkaAuthReact', 'KafkaAuthReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL,'Kafka-0.11',0,  '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('KafkaAuthReact', 'KafkaAuthReact', 'KafkaAuthReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL,'Kafka-1.x',0,  '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('KafkaAuthReact', 'KafkaAuthReact', 'KafkaAuthReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL,'Kafka-2.x',0,  '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,'');

-- dsc_form_field表新增几条和Kafka-TBDS相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)
VALUES
   ('kafkaReact', 'kafkaReact', 'KafkaReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL,'Kafka-TBDS',0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('tbds_id', 'ID', 'Input', 1, 0, NULL, '请输入ID', NULL, 0, '', NULL, NULL, NULL, 'Kafka-TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('tbds_key', 'KEY', 'Input', 1, 0, NULL, '请输入KEY', NULL, 0, '', NULL, NULL, NULL, 'Kafka-TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,'');


-- 增加HBase TBDS版本
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 'HBase', 'TBDS', 3, 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);

-- 授权给实时
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	(7, 'HBase', 'TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);


-- dsc_form_field表新增几条和HBase-TBDS相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)
VALUES
   ('hbase_quorum', '集群地址', 'TextArea', 1, 0, NULL, '集群地址，例如：IP1:Port,IP2:Port,IP3:Port/子目录', NULL, 1, '', NULL, NULL, NULL, 'HBase-TBDS', 0, '2021-03-23 20:38:06', '2021-03-30 16:08:46', 0, 0,''),
   ('hbase_parent', '根目录', 'Input', 0, 0, NULL, 'ZooKeeper中hbase创建的根目录，例如：/hbase', NULL, 0, '', NULL, NULL, NULL, 'HBase-TBDS', 0, '2021-03-23 20:38:06', '2021-03-30 16:08:46', 0, 0,''),
   ('hbase_other', '其他参数', 'TextArea', 0, 0, NULL, 'hbase.rootdir\": \"hdfs: //ip:9000/hbase', NULL, 0, '', NULL, NULL, NULL, 'HBase-TBDS', 0, '2021-03-23 20:38:06', '2021-03-30 16:08:46', 0, 0,''),
   ('tbds_username', 'USERNAME', 'Input', 1, 0, NULL, '请输入username', NULL, 0, '', NULL, NULL, NULL, 'HBase-TBDS', 0, '2021-10-15 10:38:27', '2021-10-15 10:38:27', 0, 0,''),
   ('tbds_id', 'ID', 'Input', 1, 0, NULL, '请输入ID', NULL, 0, '', NULL, NULL, NULL,'HBase-TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('tbds_key', 'KEY', 'Input', 1, 0, NULL, '请输入KEY', NULL, 0, '', NULL, NULL, NULL, 'HBase-TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,'');

-- 原来的HDFS改为HDFS-2.x
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 'HDFS', '2.x', 0, 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);

-- hdfs类型的数据源版本号改为2.x
update dsc_info set data_version = '2.x' where data_type_code = 6;

update dsc_app_mapping set data_version = '2.x' where data_type = 'HDFS';

update dsc_form_field set type_version = 'HDFS-2.x' where type_version = 'HDFS';

-- 增加HDFS TBDS版本
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 'HDFS', 'TBDS', 1, 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);

-- 授权给实时
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	(7, 'HDFS', 'TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0);


-- dsc_form_field表新增几条和HDFS-TBDS相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)
VALUES
   ('defaultFS', 'defaultFS', 'Input', 1, 0, NULL, 'hdfs://host:port', NULL, 1, '', NULL, NULL, NULL, 'HDFS-TBDS', 0, '2021-03-23 20:38:06', '2021-03-30 16:08:46', 0, 0,''),
   ('hadoopConfig', '高可用配置', 'TextAreaWithCopy', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'HDFS-TBDS', 0, '2021-03-23 20:38:06', '2021-03-30 16:08:46', 0, 0,''),
   ('tbds_username', 'USERNAME', 'Input', 1, 0, NULL, '请输入username', NULL, 0, '', NULL, NULL, NULL, 'HDFS-TBDS', 0, '2021-10-15 10:38:27', '2021-10-15 10:38:27', 0, 0,''),
   ('tbds_id', 'ID', 'Input', 1, 0, NULL, '请输入ID', NULL, 0, '', NULL, NULL, NULL,'HDFS-TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,''),
   ('tbds_key', 'KEY', 'Input', 1, 0, NULL, '请输入KEY', NULL, 0, '', NULL, NULL, NULL, 'HDFS-TBDS', 0, '2021-09-17 10:38:27', '2021-09-17 10:38:27', 0, 0,'');











