-- 增加解析时间获取秒值、毫秒值的自定义函数
UPDATE rdos_stream_resource SET is_deleted=1 WHERE resource_name='timeParser' AND is_system=1;

INSERT INTO rdos_stream_resource (`tenant_id`,`project_id`,`node_pid`,`url`,`resource_type`,`resource_name`,`origin_file_name`,`resource_desc`,`gmt_create`,`gmt_modified`,`create_user_id`,`is_deleted`,`is_system`) VALUES (-1,-1,-1,'hdfs://ns1/dtInsight/stream/udf/streamudf.timetosecond-1.0-SNAPSHOT.jar',1,'timeToSecondUdf','streamudf.timetosecond-1.0-SNAPSHOT.jar','解析时间获取秒值的自定义函数',NOW(),NOW(),-1,0,1);
INSERT INTO rdos_stream_resource (`tenant_id`,`project_id`,`node_pid`,`url`,`resource_type`,`resource_name`,`origin_file_name`,`resource_desc`,`gmt_create`,`gmt_modified`,`create_user_id`,`is_deleted`,`is_system`) VALUES (-1,-1,-1,'hdfs://ns1/dtInsight/stream/udf/streamudf.timetomillisecond-1.0-SNAPSHOT.jar',1,'timeToMilliSecondUdf','streamudf.timetomillisecond-1.0-SNAPSHOT.jar','解析时间获取毫秒值的自定义函数',NOW(),NOW(),-1,0,1);

SET @id1=(SELECT id FROM rdos_stream_resource WHERE resource_name='timeToSecondUdf' AND is_system=1 LIMIT 1);
SET @id2=(SELECT id FROM rdos_stream_resource WHERE resource_name='timeToMilliSecondUdf' AND is_system=1 LIMIT 1);
UPDATE rdos_stream_function SET resource_id=@id1 WHERE name='TIMETOSECOND';
UPDATE rdos_stream_function SET resource_id=@id2 WHERE name='TIMETOMILLISECOND';