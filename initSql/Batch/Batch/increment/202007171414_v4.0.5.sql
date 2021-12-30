
-- 修改操作表的 字段类型
alter table rdos_user_operator_permission  modify column operator_id int(11) NOT NULL COMMENT '操作类型';
