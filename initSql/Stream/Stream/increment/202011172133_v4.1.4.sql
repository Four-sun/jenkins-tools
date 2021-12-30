CREATE TABLE `rdos_stream_support_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '1.数据源 2.FlinkSql_源表 3.FlinkSql_结果表 4.FlinkSql_维表 5.实时采集_向导模式_源表 6.实时采集_向导模式_结果表 7.实时采集_脚本模式_源表 8.实时采集_脚本模式_结果表',
  `data_source_name` varchar(256) NOT NULL DEFAULT '' COMMENT '数据源名称',
  `data_source_value` int(11) NOT NULL DEFAULT '0' COMMENT '数据源值',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_type_data_source_name` (`type`,`data_source_name`),
  UNIQUE KEY `index_type_data_source_value` (`type`,`data_source_value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='数据源支持表';


insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MySQL', '1', now(), now(), '0', '1', '1');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'SQLServer_2017_later', '2', now(), now(), '0', '1', '32');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Oracle', '3', now(), now(), '0', '1', '2');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'PostgreSQL', '5', now(), now(), '0', '1', '4');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'DB2', '7', now(), now(), '0', '1', '19');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'CLICKHOUSE', '9', now(), now(), '0', '1', '25');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Polardb for MySQL 8', '11', now(), now(), '0', '1', '28');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'KingbaseES8', '13', now(), now(), '0', '1', '40');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HIVE', '15', now(), now(), '0', '1', '7');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Impala', '17', now(), now(), '0', '1', '29');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kudu', '19', now(), now(), '0', '1', '24');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'TiDB', '21', now(), now(), '0', '1', '31');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HDFS', '23', now(), now(), '0', '1', '6');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HBASE', '25', now(), now(), '0', '1', '8');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'ElasticSearch', '27', now(), now(), '0', '1', '11');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'ElasticSearch6', '29', now(), now(), '0', '1', '33');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MongoDB', '31', now(), now(), '0', '1', '13');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Redis', '33', now(), now(), '0', '1', '12');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.11', '35', now(), now(), '0', '1', '14');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', '37', now(), now(), '0', '1', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9', '39', now(), now(), '0', '1', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X', '41', now(), now(), '0', '1', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'EMQ', '43', now(), now(), '0', '1', '34');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X', '45', now(), now(), '0', '1', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Polardb for MySQL 8', '47', now(), now(), '0', '7', '28');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MySQL', '49', now(), now(), '0', '7', '1');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'TiDB', '51', now(), now(), '0', '7', '31');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'BEATS', '53', now(), now(), '0', '7', '16');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9', '55', now(), now(), '0', '7', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', '57', now(), now(), '0', '7', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X', '61', now(), now(), '0', '7', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X', '65', now(), now(), '0', '7', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Oracle', '67', now(), now(), '0', '7', '2');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HIVE', '69', now(), now(), '0', '8', '7');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9', '71', now(), now(), '0', '8', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', '73', now(), now(), '0', '8', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.11', '75', now(), now(), '0', '8', '14');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X', '77', now(), now(), '0', '8', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X', '79', now(), now(), '0', '8', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Polardb for MySQL 8', '81', now(), now(), '0', '5', '28');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MySQL', '83', now(), now(), '0', '5', '1');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X', '85', now(), now(), '0', '5', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9', '87', now(), now(), '0', '5', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', '89', now(), now(), '0', '5', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.11', '91', now(), now(), '0', '5', '14');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X', '93', now(), now(), '0', '5', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Oracle', '95', now(), now(), '0', '5', '2');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'SQLServer_2017_later', '97', now(), now(), '0', '5', '32');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'EMQ', '99', now(), now(), '0', '5', '34');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'DB2', '101', now(), now(), '0', '5', '19');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'EMQ', '103', now(), now(), '0', '6', '34');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HIVE', '105', now(), now(), '0', '6', '7');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HDFS', '107', now(), now(), '0', '6', '6');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9', '109', now(), now(), '0', '6', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', '111', now(), now(), '0', '6', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X', '113', now(), now(), '0', '6', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X', '115', now(), now(), '0', '6', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `id`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.11', '117', now(), now(), '0', '6', '14');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9',  now(), now(), '0', '2', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', now(), now(), '0', '2', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X',  now(), now(), '0', '2', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X',  now(), now(), '0', '2', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.11', now(), now(), '0', '2', '14');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MySQL', now(), now(), '0', '3', '1');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Polardb for MySQL 8', now(), now(), '0', '3', '28');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Oracle', now(), now(), '0', '3', '2');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'TiDB', now(), now(), '0', '3', '31');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'CLICKHOUSE', now(), now(), '0', '3', '25');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'PostgreSQL', now(), now(), '0', '3', '4');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kudu', now(), now(), '0', '3', '24');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Impala', now(), now(), '0', '3', '29');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HBASE', now(), now(), '0', '3', '8');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'ElasticSearch', now(), now(), '0', '3', '11');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'ElasticSearch6', now(), now(), '0', '3', '33');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Redis', now(), now(), '0', '3', '12');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MongoDB', now(), now(), '0', '3', '13');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'KingbaseES8', now(), now(), '0', '3', '40');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.11', now(), now(), '0', '3', '14');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.10', now(), now(), '0', '3', '17');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_0.9', now(), now(), '0', '3', '18');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_1.X', now(), now(), '0', '3', '26');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kafka_2.X', now(), now(), '0', '3', '37');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MySQL', now(), now(), '0', '4', '1');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Polardb for MySQL 8', now(), now(), '0', '4', '28');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Oracle', now(), now(), '0', '4', '2');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'TiDB', now(), now(), '0', '4', '31');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'CLICKHOUSE', now(), now(), '0', '4', '25');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'PostgreSQL', now(), now(), '0', '4', '4');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Kudu', now(), now(), '0', '4', '24');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Impala', now(), now(), '0', '4', '29');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'HBASE', now(), now(), '0', '4', '8');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'ElasticSearch6', now(), now(), '0', '4', '33');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Redis', now(), now(), '0', '4', '12');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'MongoDB', now(), now(), '0', '4', '13');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'KingbaseES8', now(), now(), '0', '4', '40');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'WebSocket', now(), now(), '0', '1', '42');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'WebSocket', now(), now(), '0', '5', '42');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'WebSocket', now(), now(), '0', '7', '42');

