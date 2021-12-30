-- V3.10.0_beta.3 增加sqlserver cdc采集
-- V3.10.0_beta.3 kafka版本整理
INSERT INTO `rdos_dict`
(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('1', 'SQLServer_2017_later', '32', 'SQLServer_2017_later', 'SQLServer_2017_later', '32', now(), now(), '0');

UPDATE rdos_dict SET dict_name_zh = 'Kafka_0.11', dict_name_en = 'Kafka_0.11' WHERE type =1 and dict_value = 14;
UPDATE rdos_dict SET dict_name_zh = 'Kafka_0.10', dict_name_en = 'Kafka_0.10' WHERE type =1 and dict_value = 17;
UPDATE rdos_dict SET dict_name_zh = 'Kafka_0.9', dict_name_en = 'Kafka_0.9' WHERE type =1 and dict_value = 18;
UPDATE rdos_dict SET dict_name_zh = 'Kafka_1.0', dict_name_en = 'Kafka_1.0' WHERE type =1 and dict_value = 26;
