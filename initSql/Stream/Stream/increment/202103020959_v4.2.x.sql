alter table rdos_stream_alarm add column modified_user_id int(11) null comment '修改人';

update rdos_stream_alarm set modified_user_id = create_user_id where modified_user_id is null;

alter table rdos_stream_alarm modify column modified_user_id int(11) not null comment '修改人';