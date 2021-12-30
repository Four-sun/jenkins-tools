UPDATE `rdos_dict` SET dict_name_zh = 'Kafka_1.X', dict_name_en = 'Kafka_1.X' WHERE type =1 and dict_value = 26;

INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('1', 'KAFKA_2X', '37', 'Kafka_2.X', 'Kafka_2.X', '37', now(), now(), '0');