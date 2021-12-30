alter table `rdos_stream_alarm` add alarm_data_source varchar(200) null comment '告警数据源';
alter table `rdos_stream_alarm` add trigger_index tinyint(1) null comment '触发指标';
alter table `rdos_stream_alarm` add compare_op tinyint(1) null comment '比较符';