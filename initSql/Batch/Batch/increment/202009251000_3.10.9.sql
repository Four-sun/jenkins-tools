-- 修改操作表的 字段类型
alter table rdos_user_operator_permission  modify column operator_id int(11) NOT NULL COMMENT '操作类型';

insert into rdos_user_operator_permission (tenant_id,project_id,user_id,operator_id,type,table_id,apply_id,gmt_create,gmt_modified,is_deleted)
 select tenant_id,project_id,user_id,600,0,resource_id,id,now(),now(),0 from rdos_batch_apply where id not in  (select DISTINCT apply_id from rdos_user_operator_permission where is_deleted =0);



 update rdos_user_operator_permission
 set operator_id = 800
 where type = 1;

 update rdos_user_operator_permission
 set operator_id = 700
 where type = 2;