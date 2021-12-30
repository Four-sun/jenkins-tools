DELETE FROM rdos_dict where type=1;


INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
  ('1', 'MySQL', '1', 'MySQL', 'MySQL', '1', now(), now(), '0'),
  ('1', 'Oracle', '2', 'Oracle', 'Oracle', '2', now(), now(), '0'),
  ('1', 'SQLServer', '3', 'SQLServer', 'SQLServer', '3', now(), now(), '0'),
  ('1', 'PostgreSQL', '4', 'PostgreSQL', 'PostgreSQL', '4', now(), now(), '1'),
  ('1', 'RDBMS', '5', 'RDBMS', '其他关系型数据库', '5', now(), now(), '1'),
  ('1', 'Hive', '7', 'HIVE', 'HIVE', '6', now(), now(), '0'),
  ('1', 'HBase', '8', 'HBASE', 'HBASE', '7', now(), now(), '0'),
  ('1', 'FTP', '9', 'FTP', 'FTP', '8', now(), now(), '0'),
  ('1', 'MaxCompute', '10', 'MaxCompute', 'MaxCompute', '9', now(), now(), '0'),
  ('1', 'ElasticSearch', '11', 'ElasticSearch', 'ElasticSearch', '10', now(), now(), '0'),
  ('1', 'Redis', '12', 'Redis', 'Redis', '11', now(), now(), '0'),
  ('1', 'MongoDB', '13', 'MongoDB', 'MongoDB', '12', now(), now(), '0'),
  ('1', 'BEATS', '16', 'Beats', 'Beats', '13', now(), now(), '0'),
  ('1', 'KAFKA_09', '18', 'Kafka2.09', 'Kafka2.09', '14', now(), now(), '0'),
  ('1', 'KAFKA_10', '17', 'Kafka2.10', 'Kafka2.10', '15', now(), now(), '0'),
  ('1', 'KAFKA_11', '14', 'Kafka2.11', 'Kakfa2.11', '16', now(), now(), '0'),
  ('1', 'HDFS', '6', 'HDFS', 'HDFS', '17', now(), now(), '0');