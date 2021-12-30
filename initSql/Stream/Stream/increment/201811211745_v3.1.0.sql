INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
  ('1', 'KAFKA_10', '17', 'Kafka2.10', 'Kafka2.10', '17', now(), now(), '0'),
  ('1', 'KAFKA_09', '18', 'Kafka2.09', 'Kafka2.09', '18', now(), now(), '0');

UPDATE rdos_dict set dict_name = 'KAFKA_11',dict_name_zh='Kafka2.11',dict_name_en='Kakfa2.11' where dict_name = 'KAFKA';


ALTER TABLE `rdos_stream_alarm_record`
ADD COLUMN `receive_user` VARCHAR(512) COMMENT '告警接收人' after `alarm_content`;


alter table `rdos_stream_alarm` modify column threshold varchar(50) comment "阈值";