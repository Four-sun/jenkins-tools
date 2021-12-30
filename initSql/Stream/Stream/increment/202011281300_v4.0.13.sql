alter table rdos_stream_package_item
	add is_update_strategy tinyint default 0 null COMMENT '更新启停策略：0-不更新，1-更新';