-- dsc_app_mapping表的data_version默认值改为""
update dsc_app_mapping set `data_version` = '' where `data_version` is null;
ALTER TABLE `dsc_app_mapping` CHANGE COLUMN `data_version` `data_version` varchar(64) DEFAULT '' COMMENT '数据源版本 如1.x, 0.9';


-- dsc_app_mapping新增联合唯一索引
ALTER TABLE `dsc_app_mapping` ADD UNIQUE `uni_ref` USING BTREE (`app_type`, `data_type`, `data_version`);

-- dsc_form_field新增联合唯一索引
ALTER TABLE `dsc_form_field` ADD UNIQUE `uni_ref` USING BTREE (`name`, `type_version`);

-- dsc_import_ref表新增old_data_info_id字段
ALTER TABLE `dsc_import_ref`
ADD COLUMN `old_data_info_id`  int(11) DEFAULT -1 COMMENT '各平台dataSourceId' AFTER `data_info_id`,
ADD COLUMN `dtuic_tenant_id`  bigint(20) DEFAULT 0 COMMENT 'dtuic的租户id' AFTER `old_data_info_id`,
ADD COLUMN `project_id`  bigint(20)  DEFAULT -1 COMMENT '项目id' AFTER `dtuic_tenant_id`;

-- 增加一个数据源类型solr，排序在es后面
INSERT INTO `dsc_type` ( `data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
('Solr',8,0.0,'Solr.png',0,'2021-05-28 11:18:00','2021-05-28 11:18:00',0,0,1100,0);

-- 修改dsc_type表sorted值，通过sorted倒序排序
update  `dsc_type` set sorted=2500 where data_type = 'MySQL';
update  `dsc_type` set sorted=2450 where data_type = 'PolarDB for MySQL8';
update  `dsc_type` set sorted=2400 where data_type = 'Oracle';
update  `dsc_type` set sorted=2350 where data_type = 'SQLServer';
update  `dsc_type` set sorted=2300 where data_type = 'PostgreSQL';
update  `dsc_type` set sorted=2250 where data_type = 'DB2';
update  `dsc_type` set sorted=2200 where data_type = 'DMDB';
update  `dsc_type` set sorted=2100 where data_type = 'KingbaseES8';
update  `dsc_type` set sorted=2050 where data_type = 'Hive';
update  `dsc_type` set sorted=2000 where data_type = 'SparkThrift';
update  `dsc_type` set sorted=1950 where data_type = 'Maxcompute';
update  `dsc_type` set sorted=1900 where data_type = 'Phoenix';
update  `dsc_type` set sorted=1850 where data_type = 'Greenplum';
update  `dsc_type` set sorted=1800 where data_type = 'LibrA';
update  `dsc_type` set sorted=1750 where data_type = 'GBase_8a';
update  `dsc_type` set sorted=1700 where data_type = 'HDFS';
update  `dsc_type` set sorted=1650 where data_type = 'FTP';
update  `dsc_type` set sorted=1600 where data_type = 'S3';
update  `dsc_type` set sorted=1550 where data_type = 'Impala';
update  `dsc_type` set sorted=1500 where data_type = 'ClickHouse';
update  `dsc_type` set sorted=1450 where data_type = 'TiDB';
update  `dsc_type` set sorted=1400 where data_type = 'Kudu';
update  `dsc_type` set sorted=1350 where data_type = 'AnalyticDB';
update  `dsc_type` set sorted=1300 where data_type = 'CarbonData';
update  `dsc_type` set sorted=1250 where data_type = 'Kylin';
update  `dsc_type` set sorted=1200 where data_type = 'HBase';
update  `dsc_type` set sorted=1150 where data_type = 'Elasticsearch';
update  `dsc_type` set sorted=1050 where data_type = 'MongoDB';
update  `dsc_type` set sorted=1000 where data_type = 'Redis';
update  `dsc_type` set sorted=950 where data_type = 'Kafka';
update  `dsc_type` set sorted=900 where data_type = 'EMQ';
update  `dsc_type` set sorted=850 where data_type = 'WebSocket';
update  `dsc_type` set sorted=800 where data_type = 'Socket';
update  `dsc_type` set sorted=750 where data_type = 'Presto';

-- 增加Solr的数据源版本
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	('Solr', '7.x', 0, 0, '2021-05-28 13:49:00', '2021-05-28 13:49:00', 0, 0);

-- Solr数据源只可以授权给实时
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
( 7, 'Solr', '7.x', 0, '2021-05-28 13:49:00', '2021-05-28 13:49:00', 0, 0);


-- Solr数据源新增界面的表单
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	('zkHost', '集群地址', 'TextArea', 1, 0, NULL, '集群地址，例如:ip1:port,ip2:port,ip3:port', NULL, 1, NULL, NULL, NULL, NULL, 'Solr-7.x', 0, '2021-05-28 14:07:00', '2021-05-28 14:07:00', 0, 0),
	('chroot', 'chroot', 'Input', 1, 0, NULL, '请输入Zookeeper chroot路径,例如/Solr', NULL, 1, NULL, NULL, NULL, NULL, 'Solr-7.x', 0, '2021-05-28 14:07:00', '2021-05-28 14:07:00', 0, 0),
	('openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Solr-7.x', 0, '2021-03-23 20:37:29', '2021-03-30 16:08:46', 0, 0)
;


-- 逻辑删除kafka的0.9版本
update  dsc_version  set is_deleted = 1 where data_type = 'Kafka' and data_version = '0.9';

-- kafka数据源新增界面表单

INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	('kafkaReact', 'kafkaReact', 'KafkaReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL, 'Kafka-0.9', 0, '2021-06-01 11:50:07', '2021-06-01 11:50:07', 0, 0),
	('kafkaReact', 'kafkaReact', 'KafkaReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL, 'Kafka-0.10', 0, '2021-06-01 11:50:07', '2021-06-01 11:50:07', 0, 0),
	('kafkaReact', 'kafkaReact', 'KafkaReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL, 'Kafka-0.11', 0, '2021-06-01 11:50:07', '2021-06-01 11:50:07', 0, 0),
	('kafkaReact', 'kafkaReact', 'KafkaReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL, 'Kafka-1.x', 0, '2021-06-01 11:50:07', '2021-06-01 11:50:07', 0, 0),
	('kafkaReact', 'kafkaReact', 'KafkaReact', 0, 0, NULL, '', NULL, 0, '', NULL, NULL, NULL, 'Kafka-2.x', 0, '2021-06-01 11:50:07', '2021-06-01 11:50:07', 0, 0);

-- kafka的 address和brokerList的invisible设置为1
update dsc_form_field set invisible = 1 where type_version like "Kafka%" and name = "address" or name = "brokerList";

-- 将kafka的openKerberos属性放到最后

delete from `dsc_form_field` where type_version like "Kafka%" and `name` = "openKerberos";
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	( 'openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Kafka-1.x', 0, '2021-03-23 20:38:07', '2021-03-30 16:08:46', 0, 0),
	( 'openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Kafka-2.x', 0, '2021-03-23 20:38:07', '2021-03-30 16:08:46', 0, 0),
	( 'openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Kafka-0.9', 0, '2021-03-23 20:38:07', '2021-03-30 16:08:46', 0, 0),
	( 'openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Kafka-0.10', 0, '2021-03-23 20:38:07', '2021-03-30 16:08:46', 0, 0),
	( 'openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Kafka-0.11', 0, '2021-03-23 20:38:07', '2021-03-30 16:08:46', 0, 0);

-- 数据源LibrA改名为GaussDB
update dsc_type  set data_type = 'GaussDB',img_url = 'GaussDB.png' where data_type = 'LibrA';

-- 数据源和产品映射表修改LibrA为GaussDB
update dsc_app_mapping set data_type = 'GaussDB' where data_type = 'LibrA';

-- 数据源模版表单属性表修改LibrA为GaussDB
update dsc_form_field set type_version = 'GaussDB' where type_version = 'LibrA';



-- 数据源给资产授权 Phoenix5.x,HBase1.x , kafka0.11,kafka2.x
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
    ( 9, 'Phoenix', '5.x', 0, '2021-06-03 14:56:21', '2021-06-03 14:56:21', 0, 0),
	(9, 'HBase', '1.x', 0, '2021-06-03 14:56:21', '2021-06-03 14:56:21', 0, 0),
	(9, 'Kafka', '0.10', 0, '2021-06-03 14:56:21', '2021-06-03 14:56:21', 0, 0),
    (9, 'Kafka', '2.x', 0, '2021-06-03 14:56:21', '2021-06-03 14:56:21', 0, 0)
   ;


-- dsc_info表增加字段数据源类型编码
ALTER TABLE `dsc_info` ADD COLUMN `data_type_code` tinyint(4) NOT NULL COMMENT '数据源类型编码' AFTER `dtuic_tenant_id`;


-- 修改数据源data_type_code值
update dsc_info
	set data_type_code =
	case
when data_type = "Vertica"
	then 43
when data_type = "MySQL"
	then 1
when data_type = "MySQL8"
	then 1001
when data_type = "MySQL PXC"
	then 98
when data_type = "PolarDB for MySQL8"
	then 28
when data_type = "Oracle"
	then 2
when data_type = "SQLServer"
	then 3
when data_type = "SQLServer_2017_LATER"
	then 32
when data_type = "PostgreSQL"
	then 4
when data_type = "ADB_PostgreSQL"
	then 49
when data_type = "DB2"
	then 19
when data_type = "DMDB"
	then 35
when data_type = "RDBMS"
	then 5
when data_type = "KingbaseES8"
	then 40
when data_type = "Hive" and data_version = "1.x"
	then 27
when data_type = "Hive" and data_version = "2.x"
	then 7
when data_type = "Hive" and data_version = "3.x"
	then 50
when data_type = "SparkThrift"
	then 45
when data_type = "Maxcompute"
	then 10
when data_type = "Greenplum"
	then 36
when data_type = "LibrA"
	then 21
when data_type = "GBase_8a"
	then 22
when data_type = "HDFS"
	then 6
when data_type = "FTP"
	then 9
when data_type = "Impala"
	then 29
when data_type = "ClickHouse"
	then 25
when data_type = "TiDB"
	then 31
when data_type = "CarbonData"
	then 20
when data_type = "TiDB"
	then 31
when data_type = "Kudu"
	then 24
when data_type = "Kylin"
	then 23
when data_type = "HBase" and data_version = "1.x"
	then 8
when data_type = "HBase" and data_version = "2.x"
	then 39
when data_type = "Phoenix" and data_version = "4.x"
	then 30
when data_type = "Phoenix" and data_version = "5.x"
	then 38
when data_type = "Elasticsearch" and data_version = "5.x"
	then 11
when data_type = "Elasticsearch" and data_version = "6.x"
	then 33
when data_type = "Elasticsearch" and data_version = "7.x"
	then 46
when data_type = "Phoenix"
	then 38
when data_type = "MongoDB"
	then 13
when data_type = "Redis"
	then 12
when data_type = "S3"
	then 41
when data_type = "Kafka" and data_version = "1.x"
	then 26
when data_type = "Kafka" and data_version = "2.x"
	then 37
when data_type = "Kafka" and data_version = "0.9"
	then 18
when data_type = "Kafka" and data_version = "0.10"
	then 17
when data_type = "Kafka" and data_version = "0.11"
	then 14
when data_type = "EMQ"
	then 34
when data_type = "WebSocket"
	then 42
when data_type = "Vertica"
	then 43
when data_type = "Socket"
	then 44
when data_type = "AnalyticDB"
	then 15
when data_type = "Presto"
	then 48
when data_type = "Solr" and data_version = "7.x"
	then 53
when data_type = "InfluxDB" and data_version = "1.x"
	then 55
	else 0
    end ;


-- 新增InfluxDB数据源

-- 调整dsc_classify表数据的sorted值
update `dsc_classify` set `sorted` = 100 where classify_code = 'total';
update `dsc_classify` set `sorted` = 90 where classify_code = 'mostUse';
update `dsc_classify` set `sorted` = 80 where classify_code = 'relational';
update `dsc_classify` set `sorted` = 70 where classify_code = 'bigData';
update `dsc_classify` set `sorted` = 60 where classify_code = 'mpp';
update `dsc_classify` set `sorted` = 50 where classify_code = 'semiStruct';
update `dsc_classify` set `sorted` = 40 where classify_code = 'analytic';
update `dsc_classify` set `sorted` = 30 where classify_code = 'NoSQL';
update `dsc_classify` set `sorted` = 20 where classify_code = 'actualTime';
update `dsc_classify` set `sorted` = 0 where classify_code = 'api';

-- dsc_classify表新增时序类型数据
INSERT INTO `dsc_classify` (`id`,`classify_code`, `sorted`, `classify_name`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	(11,'sequential', 10, '时序数据库', 0, '2021-06-09 17:19:27', '2021-06-09 17:19:27', 0, 0);

-- 往dsc_type表新增 InfluxDB类型数据源
INSERT INTO `dsc_type` (`data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
   ('InfluxDB', 11, 10.0, 'InfluxDB.png', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0, 875, 0);

-- 在数据源版本表dsc_version中新增一条数据
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 'InfluxDB', '1.x', 0, 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0);

-- 在数据源和产品映射表dsc_app_mapping表中新增一条数据
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 1, 'InfluxDB', '1.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0);

-- dsc_form_field表新增几条和InfluxDB相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	('jdbcUrl', 'URL', 'Input', 1, 0, NULL, 'http://localhost:8086', NULL, 1, '{\"regex\":{\"message\":\"JDBC URL格式不符合规则!\"}}', NULL, NULL, '/http:\\/\\/([\\w, .])+:(.)+/', 'InfluxDB-1.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
('username', '用户名', 'Input', 0, 0, NULL, NULL, NULL, 1, '', NULL, NULL, NULL, 'InfluxDB-1.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	('password', '密码', 'Password', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'InfluxDB-1.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0);


-- 新增hive3.x数据源

-- 在数据源版本表dsc_version中新增一条数据
INSERT INTO `dsc_version` (`data_type`, `data_version`, `sorted`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)VALUES
	( 'Hive', '3.x', 2, 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0);


-- 在数据源和产品映射表dsc_app_mapping表中新增一条数据
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
	(1, 'Hive', '3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	(7, 'Hive', '3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0);

-- dsc_form_field表新增几条和Hive3.x相关的数据
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
   ('jdbcUrl', 'JDBC URL', 'Input', 1, 0, NULL, NULL, NULL, 1, '{\"regex\":{\"message\":\"JDBC URL格式不符合规则!\"}}', '示例：jdbc:hive://host:port/dbName', NULL, '/jdbc:(\\w|:)+:\\/\\/(.)+/', 'Hive-3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	('username', '用户名', 'Input', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Hive-3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	('password', '密码', 'Password', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Hive-3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	('defaultFS', 'defaultFS', 'Input', 1, 0, NULL, 'hdfs://host:port', NULL, 1, '', NULL, NULL, NULL, 'Hive-3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	('hadoopConfig', '高可用配置', 'TextAreaWithCopy', 0, 0, NULL, '{\n\"dfs.nameservices\": \"defaultDfs\", \n\"dfs.ha.namenodes.defaultDfs\": \"namenode1\", \n\"dfs.namenode.rpc-address.defaultDfs.namenode1\": \"\", \n\"dfs.client.failover.proxy.provider.defaultDfs\": \"org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider\" \n}', NULL, 0, '', '高可用模式下的填写规则：\n1、分别要填写：nameservice名称、 namenode名称（多个以逗号分隔）、proxy.provider参数；\n2、所有参数以JSON格式填写；\n3、格式为：\n\"dfs.nameservices\": \"nameservice名称\", \"dfs.ha.namenodes.nameservice名称\": \"namenode名称，以逗号分隔\", \"dfs.namenode.rpc-address.nameservice名称.namenode名称\": \"\", \"dfs.namenode.rpc-address.nameservice名称.namenode名称\": \"\", \"dfs.client.failover.proxy.provider.\nnameservice名称\": \"org.apache.hadoop.\nhdfs.server.namenode.ha.\nConfiguredFailoverProxyProvider\"\n4、详细参数含义请参考《帮助文档》或<a href=\'http://hadoop.apache.org/docs/r2.7.4/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html\'>Hadoop官方文档</a>', NULL, NULL, 'Hive-3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0),
	('openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Hive-3.x', 0, '2021-06-09 14:49:27', '2021-06-09 14:49:42', 0, 0);
