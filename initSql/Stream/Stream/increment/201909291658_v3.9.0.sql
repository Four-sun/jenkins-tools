-- 增加系统属性字段
ALTER TABLE rdos_stream_resource ADD COLUMN `is_system` TINYINT (1) NOT NULL DEFAULT 0 COMMENT '0用户 1系统' AFTER `is_deleted`;

-- 增加解析时间获取秒值、毫秒值的自定义函数
INSERT INTO rdos_stream_resource (`tenant_id`,`project_id`,`node_pid`,`url`,`resource_type`,`resource_name`,`origin_file_name`,`resource_desc`,`gmt_create`,`gmt_modified`,`create_user_id`,`is_deleted`,`is_system`) VALUES (-1,-1,-1,'hdfs://ns1/dtInsight/stream/udf/streamudf-1.0-SNAPSHOT.jar',1,'timeParser','streamudf-1.0-SNAPSHOT.jar','解析时间获取秒值、毫秒值的自定义函数',NOW(),NOW(),-1,0,1);

SET @date=(SELECT id FROM rdos_stream_catalogue WHERE node_name='日期函数');
SET @id=(SELECT id FROM rdos_stream_resource WHERE resource_name='timeParser' AND is_system=1 LIMIT 1);
INSERT INTO rdos_stream_function (`udf_type`,`name`,`class_name`,`resource_id`,`purpose`,`command_format`,`param_desc`,`node_pid`,`tenant_id`,`project_id`,`create_user_id`,`modify_user_id`,`type`,`gmt_create`,`gmt_modified`,`is_deleted`) VALUES (0,'TIMETOSECOND','com.dtstack.flink.streamudf.udf.TimeToSecondUdf',@id,'时间转秒值','TIMETOSECOND(timestamp, format)','根据指定format将varchar类型的timestamp返回bigint秒值\r\n比如:TIMETOSECOND(ts, \'yyyy-MM-dd HH:mm:ss\')',@date,-1,-1,-1,-1,1,NOW(),NOW(),0);
INSERT INTO rdos_stream_function (`udf_type`,`name`,`class_name`,`resource_id`,`purpose`,`command_format`,`param_desc`,`node_pid`,`tenant_id`,`project_id`,`create_user_id`,`modify_user_id`,`type`,`gmt_create`,`gmt_modified`,`is_deleted`) VALUES (0,'TIMETOMILLISECOND','com.dtstack.flink.streamudf.udf.TimeToMilliSecondUdf',@id,'时间转毫秒值','TIMETOMILLISECOND(timestamp, format)','根据指定format将varchar类型的timestamp返回bigint毫秒值\r\n比如:TIMETOMILLISECOND(ts, \'yyyy-MM-dd HH:mm:ss SSS\')',@date,-1,-1,-1,-1,1,NOW(),NOW(),0);