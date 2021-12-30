-- 移除添加kafka_0.9的数据源
update `rdos_stream_support_data_source`  set is_deleted = 1 where `data_source_value` = 18 and `type` = 1;