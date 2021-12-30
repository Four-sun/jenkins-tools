--  ## 更改原先的Hadoop默认数据源类型为SparkThrift.
update rdos_batch_data_source set type=45 where is_default=1 and type=7 and is_deleted=0;


INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES ('1', 'SparkThrift2.x', '45', 'SparkThrift2.x', 'SparkThrift2.x', '45', now(), now(), '0');